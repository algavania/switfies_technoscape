import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:iconsax/iconsax.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:sizer/sizer.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:swifties_technoscape/application/common/db_constants.dart';
import 'package:swifties_technoscape/application/common/shared_code.dart';
import 'package:swifties_technoscape/application/repositories/auth/auth_repository.dart';
import 'package:swifties_technoscape/application/repositories/repositories.dart';
import 'package:swifties_technoscape/application/service/shared_preferences_service.dart';
import 'package:swifties_technoscape/data/models/user/user_model.dart';
import 'package:swifties_technoscape/l10n/l10n.dart';
import 'package:swifties_technoscape/presentation/core/color_values.dart';
import 'package:swifties_technoscape/presentation/core/shared_data.dart';
import 'package:swifties_technoscape/presentation/core/ui_constant.dart';
import 'package:swifties_technoscape/presentation/widgets/custom_button.dart';
import 'package:swifties_technoscape/presentation/widgets/custom_dropdown_field.dart';
import 'package:swifties_technoscape/presentation/widgets/custom_text_field.dart';

import '../../../application/repositories/bank/bank_repository.dart';
import '../../../data/models/account/account_model.dart';
import '../../../data/models/auth/auth_model.dart';
import '../../../data/models/token/token_model.dart';
import '../../routes/router.gr.dart';
import '../../widgets/custom_app_bar.dart';

class AddChildPage extends StatefulWidget {
  const AddChildPage({Key? key}) : super(key: key);

  @override
  State<AddChildPage> createState() => _AddChildPageState();
}

class _AddChildPageState extends State<AddChildPage> {
  final _formKey = GlobalKey<FormState>();
  final PanelController _panelController = PanelController();
  final TextEditingController _nikController = TextEditingController();
  final TextEditingController _displayNameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _birthdateController = TextEditingController();
  final List<DropdownMenuItem<int>> _genderItems = [];
  int? _value;

  @override
  void initState() {
    _getGenders();
    Future.delayed(Duration.zero, () {
      if (AutoRouter.of(context).canPop()) {
        SharedData.setStatusBarColorWhite(context);
      } else {
        SharedData.setStatusBarColorPrimary(context);
      }
    });
    super.initState();
  }

  void _getGenders() {
    _genderItems.add(
        const DropdownMenuItem(value: 0, child: Text('Laki-laki')));
    _genderItems.add(
        const DropdownMenuItem(value: 1, child: Text('Perempuan')));
  }

