// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i2;
import 'package:flutter/material.dart' as _i3;

import '../pages/screens.dart' as _i1;

class AppRouter extends _i2.RootStackRouter {
  AppRouter([_i3.GlobalKey<_i3.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i2.PageFactory> pagesMap = {
    SplashRoute.name: (routeData) {
      return _i2.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i1.SplashPage(),
        transitionsBuilder: _i2.TransitionsBuilders.fadeIn,
        opaque: true,
        barrierDismissible: false,
      );
    },
    NoInternetRoute.name: (routeData) {
      return _i2.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i1.NoInternetPage(),
        transitionsBuilder: _i2.TransitionsBuilders.fadeIn,
        opaque: true,
        barrierDismissible: false,
      );
    },
    RegisterRoute.name: (routeData) {
      return _i2.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i1.RegisterPage(),
        transitionsBuilder: _i2.TransitionsBuilders.fadeIn,
        opaque: true,
        barrierDismissible: false,
      );
    },
    LoginRoute.name: (routeData) {
      return _i2.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i1.LoginPage(),
        transitionsBuilder: _i2.TransitionsBuilders.fadeIn,
        opaque: true,
        barrierDismissible: false,
      );
    },
    LandingRoute.name: (routeData) {
      return _i2.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i1.LandingPage(),
        transitionsBuilder: _i2.TransitionsBuilders.fadeIn,
        opaque: true,
        barrierDismissible: false,
      );
    },
    DashboardRoute.name: (routeData) {
      return _i2.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i1.DashboardPage(),
        transitionsBuilder: _i2.TransitionsBuilders.fadeIn,
        opaque: true,
        barrierDismissible: false,
      );
    },
    HomeRoute.name: (routeData) {
      return _i2.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i1.HomePage(),
        transitionsBuilder: _i2.TransitionsBuilders.fadeIn,
        opaque: true,
        barrierDismissible: false,
      );
    },
    ActivityRoute.name: (routeData) {
      return _i2.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i1.ActivityPage(),
        transitionsBuilder: _i2.TransitionsBuilders.fadeIn,
        opaque: true,
        barrierDismissible: false,
      );
    },
    ArticleRoute.name: (routeData) {
      return _i2.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i1.ArticlePage(),
        transitionsBuilder: _i2.TransitionsBuilders.fadeIn,
        opaque: true,
        barrierDismissible: false,
      );
    },
    ProfileRoute.name: (routeData) {
      return _i2.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i1.ProfilePage(),
        transitionsBuilder: _i2.TransitionsBuilders.fadeIn,
        opaque: true,
        barrierDismissible: false,
      );
    },
  };

  @override
  List<_i2.RouteConfig> get routes => [
        _i2.RouteConfig(
          '/#redirect',
          path: '/',
          redirectTo: '/splash',
          fullMatch: true,
        ),
        _i2.RouteConfig(
          SplashRoute.name,
          path: '/splash',
        ),
        _i2.RouteConfig(
          NoInternetRoute.name,
          path: '/no-internet',
        ),
        _i2.RouteConfig(
          RegisterRoute.name,
          path: '/register',
        ),
        _i2.RouteConfig(
          LoginRoute.name,
          path: '/login',
        ),
        _i2.RouteConfig(
          LandingRoute.name,
          path: '/on-boarding',
        ),
        _i2.RouteConfig(
          DashboardRoute.name,
          path: '/dashboard',
          children: [
            _i2.RouteConfig(
              HomeRoute.name,
              path: 'home',
              parent: DashboardRoute.name,
            ),
            _i2.RouteConfig(
              ActivityRoute.name,
              path: 'activity',
              parent: DashboardRoute.name,
            ),
            _i2.RouteConfig(
              ArticleRoute.name,
              path: 'article',
              parent: DashboardRoute.name,
            ),
            _i2.RouteConfig(
              ProfileRoute.name,
              path: 'profile',
              parent: DashboardRoute.name,
            ),
          ],
        ),
      ];
}

/// generated route for
/// [_i1.SplashPage]
class SplashRoute extends _i2.PageRouteInfo<void> {
  const SplashRoute()
      : super(
          SplashRoute.name,
          path: '/splash',
        );

  static const String name = 'SplashRoute';
}

/// generated route for
/// [_i1.NoInternetPage]
class NoInternetRoute extends _i2.PageRouteInfo<void> {
  const NoInternetRoute()
      : super(
          NoInternetRoute.name,
          path: '/no-internet',
        );

  static const String name = 'NoInternetRoute';
}

/// generated route for
/// [_i1.RegisterPage]
class RegisterRoute extends _i2.PageRouteInfo<void> {
  const RegisterRoute()
      : super(
          RegisterRoute.name,
          path: '/register',
        );

  static const String name = 'RegisterRoute';
}

/// generated route for
/// [_i1.LoginPage]
class LoginRoute extends _i2.PageRouteInfo<void> {
  const LoginRoute()
      : super(
          LoginRoute.name,
          path: '/login',
        );

  static const String name = 'LoginRoute';
}

/// generated route for
/// [_i1.LandingPage]
class LandingRoute extends _i2.PageRouteInfo<void> {
  const LandingRoute()
      : super(
          LandingRoute.name,
          path: '/on-boarding',
        );

  static const String name = 'LandingRoute';
}

/// generated route for
/// [_i1.DashboardPage]
class DashboardRoute extends _i2.PageRouteInfo<void> {
  const DashboardRoute({List<_i2.PageRouteInfo>? children})
      : super(
          DashboardRoute.name,
          path: '/dashboard',
          initialChildren: children,
        );

  static const String name = 'DashboardRoute';
}

/// generated route for
/// [_i1.HomePage]
class HomeRoute extends _i2.PageRouteInfo<void> {
  const HomeRoute()
      : super(
          HomeRoute.name,
          path: 'home',
        );

  static const String name = 'HomeRoute';
}

/// generated route for
/// [_i1.ActivityPage]
class ActivityRoute extends _i2.PageRouteInfo<void> {
  const ActivityRoute()
      : super(
          ActivityRoute.name,
          path: 'activity',
        );

  static const String name = 'ActivityRoute';
}

/// generated route for
/// [_i1.ArticlePage]
class ArticleRoute extends _i2.PageRouteInfo<void> {
  const ArticleRoute()
      : super(
          ArticleRoute.name,
          path: 'article',
        );

  static const String name = 'ArticleRoute';
}

/// generated route for
/// [_i1.ProfilePage]
class ProfileRoute extends _i2.PageRouteInfo<void> {
  const ProfileRoute()
      : super(
          ProfileRoute.name,
          path: 'profile',
        );

  static const String name = 'ProfileRoute';
}
