import 'package:auto_route/auto_route.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iconsax/iconsax.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:swifties_technoscape/application/common/shared_code.dart';
import 'package:swifties_technoscape/application/repositories/auth/auth_repository.dart';
import 'package:swifties_technoscape/application/repositories/repositories.dart';
import 'package:swifties_technoscape/application/service/shared_preferences_service.dart';
import 'package:swifties_technoscape/data/models/auth/auth_model.dart';
import 'package:swifties_technoscape/data/models/token/token_model.dart';
import 'package:swifties_technoscape/l10n/l10n.dart';
import 'package:swifties_technoscape/presentation/core/color_values.dart';
import 'package:swifties_technoscape/presentation/core/ui_constant.dart';
import 'package:swifties_technoscape/presentation/routes/router.gr.dart';
import 'package:swifties_technoscape/presentation/widgets/custom_button.dart';
import 'package:swifties_technoscape/presentation/widgets/custom_text_field.dart';
import 'package:swifties_technoscape/presentation/widgets/logo_widget.dart';

import '../../../data/models/user/user_model.dart';
import '../../core/shared_data.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      SharedData.setStatusBarColorPrimary(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                          controller: _usernameController,
                          validator: SharedCode.emptyValidators,
                          icon: Iconsax.sms,
                          isRequired: false,
                          hint: AppLocalizations.of(context).enterUsername,
                          label: AppLocalizations.of(context).username,
                        ),
                        const SizedBox(height: UiConstant.defaultPadding),
                        CustomTextField(
                          controller: _passwordController,
                          validator: SharedCode.emptyValidators,
                          icon: Iconsax.key,
                          isRequired: false,
                          isPassword: true,
                          hint: AppLocalizations.of(context).enterPassword,
                          label: AppLocalizations.of(context).password,
                        ),
                        const SizedBox(height: UiConstant.biggerSpacing),
                        CustomButton(buttonText: AppLocalizations.of(context).login, onPressed: () async {
                          if (_formKey.currentState?.validate() ?? true) {
                            context.loaderOverlay.show();
                            try {
                              TokenModel tokenModel = await AuthRepository().generateToken(_usernameController.text, _passwordController.text);
                              AuthModel authModel = await AuthRepository().getAuthInfo(tokenModel.accessToken);
                              UserModel userModel = await UserRepository().getUserById(authModel.uid!);
                              await SharedPreferencesService.setToken(tokenModel.accessToken);
                              await SharedPreferencesService.setUserData(userModel);
                              await SharedPreferencesService.setAuthData(authModel);
                              SharedData.userData.value = userModel;
                              //TODO: Navigate to Home Page
                            } catch (e) {
                              SharedCode.showSnackbar(context: context,
                                  message: e.toString(),
                                  isSuccess: false);
                            }
                            context.loaderOverlay.hide();
                          }
                        }),
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