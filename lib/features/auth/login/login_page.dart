import 'package:flutter/material.dart';
import 'package:login_demo/core/constants/asset_constants.dart';
import 'package:login_demo/core/extensions/num_extension.dart';
import 'package:login_demo/core/widget/button/app_icon_text_button.dart';
import 'package:login_demo/core/widget/button/app_password_text_field.dart';
import 'package:login_demo/core/widget/button/app_text_field.dart';
import 'package:login_demo/core/widget/image/app_svg_image.dart';
import 'package:login_demo/core/widget/textfield/app_text_button.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return LoginPageChild();
  }
}

class LoginPageChild extends StatefulWidget {
  const LoginPageChild({super.key});

  @override
  State<LoginPageChild> createState() => _LoginPageChildState();
}

class _LoginPageChildState extends State<LoginPageChild> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _buildBody());
  }

  Widget _buildBody() {
    return Padding(
      padding: 16.paddingAll,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [_buiLoginForm(), _buildGroupButton()],
      ),
    );
  }

  Widget _buiLoginForm() {
    return SingleChildScrollView(
      child: Column(
        spacing: 24,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          76.height,
          AppSvgImage(AssetConstants.logoApp),
          AppTextField(labelText: "Mã số thuế", hintText: "Mã số thuế"),
          AppTextField(labelText: "Tài khoản", hintText: "Tài khoản"),
          AppPasswordTextField(
            controller: TextEditingController(),
            obscureTextController: ObscureTextController(),
            labelText: "Mật khẩu",
            hintText: "Mật khẩu",
          ),

          AppTextButton(
            title: "Đăng nhâp",
            width: MediaQuery.widthOf(context),
            onTap: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildGroupButton() {
    return Padding(
      padding: 8.paddingVertical,
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
