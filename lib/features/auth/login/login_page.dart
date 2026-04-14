import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_demo/core/constants/asset_constants.dart';
import 'package:login_demo/core/extensions/num_extension.dart';
import 'package:login_demo/core/utils/validator_utils.dart';
import 'package:login_demo/core/widget/button/app_icon_text_button.dart';
import 'package:login_demo/core/widget/button/app_password_text_field.dart';
import 'package:login_demo/core/widget/button/app_text_field.dart';
import 'package:login_demo/core/widget/image/app_svg_image.dart';
import 'package:login_demo/core/widget/textfield/app_text_button.dart';
import 'package:login_demo/features/auth/login/login_navigator.dart';
import 'package:login_demo/features/auth/login/login_state.dart';

import 'login_cubit.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginCubit>(
      create: (context) => LoginCubit(
        authRepository: context.read(),
        navigator: LoginNavigator(context: context),
      ),
      child: LoginPageChild(),
    );
  }
}

class LoginPageChild extends StatefulWidget {
  const LoginPageChild({super.key});

  @override
  State<LoginPageChild> createState() => _LoginPageChildState();
}

class _LoginPageChildState extends State<LoginPageChild> {
  late final LoginCubit _cubit;

  @override
  void initState() {
    _cubit = context.read<LoginCubit>();
    _cubit.init();
    super.initState();
  }

  @override
  void dispose() {
    _cubit.accountController.dispose();
    _cubit.passwordController.dispose();
    _cubit.mstController.dispose();
    _cubit.accountFocusNode.dispose();
    _cubit.passwordFocusNode.dispose();
    _cubit.mstFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
      bottomNavigationBar: _buildGroupButton(),
    );
  }

  Widget _buildBody() {
    return Padding(padding: 16.paddingAll, child: _buiLoginForm());
  }

  Widget _buiLoginForm() {
    return SingleChildScrollView(
      child: Form(
        key: _cubit.loginFormKey,
        child: Column(
          spacing: 24,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            76.height,
            AppSvgImage(AssetConstants.logoApp),
            AppTextField(
              focusNode: _cubit.mstFocusNode,
              controller: _cubit.mstController,
              labelText: "Mã số thuế",
              hintText: "Mã số thuế",
              validator: (value) => ValidatorUtils.validateMstOrCCCd(value),
              keyboardType: TextInputType.numberWithOptions(
                signed: true,
                decimal: true,
              ),
              onChanged: (_) {
                if (_cubit.isSubmitted) {
                  _cubit.loginFormKey.currentState?.validate();
                }
              },
              textInputAction: TextInputAction.next,
              onSubmitted: (_) {
                FocusScope.of(context).requestFocus(_cubit.accountFocusNode);
              },
            ),
            AppTextField(
              focusNode: _cubit.accountFocusNode,
              controller: _cubit.accountController,
              labelText: "Tài khoản",
              hintText: "Tài khoản",
              validator: (value) => ValidatorUtils.validateRequiredField(
                value,
                title: "Tài khoản",
              ),
              onChanged: (_) {
                if (_cubit.isSubmitted) {
                  _cubit.loginFormKey.currentState?.validate();
                }
              },
              textInputAction: TextInputAction.next,
              onSubmitted: (_) {
                FocusScope.of(context).requestFocus(_cubit.passwordFocusNode);
              },
            ),
            AppPasswordTextField(
              focusNode: _cubit.passwordFocusNode,
              controller: _cubit.passwordController,
              obscureTextController: ObscureTextController(),
              labelText: "Mật khẩu",
              hintText: "Mật khẩu",
              validator: (value) => ValidatorUtils.validatePassword(value),
              enableSuffixIcon: true,
              onChanged: (_) {
                if (_cubit.isSubmitted) {
                  _cubit.loginFormKey.currentState?.validate();
                }
              },
              textInputAction: TextInputAction.done,
              onSubmitted: () {
                _handleLoginPressed();
              },
            ),

            AppTextButton(
              title: "Đăng nhâp",
              width: MediaQuery.widthOf(context),
              onTap: () {
                _handleLoginPressed();
              },
            ),
          ],
        ),
      ),
    );
  }

  void _handleLoginPressed() {
    _unfocusTextField();
    _cubit.onSubmit();

    if (_cubit.loginFormKey.currentState?.validate() == true) {}
  }

  void _unfocusTextField() {
    _cubit.accountFocusNode.unfocus();
    _cubit.passwordFocusNode.unfocus();
    _cubit.mstFocusNode.unfocus();
  }

  Widget _buildGroupButton() {
    return Padding(
      padding: EdgeInsetsGeometry.symmetric(horizontal: 16, vertical: 21),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        spacing: 8,
        children: [
          AppIconTextButton(),
          AppIconTextButton(iconPath: AssetConstants.facebook, label: "Group"),
          AppIconTextButton(iconPath: AssetConstants.search, label: "Tra cứu"),
        ],
      ),
    );
  }
}
