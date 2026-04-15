import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_demo/core/data/database/secure_storage_helper.dart';
import 'package:login_demo/features/home/home_navigator.dart';
import 'package:login_demo/navigator/app_router.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeNavigator navigator;

  HomeCubit({required this.navigator}) : super(HomeState());

  void init() {
    getUserInfo();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      navigator.flushbarNavigator.showSuccess(message: "Đăng nhập thành công");
    });
  }

  void getUserInfo() async {
    final userInfo = await SecureStorageHelper.instance.getUserInfo();
    emit(state.copyWith(userInfo: userInfo));
  }

  void handleLogout() async {
    await navigator.appDialog.show(
      message: "Bạn có muốn đăng xuất không?",
      textConfirm: "Đăng xuất",
      textCancel: "Huỷ",
      onConfirm: () {
        SecureStorageHelper.instance.refreshStorage();
        emit(state.copyWith(userInfo: null));
        AppRouter.markUnauthenticated();
      },
      onCancel: () {
        navigator.navigateBack();
      },
    );
  }
}