  void _clearAllTextFields() {
    setState(() {
      _nikController.clear();
      _displayNameController.clear();
      _usernameController.clear();
      _emailController.clear();
      _passwordController.clear();
      _birthdateController.clear();
      _phoneController.clear();
      _genderItems.clear();
      _value = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Theme
          .of(context)
          .primaryColor,
    ));
    return Scaffold(
      backgroundColor: Theme
          .of(context)
          .primaryColor,
      body: SlidingUpPanel(
        controller: _panelController,
        minHeight: 0,
        maxHeight: 73.h,
        backdropTapClosesPanel: false,
        color: ColorValues.slidingPanelBackground,
        backdropEnabled: true,
        backdropColor: ColorValues.grey90,
        backdropOpacity: 0.32,
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(24), topRight: Radius.circular(24)),
        boxShadow: [BoxShadow(color: ColorValues.grey50.withOpacity(0))],
        panel: _buildSuccessPanel(),
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: SafeArea(
            child: Column(
              children: [
                if (AutoRouter.of(context).canPop()) CustomAppBar(
                  color: Colors.white,
                  hasBackButton: true,
                  body: Text(AppLocalizations.of(context).childDetailAccount, style: Theme.of(context).textTheme.titleMedium,),
                ),
                Expanded(
                  child: CustomScrollView(
                    slivers: [
                      SliverFillRemaining(
                        hasScrollBody: false,
                        child: Container(
                          padding: const EdgeInsets.all(UiConstant.defaultPadding),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: AutoRouter.of(context).canPop() ? null : const BorderRadius.only(
                                topLeft: Radius.circular(UiConstant.biggerBorder),
                                topRight: Radius.circular(UiConstant.biggerBorder),
                              )),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  AppLocalizations
                                      .of(context)
                                      .addChildTitle,
                                  style: Theme
                                      .of(context)
                                      .textTheme
                                      .titleMedium,
                                ),
                                const SizedBox(height: UiConstant.smallerSpacing),
                                Text(
                                  AppLocalizations
                                      .of(context)
                                      .addChildDescription,
                                  style: Theme
                                      .of(context)
                                      .textTheme
                                      .bodySmall
                                      ?.copyWith(color: ColorValues.grey50),
                                ),
                                const SizedBox(height: UiConstant.biggerSpacing),
                                CustomTextField(
                                  validator: SharedCode.nikValidators,
                                  controller: _nikController,
                                  maxLength: 16,
                                  textInputType: TextInputType.number,
                                  icon: Iconsax.card,
                                  hint: AppLocalizations
                                      .of(context)
                                      .enterNik,
                                  label: AppLocalizations
                                      .of(context)
                                      .nik,
                                ),
                                const SizedBox(height: UiConstant.smallerSpacing),
                                CustomTextField(
                                  validator: SharedCode.emptyValidators,
                                  controller: _displayNameController,
                                  icon: Iconsax.user,
                                  hint: AppLocalizations
                                      .of(context)
                                      .enterName,
                                  label: AppLocalizations
                                      .of(context)
                                      .name,
                                ),
                                const SizedBox(height: UiConstant.defaultPadding),
                                CustomTextField(
                                  validator: SharedCode.usernameValidators,
                                  controller: _usernameController,
                                  icon: Iconsax.user_edit,
                                  hint: AppLocalizations
                                      .of(context)
                                      .enterUsername,
                                  label: AppLocalizations
                                      .of(context)
                                      .username,
                                ),
                                const SizedBox(height: UiConstant.defaultPadding),
                                CustomTextField(
                                  validator: SharedCode.emailValidators,
                                  controller: _emailController,
                                  textInputType: TextInputType.emailAddress,
                                  icon: Iconsax.sms,
                                  hint: AppLocalizations
                                      .of(context)
                                      .enterEmail,
                                  label: AppLocalizations
                                      .of(context)
                                      .email,
                                ),
                                const SizedBox(height: UiConstant.defaultPadding),
                                CustomTextField(
                                  validator: SharedCode.passwordValidators,
                                  isPassword: true,
                                  controller: _passwordController,
                                  icon: Iconsax.key,
                                  hint: AppLocalizations
                                      .of(context)
                                      .enterPassword,
                                  label: AppLocalizations
                                      .of(context)
                                      .password,
                                ),
                                const SizedBox(height: UiConstant.defaultPadding),
                                CustomTextField(
                                  controller: _phoneController,
                                  textInputType: TextInputType.number,
                                  icon: Iconsax.call,
                                  hint: AppLocalizations
                                      .of(context)
                                      .enterPhoneNumber,
                                  label: AppLocalizations
                                      .of(context)
                                      .phoneNumber,
                                ),
                                const SizedBox(height: UiConstant.defaultPadding),
                                GestureDetector(
                                  onTap: () async {
                                    DateTime? selectedDate = await showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime(1900),
                                        lastDate: DateTime(2100));
                                    if (selectedDate != null) {
                                      setState(() {
                                        _birthdateController.text =
                                            SharedData.regularDateFormat.format(
                                                selectedDate);
                                      });
                                    }
                                  },
                                  child: CustomTextField(
                                    validator: SharedCode.emptyValidators,
                                    controller: _birthdateController,
                                    icon: Iconsax.calendar,
                                    readOnly: true,
                                    hint: AppLocalizations
                                        .of(context)
                                        .chooseBirthdate,
                                    label: AppLocalizations
                                        .of(context)
                                        .birthdate,
                                  ),
                                ),
                                const SizedBox(height: UiConstant.defaultPadding),
                                CustomDropdownField(
                                    label: AppLocalizations
                                        .of(context)
                                        .gender,
                                    hint: AppLocalizations
                                        .of(context)
                                        .chooseGender,
                                    icon: Iconsax.user,
                                    value: _value,
                                    items: _genderItems,
                                    onChanged: (value) {
                                      if (value != null) {
                                        setState(() {
                                          _value = int.parse(value.toString());
                                        });
                                      }
                                    }),
                                const SizedBox(height: UiConstant.biggerSpacing),
                                CustomButton(
                                    buttonText: AppLocalizations
                                        .of(context)
                                        .confirmAndContinue,
                                    onPressed: () async {
                                    if (_formKey.currentState?.validate() ?? true) {
                                        context.loaderOverlay.show();
                                        try {
                                          String username = _usernameController.text.trimRight().trimLeft();
                                          String nik = _nikController.text.trimRight().trimLeft();
                                          String displayName = _displayNameController.text.trimRight().trimLeft();
                                          String loginPassword = _passwordController.text;
                                          DateTime date = SharedData.regularDateFormat.parse(_birthdateController.text);
                                          String birthDate = SharedData.authDateFormat.format(date);
                                          AuthModel authModel = AuthModel(
                                              email: _emailController.text,
                                              birthDate: birthDate,
                                              gender: _value ?? 0,
                                              ktpId: nik,
                                              phoneNumber: _phoneController.text,
                                              loginPassword: loginPassword,
                                              username: username);
                                          UserModel userModel = UserModel(
                                            username: username,
                                            relatedId: SharedPreferencesService.getUserData()!.uid,
                                            role: DbConstants.childRole,
                                            displayName: displayName,
                                            loginPassword: loginPassword
                                          );
                                          AuthModel result = await AuthRepository().createUser(authModel, userModel);
                                          TokenModel tokenModel = await AuthRepository().generateToken(username, loginPassword);
                                          AccountModel accountModel = await BankRepository().createBankAccount(tokenModel.accessToken);
                                          userModel = userModel.copyWith(accountNo: accountModel.accountNo, uid: result.uid);
                                          await UserRepository().addOrUpdateUser(result.uid!, userModel);
                                          _clearAllTextFields();
                                          if (AutoRouter.of(context).canPop()) {
                                            AutoRouter.of(context).pop(AppLocalizations.of(context).childRegistrationSuccessTitle);
                                          } else {
                                            _panelController.open();
                                          }
                                        } catch (e) {
                                          SharedCode.showSnackbar(context: context,
                                              message: e.toString(),
                                              isSuccess: false);
                                        }
                                        context.loaderOverlay.hide();
                                      }
                                    }
                                ),
                                const SizedBox(height: UiConstant.defaultPadding),
                                if (!AutoRouter.of(context).canPop()) _buildSkipButton(),
                                if (!AutoRouter.of(context).canPop()) const SizedBox(height: UiConstant.defaultPadding),
                                Expanded(child: Container()),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSuccessPanel() {
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
                      'assets/core/img_action_success.svg',
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
                      .childRegistrationSuccessTitle,
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
                      .childRegistrationSuccessDescription,
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
          Column(children: [
            CustomButton(
              buttonText: AppLocalizations
                  .of(context)
                  .registerChildAgain,
              onPressed: () {
                _panelController.close();
              },
            ),
            if (!AutoRouter.of(context).canPop()) const SizedBox(height: UiConstant.defaultPadding),
            if (!AutoRouter.of(context).canPop()) _buildSkipButton(),
          ]),
        ],
      ),
    );
  }

  Widget _buildSkipButton() {
    return CustomButton(
            buttonText: AppLocalizations
                .of(context)
                .skip,
            colorAsOutlineButton: ColorValues.grey90,
            backgroundColor: ColorValues.slidingPanelBackground,
            onPressed: () {
              AutoRouter.of(context).replace(const DashboardRoute());
            },
          );
  }
}
