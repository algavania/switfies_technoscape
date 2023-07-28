import 'package:auto_route/auto_route.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iconsax/iconsax.dart';
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

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Theme.of(context).primaryColor,
    ));
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
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
      )
    );
  }
}