import 'package:flutter/material.dart';
import 'package:login_demo/core/widget/button/app_password_text_field.dart';
import 'package:login_demo/core/widget/button/app_text_field.dart';
import 'package:login_demo/core/widget/textfield/app_text_button.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SplashPageChild();
  }
}

class SplashPageChild extends StatefulWidget {
  const SplashPageChild({super.key});

  @override
  State<SplashPageChild> createState() => _SplashPageChildState();
}

class _SplashPageChildState extends State<SplashPageChild> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center());
  }
}
