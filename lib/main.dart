import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:sizer/sizer.dart';

import 'application/repositories/repositories.dart';
import 'l10n/l10n.dart';
import 'presentation/core/app_theme_data.dart';
import 'presentation/core/color_values.dart';
import 'presentation/routes/router.gr.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Intl.defaultLocale = 'id';
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _appRouter = AppRouter();

  @override
  void initState() {
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      if (result == ConnectivityResult.none && _appRouter.currentPath != 'no-internet') {
        _appRouter.push(const NoInternetRoute());
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (_, __, ___) {
      return GlobalLoaderOverlay(
        useDefaultLoading: false,
        closeOnBackButton: true,
        overlayWidget: const Center(
            child: SpinKitChasingDots(
              color: ColorValues.primary50,
              size: 50.0,
            )),
        child: MultiRepositoryProvider(
          providers: [
            RepositoryProvider(
              create: (context) => AuthRepository(),
            ),
            RepositoryProvider(
              create: (context) => UserRepository(),
            ),
          ],
          child: MaterialApp.router(
            theme: AppThemeData.getTheme(context),
            routerDelegate: _appRouter.delegate(),
            routeInformationParser: _appRouter.defaultRouteParser(),
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            debugShowCheckedModeBanner: false,
          ),
        ),
      );
    });
  }
}