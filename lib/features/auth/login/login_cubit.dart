import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_demo/core/data/database/hive_helper.dart';
import 'package:login_demo/core/data/database/secure_storage_helper.dart';
import 'package:login_demo/core/data/model/entities/account_entity.dart';
import 'package:login_demo/core/data/model/enums/load_status.dart';
import 'package:login_demo/core/data/repositories/auth_repository.dart';
import 'package:login_demo/core/utils/utils.dart';
import 'package:login_demo/core/widget/button/app_password_text_field.dart';
import 'package:login_demo/features/auth/login/login_navigator.dart';
import 'package:login_demo/features/auth/login/login_state.dart';
import 'package:login_demo/navigator/app_router.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthRepository authRepository;
  final LoginNavigator navigator;

  LoginCubit({required this.authRepository, required this.navigator})
    : super(const LoginState());
  final loginFormKey = GlobalKey<FormState>();
  final TextEditingController mstController = TextEditingController();
  final TextEditingController accountController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final ObscureTextController obscureTextController = ObscureTextController();
  final FocusNode mstFocusNode = FocusNode();
  final FocusNode accountFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();

  void init() {
    createAccount();
  }

  void createAccount() {
    final salt = generateSalt();
    final account = AccountEntity(
      taxIdOrId: "0105987432-098",
      username: "demo",
      passwordHash: hashPassword("123456", salt),
      salt: salt,
      fullName: "Demo User",
      enable: true,
      updateAt: DateTime.now(),
    );

    authRepository.createAccount(account);
  }

  void isSubmitted() {
    if (state.isSubmit) return;
    emit(state.copyWith(isSubmit: true));
  }

  Future<void> onSubmit() async {
    if (state.loadLoginStatus == LoadStatus.loading) return;
    emit(state.copyWith(loadLoginStatus: LoadStatus.loading));

    final AccountEntity? account = await authRepository.login(
      mstController.text,
    );
    if (account == null) {
      _onAccountNotFound();
    } else {
      _handleLogin(account);
    }
  }

  void _onAccountNotFound() async {
    emit(state.copyWith(loadLoginStatus: LoadStatus.failure));
    if (!await checkInternetConnect()) {
      navigator.flushbarNavigator.showError(
        message: "Không có kết nối internet",
      );
      return;
    }
    navigator.flushbarNavigator.showError(message: "Tài khoản không tồn tại");
  }

  void _handleLogin(AccountEntity account) async {
    // neus lockuti < datetime.now
    if (account.enable == false) {
      if (account.lockUntil != null &&
          !DateTime.now().isBefore(account.lockUntil!)) {
        _handleExpiredLockLogin(account);
      } else {
        emit(
          state.copyWith(
            isLoginCountLimit: true,
            loadLoginStatus: LoadStatus.failure,
          ),
        );
      }
    }
    bool isVerify = _verifyLoginInfo(account);

    if (!isVerify) {
      await _checkLoginCountLimit(mstController.text);
      navigator.flushbarNavigator.showError(
        message: state.isLoginCountLimit
            ? "Tài khoản đã bị khóa"
            : "Thông tin đăng nhập không hợp lệ",
      );
      return;
    }
    navigator.flushbarNavigator.showSuccess(message: "Đăng nhập thành công");
    final sessionToken = generateSessionToken(account.username!);
    SecureStorageHelper.instance.saveAccessToken(
      username: account.username!,
      sessionToken: sessionToken,
    );
    AppRouter.markAuthenticated();
    emit(state.copyWith(loadLoginStatus: LoadStatus.success));
    navigator.openHome();
  }

  Future<void> _checkLoginCountLimit(String taxIdOrId) async {
    final account = await HiveHelper.instance.getAccount(taxIdOrId);
    if (account == null) return;

    final newCount = (account.failedLoginCount ?? 0) + 1;

    await HiveHelper.instance.saveAccount(
      account.copyWith(failedLoginCount: newCount),
    );

    if (newCount >= 3) {
      emit(state.copyWith(isLoginCountLimit: true));
      await authRepository.lockUser(taxIdOrId);
    }
  }

  bool _verifyLoginInfo(AccountEntity account) {
    final passwordHash = hashPassword(passwordController.text, account.salt!);

    if (passwordHash != account.passwordHash) {
      emit(state.copyWith(loadLoginStatus: LoadStatus.failure));
      return false;
    }

    if (accountController.text != account.username) {
      emit(state.copyWith(loadLoginStatus: LoadStatus.failure));
      return false;
    }

    return true;
  }

  void _handleExpiredLockLogin(AccountEntity account) {
    HiveHelper.instance.saveAccount(
      account.copyWith(failedLoginCount: 0, lockUntil: null),
    );
    emit(state.copyWith(isLoginCountLimit: false));
  }
}
