import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:swifties_technoscape/application/repositories/bank/bank_repository.dart';
import 'package:swifties_technoscape/application/service/shared_preferences_service.dart';
import '../../../application/common/db_constants.dart';
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
    Future.delayed(const Duration(seconds: 1), () async {
      if (SharedPreferencesService.getAuthData() != null) {
        if (SharedPreferencesService.getUserData()!.role == DbConstants.parentRole) {
          var result = await BankRepository().getAllAccount();
          if (result.isEmpty) {
            await BankRepository().createBankAccount(SharedPreferencesService.getToken()!);
          }
        } else {
          await Future.delayed(const Duration(seconds: 2));
        }
        AutoRouter.of(context).replace(const DashboardRoute());
      } else {
        await Future.delayed(const Duration(seconds: 2));
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
