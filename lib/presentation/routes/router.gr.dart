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
import 'package:flutter/cupertino.dart' as _i4;
import 'package:flutter/material.dart' as _i3;

import '../../data/models/article/article_model.dart' as _i7;
import '../../data/models/saving/saving_model.dart' as _i5;
import '../../data/models/user/user_model.dart' as _i6;
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
    AddChildRoute.name: (routeData) {
      return _i2.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i1.AddChildPage(),
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
    SavingsRoute.name: (routeData) {
      return _i2.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i1.SavingsPage(),
        transitionsBuilder: _i2.TransitionsBuilders.fadeIn,
        opaque: true,
        barrierDismissible: false,
      );
    },
    SaveNowRoute.name: (routeData) {
      return _i2.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i1.SaveNowPage(),
        transitionsBuilder: _i2.TransitionsBuilders.fadeIn,
        opaque: true,
        barrierDismissible: false,
      );
    },
    SavingDetailRoute.name: (routeData) {
      final args = routeData.argsAs<SavingDetailRouteArgs>();
      return _i2.CustomPage<dynamic>(
        routeData: routeData,
        child: _i1.SavingDetailPage(
          key: args.key,
          saving: args.saving,
          index: args.index,
          setSavingModel: args.setSavingModel,
        ),
        transitionsBuilder: _i2.TransitionsBuilders.fadeIn,
        opaque: true,
        barrierDismissible: false,
      );
    },
    AccountDetailRoute.name: (routeData) {
      final args = routeData.argsAs<AccountDetailRouteArgs>();
      return _i2.CustomPage<dynamic>(
        routeData: routeData,
        child: _i1.AccountDetailPage(
          key: args.key,
          childModel: args.childModel,
        ),
        transitionsBuilder: _i2.TransitionsBuilders.fadeIn,
        opaque: true,
        barrierDismissible: false,
      );
    },
    DetailArticleRoute.name: (routeData) {
      final args = routeData.argsAs<DetailArticleRouteArgs>();
      return _i2.CustomPage<dynamic>(
        routeData: routeData,
        child: _i1.DetailArticlePage(
          key: args.key,
          articleModel: args.articleModel,
        ),
        transitionsBuilder: _i2.TransitionsBuilders.fadeIn,
        opaque: true,
        barrierDismissible: false,
      );
    },
    HomeRoute.name: (routeData) {
      final args = routeData.argsAs<HomeRouteArgs>();
      return _i2.CustomPage<dynamic>(
        routeData: routeData,
        child: _i1.HomePage(
          key: args.key,
          openPanel: args.openPanel,
          closePanel: args.closePanel,
        ),
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
    NotificationsRoute.name: (routeData) {
      return _i2.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i1.NotificationsPage(),
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
      final args = routeData.argsAs<ProfileRouteArgs>();
      return _i2.CustomPage<dynamic>(
        routeData: routeData,
        child: _i1.ProfilePage(
          key: args.key,
          openPanel: args.openPanel,
          closePanel: args.closePanel,
        ),
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
          AddChildRoute.name,
          path: '/add-child',
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
              NotificationsRoute.name,
              path: 'notifications',
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
        _i2.RouteConfig(
          SavingsRoute.name,
          path: '/savings',
        ),
        _i2.RouteConfig(
          SaveNowRoute.name,
          path: '/save-now',
        ),
        _i2.RouteConfig(
          SavingDetailRoute.name,
          path: '/saving-detail',
        ),
        _i2.RouteConfig(
          AccountDetailRoute.name,
          path: '/account-detail',
        ),
        _i2.RouteConfig(
          DetailArticleRoute.name,
          path: '/article-detail',
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
/// [_i1.AddChildPage]
class AddChildRoute extends _i2.PageRouteInfo<void> {
  const AddChildRoute()
      : super(
          AddChildRoute.name,
          path: '/add-child',
        );

  static const String name = 'AddChildRoute';
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
/// [_i1.SavingsPage]
class SavingsRoute extends _i2.PageRouteInfo<void> {
  const SavingsRoute()
      : super(
          SavingsRoute.name,
          path: '/savings',
        );

  static const String name = 'SavingsRoute';
}

/// generated route for
/// [_i1.SaveNowPage]
class SaveNowRoute extends _i2.PageRouteInfo<void> {
  const SaveNowRoute()
      : super(
          SaveNowRoute.name,
          path: '/save-now',
        );

  static const String name = 'SaveNowRoute';
}

/// generated route for
/// [_i1.SavingDetailPage]
class SavingDetailRoute extends _i2.PageRouteInfo<SavingDetailRouteArgs> {
  SavingDetailRoute({
    _i4.Key? key,
    required _i5.SavingModel saving,
    required int index,
    required void Function(
      _i5.SavingModel,
      int,
    ) setSavingModel,
  }) : super(
          SavingDetailRoute.name,
          path: '/saving-detail',
          args: SavingDetailRouteArgs(
            key: key,
            saving: saving,
            index: index,
            setSavingModel: setSavingModel,
          ),
        );

  static const String name = 'SavingDetailRoute';
}

class SavingDetailRouteArgs {
  const SavingDetailRouteArgs({
    this.key,
    required this.saving,
    required this.index,
    required this.setSavingModel,
  });

  final _i4.Key? key;

  final _i5.SavingModel saving;

  final int index;

  final void Function(
    _i5.SavingModel,
    int,
  ) setSavingModel;

  @override
  String toString() {
    return 'SavingDetailRouteArgs{key: $key, saving: $saving, index: $index, setSavingModel: $setSavingModel}';
  }
}

/// generated route for
/// [_i1.AccountDetailPage]
class AccountDetailRoute extends _i2.PageRouteInfo<AccountDetailRouteArgs> {
  AccountDetailRoute({
    _i4.Key? key,
    required _i6.UserModel childModel,
  }) : super(
          AccountDetailRoute.name,
          path: '/account-detail',
          args: AccountDetailRouteArgs(
            key: key,
            childModel: childModel,
          ),
        );

  static const String name = 'AccountDetailRoute';
}

class AccountDetailRouteArgs {
  const AccountDetailRouteArgs({
    this.key,
    required this.childModel,
  });

  final _i4.Key? key;

  final _i6.UserModel childModel;

  @override
  String toString() {
    return 'AccountDetailRouteArgs{key: $key, childModel: $childModel}';
  }
}

/// generated route for
/// [_i1.DetailArticlePage]
class DetailArticleRoute extends _i2.PageRouteInfo<DetailArticleRouteArgs> {
  DetailArticleRoute({
    _i4.Key? key,
    required _i7.ArticleModel articleModel,
  }) : super(
          DetailArticleRoute.name,
          path: '/article-detail',
          args: DetailArticleRouteArgs(
            key: key,
            articleModel: articleModel,
          ),
        );

  static const String name = 'DetailArticleRoute';
}

class DetailArticleRouteArgs {
  const DetailArticleRouteArgs({
    this.key,
    required this.articleModel,
  });

  final _i4.Key? key;

  final _i7.ArticleModel articleModel;

  @override
  String toString() {
    return 'DetailArticleRouteArgs{key: $key, articleModel: $articleModel}';
  }
}

/// generated route for
/// [_i1.HomePage]
class HomeRoute extends _i2.PageRouteInfo<HomeRouteArgs> {
  HomeRoute({
    _i4.Key? key,
    required Function openPanel,
    required Function closePanel,
  }) : super(
          HomeRoute.name,
          path: 'home',
          args: HomeRouteArgs(
            key: key,
            openPanel: openPanel,
            closePanel: closePanel,
          ),
        );

  static const String name = 'HomeRoute';
}

class HomeRouteArgs {
  const HomeRouteArgs({
    this.key,
    required this.openPanel,
    required this.closePanel,
  });

  final _i4.Key? key;

  final Function openPanel;

  final Function closePanel;

  @override
  String toString() {
    return 'HomeRouteArgs{key: $key, openPanel: $openPanel, closePanel: $closePanel}';
  }
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
/// [_i1.NotificationsPage]
class NotificationsRoute extends _i2.PageRouteInfo<void> {
  const NotificationsRoute()
      : super(
          NotificationsRoute.name,
          path: 'notifications',
        );

  static const String name = 'NotificationsRoute';
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
class ProfileRoute extends _i2.PageRouteInfo<ProfileRouteArgs> {
  ProfileRoute({
    _i4.Key? key,
    required Function openPanel,
    required Function closePanel,
  }) : super(
          ProfileRoute.name,
          path: 'profile',
          args: ProfileRouteArgs(
            key: key,
            openPanel: openPanel,
            closePanel: closePanel,
          ),
        );

  static const String name = 'ProfileRoute';
}

class ProfileRouteArgs {
  const ProfileRouteArgs({
    this.key,
    required this.openPanel,
    required this.closePanel,
  });

  final _i4.Key? key;

  final Function openPanel;

  final Function closePanel;

  @override
  String toString() {
    return 'ProfileRouteArgs{key: $key, openPanel: $openPanel, closePanel: $closePanel}';
  }
}
