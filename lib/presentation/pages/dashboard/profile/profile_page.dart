import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:iconsax/iconsax.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:sizer/sizer.dart';
import 'package:swifties_technoscape/application/common/shared_code.dart';
import 'package:swifties_technoscape/application/service/shared_preferences_service.dart';
import 'package:swifties_technoscape/l10n/l10n.dart';
import 'package:swifties_technoscape/presentation/core/color_values.dart';
import 'package:swifties_technoscape/presentation/core/shared_data.dart';
import 'package:swifties_technoscape/presentation/core/ui_constant.dart';
import 'package:swifties_technoscape/presentation/routes/router.gr.dart';
import 'package:swifties_technoscape/presentation/widgets/custom_app_bar.dart';
import 'package:swifties_technoscape/presentation/widgets/custom_button.dart';

class ProfilePage extends StatefulWidget {
  final Function openPanel, closePanel;
  const ProfilePage({Key? key, required this.openPanel, required this.closePanel}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final ValueNotifier<bool> _isBalanceVisible = ValueNotifier(false);
  late String _displayName;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _displayName = SharedPreferencesService.getUserData()!.displayName;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: RefreshIndicator(
        onRefresh: () async {
        },
        child: Column(
          children: [
            const CustomAppBar(
              needSpacing: true,
              body: SizedBox.shrink(),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _buildAccountDetail(),
                    const SizedBox(height: 24),
                    _buildPersonalization(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAccountDetail() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: UiConstant.defaultPadding, horizontal: UiConstant.sidePadding),
      color: ColorValues.surface,
      child: Column(
        children: [
          Row(children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                'https://firebasestorage.googleapis.com/v0/b/swifties-technoscape.appspot.com/o/img_default_profile.png?alt=media&token=41b41973-531b-4f6e-95da-7b1e08f170a4',
                width: 32,
                height: 32,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: UiConstant.defaultSpacing),
            Expanded(
              child: Text(
                _displayName,
                style: Theme.of(context).textTheme.labelLarge?.copyWith(fontSize: 12),
              ),
            ),
            const SizedBox(width: UiConstant.defaultSpacing),
            GestureDetector(
              onTap: () {
                Clipboard.setData(ClipboardData(
                    text: SharedPreferencesService.getUserData()!.accountNo!));
                SharedCode.showSnackbar(
                    context: context,
                    message: AppLocalizations.of(context)
                        .accountClipboardSuccess);
              },
              child: Row(children: [
                Text(
                  SharedPreferencesService.getUserData()!.accountNo!,
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(fontSize: 12, color: Theme.of(context).primaryColor),
                ),
                const SizedBox(width: 4),
                const Icon(
                  Iconsax.copy5,
                  size: 16,
                  color: ColorValues.primary90,
                )
              ]),
            ),
          ]),
          const SizedBox(height: UiConstant.defaultSpacing),
          ValueListenableBuilder(
              valueListenable: _isBalanceVisible,
              builder: (context, _, __) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(AppLocalizations.of(context).mainAccountBalance,
                        style: Theme.of(context)
                            .textTheme
                            .displayMedium
                            ?.copyWith(fontSize: 14)),
                    const SizedBox(height: 4),
                    Row(children: [
                      Expanded(
                        child: _isBalanceVisible.value
                            ? RichText(
                            text: TextSpan(
                                text: 'Rp',
                                style: Theme.of(context)
                                    .textTheme
                                    .displayMedium
                                    ?.copyWith(fontSize: 20),
                                children: [
                                  TextSpan(
                                    text:
                                    ' ${SharedCode.formatThousands(SharedData.myAccountData.value!.balance)}',
                                    style:
                                    Theme.of(context).textTheme.displayLarge,
                                  )
                                ]))
                            : SizedBox(
                          height: 12,
                          child: ListView.separated(
                            primary: false,
                            scrollDirection: Axis.horizontal,
                            itemCount: 8,
                            itemBuilder: (_, i) {
                              return Container(
                                width: 12,
                                height: 12,
                                decoration: BoxDecoration(
                                  color: i % 2 == 0
                                      ? ColorValues.primary30
                                      : ColorValues.primary20,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              );
                            },
                            separatorBuilder: (_, __) {
                              return const SizedBox(width: 4);
                            },
                          ),
                        ),
                      ),
                      _buildBalanceToggle(_isBalanceVisible),
                    ]),
                  ],
                );
              })
        ],
      ),
    );
  }

  Widget _buildBalanceToggle(ValueNotifier<bool> valueNotifier) {
    return InkWell(
      onTap: () {
        valueNotifier.value = !valueNotifier.value;
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: ColorValues.text50, width: 1)),
        child: Row(
          children: [
            Icon(
              valueNotifier.value ? Iconsax.eye_slash5 : Iconsax.eye4,
              color: ColorValues.text50,
              size: 16,
            ),
            const SizedBox(width: 4),
            Text(
              valueNotifier.value
                  ? AppLocalizations.of(context).hide
                  : AppLocalizations.of(context).show,
              style: Theme.of(context)
                  .textTheme
                  .labelSmall
                  ?.copyWith(letterSpacing: 1),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPersonalization() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: UiConstant.sidePadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocalizations.of(context).personalization,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 14),
          ),
          // const SizedBox(height: 16),
          // _buildMenu(
          //   title: AppLocalizations.of(context).changePersonalInfo,
          //   iconData: Iconsax.frame5,
          //   onTap: () {},
          // ),
          // const SizedBox(height: UiConstant.defaultSpacing),
          // _buildMenu(
          //   title: AppLocalizations.of(context).childrenAccountsInfo,
          //   iconData: Iconsax.profile_2user5,
          //   onTap: () {},
          // ),
          // const SizedBox(height: UiConstant.defaultSpacing),
          // _buildMenu(
          //   title: AppLocalizations.of(context).changePassword,
          //   iconData: Iconsax.key5,
          //   onTap: () {},
          // ),
          const SizedBox(height: UiConstant.defaultSpacing),
          _buildMenu(
            title: AppLocalizations.of(context).logout,
            iconData: Iconsax.logout5,
            onTap: () {
              widget.openPanel(_buildLogoutPanel(), isPanelSmall: true);
            },
            isLogout: true,
          ),
        ],
      ),
    );
  }

  Widget _buildMenu({required String title, required IconData iconData, required Function() onTap, bool isLogout = false}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(UiConstant.defaultPadding),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(UiConstant.smallerBorder),
          border: Border.all(
            color: isLogout ? ColorValues.danger10 : ColorValues.grey10,
          ),
          color: ColorValues.surface,
        ),
        child: Row(children: [
          Icon(
            iconData,
            size: 16,
            color: isLogout ? ColorValues.danger30 : Theme.of(context).primaryColor,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                title,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 14),
              ),
            ),
          ),
          const Icon(
            Iconsax.arrow_right_3,
            size: 16,
            color: ColorValues.text50,
          ),
        ]),
      ),
    );
  }

  Widget _buildLogoutPanel() {
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
                      'assets/profile/img_logout.svg',
                      width: 25.h,
                      height: 25.h,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                const SizedBox(height: UiConstant.sidePadding),
                Text(
                  AppLocalizations
                      .of(context)
                      .logoutTitle,
                  style: Theme
                      .of(context)
                      .textTheme
                      .titleMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),
                Text(
                  AppLocalizations
                      .of(context)
                      .logoutDescription,
                  style: Theme
                      .of(context)
                      .textTheme
                      .displayMedium
                      ?.copyWith(color: ColorValues.greyBase, fontSize: 12),
                  textAlign: TextAlign.center,
                ),
              ]),
            ),
          ),
          const SizedBox(height: 24),
          Row(children: [
            Expanded(child: CustomButton(
              buttonText: AppLocalizations.of(context).logoutCancel,
              colorAsOutlineButton: ColorValues.grey90,
              backgroundColor: ColorValues.slidingPanelBackground,
              onPressed: () {
                widget.closePanel();
              },
            )),
            const SizedBox(width: UiConstant.defaultPadding),
            Expanded(child: CustomButton(
              backgroundColor: ColorValues.danger30,
              buttonText: AppLocalizations.of(context).logoutConfirm,
              onPressed: () {
                widget.closePanel();
                widget.openPanel(_buildReLogPanel(), isPanelSmall: true);
              },
            )),
          ]),
        ],
      ),
    );
  }

  Widget _buildReLogPanel() {
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
                      'assets/profile/img_relog.svg',
                      width: 25.h,
                      height: 25.h,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                const SizedBox(height: UiConstant.sidePadding),
                Text(
                  AppLocalizations
                      .of(context)
                      .relogTitle,
                  style: Theme
                      .of(context)
                      .textTheme
                      .titleMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),
                Text(
                  AppLocalizations
                      .of(context)
                      .relogDescription,
                  style: Theme
                      .of(context)
                      .textTheme
                      .displayMedium
                      ?.copyWith(color: ColorValues.greyBase, fontSize: 12),
                  textAlign: TextAlign.center,
                ),
              ]),
            ),
          ),
          const SizedBox(height: 24),
          CustomButton(
              buttonText: AppLocalizations.of(context).relog,
              onPressed: () async {
                context.loaderOverlay.show();
                await Future.delayed(const Duration(milliseconds: 500));
                await SharedPreferencesService.clearAllPrefs();
                SharedData.userData.value = null;
                context.loaderOverlay.hide();
                AutoRouter.of(context).replace(const LoginRoute());
              }
          )
        ],
      ),
    );
  }
}
