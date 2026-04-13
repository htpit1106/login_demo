import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static final navigationKey = GlobalKey<NavigatorState>();

  AppRouter._();

  static final ValueNotifier<_AuthStatus> _authStatusNotifier =
      ValueNotifier<_AuthStatus>(_AuthStatus.unknow);

  static void markAuthenticated() {
    _authStatusNotifier.value = _AuthStatus.authenticated;
  }

  static void markUnauthenticated() {
    _authStatusNotifier.value = _AuthStatus.unauthenticated;
  }

  static const String _splashPath = '/';
  static const String _loginPath = '/login';
  static const String _homePath = '/home';

  static const String splashRouteName = 'splash';
  static const String loginRouteName = 'login';
  static const String homeName = 'home';

  static final GoRouter router = GoRouter(
    debugLogDiagnostics: kDebugMode,
    initialLocation: _splashPath,
    navigatorKey: navigationKey,
    refreshListenable: _authStatusNotifier,
    redirect: (BuildContext context, GoRouterState state) async {
      if (_authStatusNotifier.value == _AuthStatus.unknow) {
        return _splashPath;
      }
      if (_authStatusNotifier.value == _AuthStatus.unauthenticated) {
        return _loginPath;
      }
      return null;
    },
    routes: [],
  );
}

enum _AuthStatus { unknow, authenticated, unauthenticated }
