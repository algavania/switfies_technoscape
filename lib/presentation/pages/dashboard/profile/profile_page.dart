import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:swifties_technoscape/application/service/shared_preferences_service.dart';
import 'package:swifties_technoscape/presentation/core/shared_data.dart';
import 'package:swifties_technoscape/presentation/routes/router.gr.dart';
import 'package:swifties_technoscape/presentation/widgets/custom_button.dart';

import '../../../../l10n/l10n.dart';
import '../../../core/color_values.dart';
import '../../../core/ui_constant.dart';

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

  Widget _buildSection({required String title, required List<Widget> menus}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: Theme.of(context).textTheme.titleMedium),
        _buildMenuDivider(),
        ListView.separated(
          shrinkWrap: true,
          itemCount: menus.length,
          padding: EdgeInsets.zero,
          physics: const NeverScrollableScrollPhysics(),
          separatorBuilder: (_, __) {
            return _buildMenuDivider();
          },
          itemBuilder: (c, i) {
            return menus[i];
          },
        )
      ],
    );
  }

  Widget _buildMenu(
      {required String title,
        required IconData iconData,
        required Function() onTap}) {
    bool isLogout = title == AppLocalizations.of(context).logout;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
            vertical: UiConstant.contentPadding,
            horizontal: UiConstant.defaultPadding),
        decoration: BoxDecoration(
            color: isLogout ? null : Colors.white,
            borderRadius: BorderRadius.circular(UiConstant.defaultBorder),
            border: Border.all(
                color: isLogout ? ColorValues.danger50 : ColorValues.grey10,
                width: 1)),
        child: Row(children: [
          Icon(
            iconData,
            size: 24,
            color: isLogout
                ? ColorValues.danger50
                : Theme.of(context).primaryColor,
          ),
          const SizedBox(width: UiConstant.sidePadding),
          Expanded(
              child: Text(
                title,
                style: Theme.of(context).textTheme.labelLarge,
              )),
        ]),
      ),
    );
  }

  Widget _buildSectionDivider() {
    return const SizedBox(height: UiConstant.sidePadding);
  }

  Widget _buildMenuDivider() {
    return const SizedBox(height: UiConstant.defaultPadding);
  }

  Widget _buildLogoutConfirmationPanel() {
    return _buildGuideWithImage(
        AppLocalizations.of(context).logoutConfirmation,
        AppLocalizations.of(context).logoutConfirmationDescription,
        'assets/profile/img_logout.svg',
        Row(children: [
          Expanded(
            child: CustomButton(
              buttonText: AppLocalizations.of(context).confirmLogout,
              colorAsOutlineButton: ColorValues.danger50,
              backgroundColor: ColorValues.slidingPanelBackground,
              onPressed: () async {
                context.loaderOverlay.show();
                await AuthRepository().logout();
                await Future.delayed(const Duration(milliseconds: 500));
                context.loaderOverlay.hide();
                widget.closePanel.call();
                widget.openPanel.call(
                  height: 63.h,
                  content: _buildReLogPanel(),
                );
              },
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: CustomButton(
              buttonText: AppLocalizations.of(context).cancelLogout,
              backgroundColor: ColorValues.danger50,
              onPressed: () => widget.closePanel(),
            ),
          ),
        ]));
  }

  Widget _buildReLogPanel() {
    return _buildGuideWithImage(
        AppLocalizations.of(context).reLog,
        AppLocalizations.of(context).reLogDescription,
        'assets/profile/img_relog.svg',
        Row(
          children: [
            Expanded(
              child: CustomButton(
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                colorAsOutlineButton: ColorValues.danger50,
                buttonText: AppLocalizations.of(context).exit,
                onPressed: () {
                  SystemNavigator.pop();
                },
              ),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: CustomButton(
                buttonText: AppLocalizations.of(context).login,
                onPressed: () async {
                  widget.closePanel.call();
                  AutoRouter.of(context).replace(const LoginRoute());
                },
              ),
            ),
          ],
        ));
  }

  Widget _buildGuideWithImage(
      String heading, String description, String imagePath, Widget actions) {
    return Padding(
      padding: const EdgeInsets.all(UiConstant.sidePadding),
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: UiConstant.sidePadding),
                  child: Center(
                    child: SvgPicture.asset(
                      imagePath,
                      width: 25.h,
                      height: 25.h,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                const SizedBox(height: UiConstant.sidePadding),
                Text(
                  heading,
                  style: Theme.of(context).textTheme.titleMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  description,
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(color: ColorValues.grey50),
                  textAlign: TextAlign.center,
                ),
              ]),
            ),
          ),
          const SizedBox(height: 24),
          actions,
        ],
      ),
    );
  }
}
