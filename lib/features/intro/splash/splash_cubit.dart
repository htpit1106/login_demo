import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_demo/core/configs/app_configs.dart';
import 'package:login_demo/core/data/database/secure_storage_helper.dart';

import 'package:login_demo/features/intro/splash/splash_navigator.dart';
import 'package:login_demo/features/intro/splash/splash_state.dart';
import 'package:login_demo/navigator/app_router.dart';

class SplashCubit extends Cubit<SplashState> {
  DateTime? _showTime;
  final SplashNavigator navigator;

  SplashCubit({required this.navigator}) : super(SplashState());

  void init() {
    autoLogin();
  }

  Future<void> autoLogin() async {
    final isLoggedIn = await checkLogin();
    _ensureMinSplashTime();
    if (isLoggedIn) {
      AppRouter.markAuthenticated();
      navigator.openHome();
    } else {
      AppRouter.markUnauthenticated();
      navigator.openLoginPage();
    }
  }

  Future<bool> checkLogin() async {
    _showTime = DateTime.now();
    final accessToken = await SecureStorageHelper.instance.getAccessToken();
    if (accessToken != null) {
      return accessToken["sessionToken"] != null;
    }
    return false;
  }

  Future<void> _ensureMinSplashTime() async {
    final elapsed = DateTime.now().difference(_showTime ?? DateTime.now());
    const minDuration = AppConfigs.splashMinDisplayTime;
    if (elapsed < minDuration) {
      await Future.delayed(minDuration - elapsed);
    }
  }
}
