import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:swifties_technoscape/application/service/shared_preferences_service.dart';
import 'package:swifties_technoscape/presentation/core/shared_data.dart';
import 'package:swifties_technoscape/presentation/routes/router.gr.dart';
import 'package:swifties_technoscape/presentation/widgets/custom_button.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Center(child: CustomButton(buttonText: 'Logout', onPressed: () async {
      context.loaderOverlay.show();
      await Future.delayed(const Duration(milliseconds: 500));
      await SharedPreferencesService.clearAllPrefs();
      SharedData.userData.value = null;
      context.loaderOverlay.hide();
      AutoRouter.of(context).replace(const LoginRoute());
    },));
  }
}
