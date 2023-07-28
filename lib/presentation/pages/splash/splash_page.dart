import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:swifties_technoscape/application/service/shared_preferences_service.dart';
import '../../routes/router.gr.dart';
import '../../widgets/logo_widget.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  @override
  void initState() {
    Future.delayed(const Duration(seconds: 3), () {
      if (SharedPreferencesService.getAuthData() != null) {
        AutoRouter.of(context).replace(const DashboardRoute());
      } else {
        AutoRouter.of(context).replace(const LandingRoute());
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Theme.of(context).scaffoldBackgroundColor,
    ));

    return const Scaffold(
      body: SafeArea(
        child: Center(
          child: LogoWidget(isBig: true)
        ),
      ),
    );
  }
}
