import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_demo/features/auth/login/login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(const LoginState());
  final loginFormKey = GlobalKey<FormState>();
  final TextEditingController mstController = TextEditingController();
  final TextEditingController accountController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final FocusNode mstFocusNode = FocusNode();
  final FocusNode accountFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();

  bool get isSubmitted => state.isSubmit;

  void isSubmit() {
    if (state.isSubmit == true) return;
    emit(state.copyWith(isSubmit: true));
  }
}
