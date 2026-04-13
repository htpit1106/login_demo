import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_demo/core/configs/app_configs.dart';
import 'package:login_demo/core/utils/utils.dart';

import 'navigator/app_router.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        hideKeyboard(context);
      },
      child: MaterialApp.router(
        title: AppConfigs.appName,
        theme: ThemeData.light(
          useMaterial3: true,
        ).copyWith(scaffoldBackgroundColor: Colors.white),
        themeMode: ThemeMode.light,
        routerConfig: AppRouter.router,
      ),
    );
  }
}
