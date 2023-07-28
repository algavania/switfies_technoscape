import 'package:auto_route/auto_route.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

import '../../../application/common/shared_code.dart';
import '../../../l10n/l10n.dart';
import '../../core/color_values.dart';
import '../../widgets/no_access_widget.dart';

class NoInternetPage extends StatefulWidget {
  const NoInternetPage({Key? key}) : super(key: key);

  @override
  State<NoInternetPage> createState() => _NoInternetPageState();
}

class _NoInternetPageState extends State<NoInternetPage> {
  bool _canPop = false;

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero, () {
      if (_canPop) {
        if (AutoRouter.of(context).canPop()) {
          AutoRouter.of(context).pop();
        } else {
          // AutoRouter.of(context).replace(const SplashRoute());
        }
      }
    });
    return Scaffold(
      appBar: AppBar(toolbarHeight: 0, elevation: 0,),
      body: WillPopScope(
        onWillPop: () async {
          return _canPop;
        },
        child: SafeArea(
          child: NoAccessWidget(
            title: AppLocalizations.of(context).noInternetTitle,
            description: AppLocalizations.of(context).noInternetAlt,
            path: 'assets/core/no_internet.png',
            buttonText: AppLocalizations.of(context).tryAgain,
            buttonColor: ColorValues.danger50,
            onTap: () async {
              ConnectivityResult result = await Connectivity().checkConnectivity();
              setState(() {
                _canPop = result != ConnectivityResult.none;
              });
              if (result == ConnectivityResult.none) {
                SharedCode.showSnackbar(
                    context: context,
                    message: AppLocalizations.of(context).stillNoInternet,
                    isTop: false,
                    isSuccess: false);
              }
            },
          ),
        ),
      ),
    );
  }
}
