import 'package:flutter/material.dart';
import 'package:login_demo/core/theme/text_style.dart';
import 'package:login_demo/core/widget/textfield/app_text_button.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return HomePageChild();
  }
}

class HomePageChild extends StatefulWidget {
  const HomePageChild({super.key});

  @override
  State<HomePageChild> createState() => _HomePageChildState();
}

class _HomePageChildState extends State<HomePageChild> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Full name
                  Text('full name', style: AppTextStyle.black.s20.w700),

                  const SizedBox(height: 8),

                  // Username
                  Text("username", style: AppTextStyle.hintStyle.s14.w400),

                  const SizedBox(height: 24),

                  // Logout button
                  SizedBox(
                    width: double.infinity,
                    child: AppTextButton(title: "Đăng xuất", onTap: () {}),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
