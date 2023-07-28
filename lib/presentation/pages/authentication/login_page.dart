import 'package:auto_route/auto_route.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:swifties_technoscape/application/common/shared_code.dart';
import 'package:swifties_technoscape/l10n/l10n.dart';
import 'package:swifties_technoscape/presentation/core/color_values.dart';
import 'package:swifties_technoscape/presentation/core/ui_constant.dart';
import 'package:swifties_technoscape/presentation/routes/router.gr.dart';
import 'package:swifties_technoscape/presentation/widgets/custom_button.dart';
import 'package:swifties_technoscape/presentation/widgets/custom_text_field.dart';
import 'package:swifties_technoscape/presentation/widgets/logo_widget.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final PanelController _panelController = PanelController();
  final ValueNotifier<Widget> _panelContent = ValueNotifier<Widget>(const SizedBox.shrink());
  final ValueNotifier<double> _panelHeight = ValueNotifier<double>(0);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Theme.of(context).primaryColor,
    ));
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: ValueListenableBuilder(
          valueListenable: _panelContent,
          builder: (context, _, __) {
            return SlidingUpPanel(
              controller: _panelController,
              backdropTapClosesPanel: false,
              minHeight: 0,
              maxHeight: _panelHeight.value,
              color: ColorValues.slidingPanelBackground,
              backdropEnabled: true,
              backdropColor: ColorValues.grey50,
              backdropOpacity: 0.32,
              borderRadius: const BorderRadius.only(topLeft: Radius.circular(24), topRight: Radius.circular(24)),
              boxShadow: [BoxShadow(color: ColorValues.grey50.withOpacity(0))],
              panel: GestureDetector(
                  onTap: () {
                    FocusScope.of(context).unfocus();
                  },
                  child: _panelContent.value),
              body: SafeArea(
                child: GestureDetector(
                  onTap: () {
                    FocusScope.of(context).unfocus();
                  },
                  child: CustomScrollView(
                    slivers: [
                      SliverFillRemaining(
                        hasScrollBody: false,
                        child: Container(
                          padding: const EdgeInsets.all(UiConstant.defaultPadding),
                          decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(UiConstant.biggerBorder),
                                topRight: Radius.circular(UiConstant.biggerBorder),
                              )),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: UiConstant.biggerPadding),
                                const Center(child: LogoWidget()),
                                const SizedBox(height: UiConstant.biggerSpacing),
                                const SizedBox(height: UiConstant.defaultSpacing),
                                Text(AppLocalizations.of(context).loginTitle, style: Theme.of(context).textTheme.titleMedium,),
                                const SizedBox(height: UiConstant.smallerSpacing),
                                Text(AppLocalizations.of(context).loginDescription, style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: ColorValues.grey50
                                ),),
                                const SizedBox(height: UiConstant.biggerSpacing),
                                CustomTextField(
                                  controller: _emailController,
                                  validator: SharedCode.emailValidators,
                                  icon: Iconsax.sms,
                                  isRequired: false,
                                  textInputType: TextInputType.emailAddress,
                                  hint: AppLocalizations.of(context).enterEmail,
                                  label: AppLocalizations.of(context).email,
                                ),
                                const SizedBox(height: UiConstant.defaultPadding),
                                CustomTextField(
                                  controller: _passwordController,
                                  validator: SharedCode.passwordValidators,
                                  icon: Iconsax.key,
                                  isRequired: false,
                                  isPassword: true,
                                  hint: AppLocalizations.of(context).enterPassword,
                                  label: AppLocalizations.of(context).password,
                                ),
                                const SizedBox(height: UiConstant.defaultSpacing),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    GestureDetector(
                                        onTap: () {
                                          // _openPanel(
                                          //   height: 45.h,
                                          //   content: _buildForgotPasswordPanel(),
                                          // );
                                        },
                                        child: Text(AppLocalizations.of(context).forgotpassword, style: Theme.of(context).textTheme.displaySmall,)),
                                  ],
                                ),
                                const SizedBox(height: UiConstant.biggerSpacing),
                                CustomButton(buttonText: AppLocalizations.of(context).login, onPressed: () async {}),
                                const SizedBox(height: UiConstant.defaultSpacing),
                                Expanded(child: Container()),
                                const SizedBox(height: UiConstant.defaultSpacing),
                                Center(
                                  child: RichText(
                                      textAlign: TextAlign.center,
                                      text: TextSpan(
                                          text: AppLocalizations.of(context).dontHaveAccount,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall
                                              ?.copyWith(color: ColorValues.grey50),
                                          children: [
                                            TextSpan(
                                                text:
                                                ' ${AppLocalizations.of(context).letsRegister}',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodySmall
                                                    ?.copyWith(
                                                    color: Theme.of(context).primaryColor,
                                                    fontWeight: FontWeight.w800),
                                                recognizer: TapGestureRecognizer()
                                                  ..onTap = () {
                                                    AutoRouter.of(context).replace(const RegisterRoute());
                                                  })
                                          ])),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
      ),
    );
  }

  // Widget _buildPanelHeading(String heading, String description) {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       Text(heading, style: Theme.of(context).textTheme.titleMedium),
  //       const SizedBox(height: 4),
  //       Text(description, style: Theme.of(context).textTheme.bodySmall?.copyWith(color: ColorValues.grey50)),
  //     ],
  //   );
  // }
  //
  // Widget _buildForgotPasswordPanel() {
  //   return Padding(
  //     padding: const EdgeInsets.all(UiConstant.sidePadding),
  //     child: Form(
  //       key: _formPasswordKey,
  //       child: Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           _buildPanelHeading(AppLocalizations.of(context).forgotpassword, AppLocalizations.of(context).changePasswordDescription),
  //           const SizedBox(height: UiConstant.sidePadding),
  //           CustomTextField(
  //             controller: _emailForgotController,
  //             label: AppLocalizations.of(context).yourExistingEmail,
  //             hint: AppLocalizations.of(context).dummyEmailHint,
  //             icon: Iconsax.envelope,
  //             isRequired: true,
  //             validator: SharedCode.emailValidators,
  //           ),
  //           const Spacer(),
  //           _buildDefaultPanelActions(AppLocalizations.of(context).sendInstructions, () async {}
  //           }),
  //         ],
  //       ),
  //     ),
  //   );
  // }
  //
  // Widget _buildDefaultPanelActions(String actionLabel, Function() onTap, {bool onlyOneButton = false}) {
  //   return Row(children: [
  //     if (onlyOneButton) Expanded(
  //       child: CustomButton(
  //         buttonText: AppLocalizations.of(context).later,
  //         colorAsOutlineButton: ColorValues.grey50,
  //         backgroundColor: ColorValues.slidingPanelBackground,
  //         onPressed: () => _closePanel(),
  //       ),
  //     ),
  //     if (onlyOneButton) const SizedBox(width: 15),
  //     Expanded(
  //       child: CustomButton(
  //         buttonText: actionLabel,
  //         onPressed: onTap,
  //       ),
  //     ),
  //   ]);
  // }
  //
  //
  // Widget _buildCheckEmailPanel() {
  //   return _buildGuideWithImage(
  //       AppLocalizations.of(context).checkYourEmail,
  //       AppLocalizations.of(context).checkYourEmailDescription,
  //       'assets/profile/img_check_email.svg',
  //       _buildDefaultPanelActions(AppLocalizations.of(context).close, () {
  //         _closePanel();
  //       })
  //   );
  // }
  //
  // Widget _buildGuideWithImage(String heading, String description, String imagePath, Widget actions) {
  //   return Padding(
  //     padding: const EdgeInsets.all(UiConstant.sidePadding),
  //     child: Column(
  //       children: [
  //         Padding(
  //           padding: const EdgeInsets.symmetric(vertical: UiConstant.sidePadding),
  //           child: Center(
  //             child: SvgPicture.asset(
  //               imagePath,
  //               width: 25.h,
  //               height: 25.h,
  //               fit: BoxFit.contain,
  //             ),
  //           ),
  //         ),
  //         const SizedBox(height: UiConstant.sidePadding),
  //         Text(
  //           heading,
  //           style: Theme.of(context).textTheme.titleMedium,
  //           textAlign: TextAlign.center,
  //         ),
  //         const SizedBox(height: 8),
  //         Text(
  //           description,
  //           style: Theme.of(context).textTheme.bodySmall?.copyWith(color: ColorValues.grey50),
  //           textAlign: TextAlign.center,
  //         ),
  //         const Spacer(),
  //         const SizedBox(height: 8),
  //         actions,
  //       ],
  //     ),
  //   );
  // }

  void _openPanel({required double height, required Widget content}) {
    _panelContent.value = content;
    _panelHeight.value = height;
    _panelController.open();
  }

  void _closePanel() {
    _panelController.close();
  }
}