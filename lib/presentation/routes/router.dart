// watch for file changes which will rebuild the generated files:
// flutter packages pub run build_runner watch

// only generate files once and exit after use:
// flutter packages pub run build_runner build

import 'package:auto_route/auto_route.dart';
import '../pages/screens.dart';

// watch for file changes which will rebuild the generated files:
// flutter packages pub run build_runner watch

// only generate files once and exit after use:
// flutter packages pub run build_runner build

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    CustomRoute(
        page: SplashPage,
        path: '/splash',
        initial: true,
        transitionsBuilder: TransitionsBuilders.fadeIn),
    CustomRoute(
        page: NoInternetPage,
        path: '/no-internet',
        transitionsBuilder: TransitionsBuilders.fadeIn),
    CustomRoute(
        page: RegisterPage,
        path: '/register',
        transitionsBuilder: TransitionsBuilders.fadeIn),
    CustomRoute(
        page: LoginPage,
        path: '/login',
        transitionsBuilder: TransitionsBuilders.fadeIn),
    CustomRoute(
        page: LandingPage,
        path: '/on-boarding',
        transitionsBuilder: TransitionsBuilders.fadeIn),
    CustomRoute(
        page: AddChildPage,
        path: '/add-child',
        transitionsBuilder: TransitionsBuilders.fadeIn),
  ],
)
class $AppRouter {}
