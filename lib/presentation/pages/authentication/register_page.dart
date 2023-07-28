import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sizer/sizer.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:swifties_technoscape/application/common/shared_code.dart';
import 'package:swifties_technoscape/l10n/l10n.dart';
import 'package:swifties_technoscape/presentation/core/color_values.dart';
import 'package:swifties_technoscape/presentation/core/shared_data.dart';
import 'package:swifties_technoscape/presentation/core/ui_constant.dart';
import 'package:swifties_technoscape/presentation/widgets/custom_button.dart';
import 'package:swifties_technoscape/presentation/widgets/custom_dropdown_field.dart';
import 'package:swifties_technoscape/presentation/widgets/custom_text_field.dart';
import 'package:unicons/unicons.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final PanelController _panelController = PanelController();
  final TextEditingController _displayNameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _birthdateController = TextEditingController();
  final List<DropdownMenuItem<String>> _genderItems = [];
  String? _value;
  bool _isInFirstStep = true;

  @override
  void initState() {
    _getGenders();

    super.initState();
  }

  void _getGenders() {
    _genderItems.add(const DropdownMenuItem(value: 'Laki-laki', child: Text('Laki-laki')));
    _genderItems.add(const DropdownMenuItem(value: 'Perempuam', child: Text('Perempuam')));
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Theme.of(context).primaryColor,
    ));
    return Scaffold(
      backgroundColor: Theme
          .of(context)
          .primaryColor,
      body: SlidingUpPanel(
        controller: _panelController,
        minHeight: 0,
        maxHeight: 63.h,
        backdropTapClosesPanel: false,
        color: ColorValues.slidingPanelBackground,
        backdropEnabled: true,
        backdropColor: ColorValues.grey50,
        backdropOpacity: 0.32,
        borderRadius: const BorderRadius.only(topLeft: Radius.circular(24), topRight: Radius.circular(24)),
        boxShadow: [BoxShadow(color: ColorValues.grey50.withOpacity(0))],
        panel: _buildSuccessPanel(),
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
                          _buildStepWidget(),
                          const SizedBox(height: UiConstant.biggerSpacing),
                          _buildLogo(),
                          const SizedBox(height: UiConstant.biggerSpacing),
                          const SizedBox(height: UiConstant.defaultPadding),
                          Text(
                            AppLocalizations
                                .of(context)
                                .registerParentTitle,
                            style: Theme
                                .of(context)
                                .textTheme
                                .titleMedium,
                          ),
                          const SizedBox(height: UiConstant.smallerSpacing),
                          Text(
                            AppLocalizations
                                .of(context)
                                .registerParentDescription,
                            style: Theme
                                .of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(color: ColorValues.grey50),
                          ),
                          const SizedBox(height: UiConstant.biggerSpacing),
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
                            icon: Iconsax.lock,
                            hint: AppLocalizations
                                .of(context)
                                .enterPassword,
                            label: AppLocalizations
                                .of(context)
                                .password,
                          ),
                          const SizedBox(height: UiConstant.defaultPadding),
                          CustomTextField(
                            validator: SharedCode.emptyValidators,
                            controller: _phoneController,
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
                                  _birthdateController.text = SharedData.regularDateFormat.format(selectedDate);
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
                              icon: Iconsax.user_search,
                              value: _value,
                              items: _genderItems,
                              onChanged: (value) {
                                if (value != null) {
                                  setState(() {
                                    _value = value.toString();
                                  });
                                }
                              }),
                          const SizedBox(height: UiConstant.biggerSpacing),
                          CustomButton(
                            buttonText: AppLocalizations
                                .of(context)
                                .confirmAndContinue,
                            onPressed: () {
                              _panelController.open();
                            }
                          ),
                          const SizedBox(height: UiConstant.defaultPadding),
                          Expanded(child: Container()),
                          const SizedBox(height: UiConstant.defaultPadding),
                          Center(
                            child: RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(
                                    text: AppLocalizations
                                        .of(context)
                                        .alreadyHaveAccount,
                                    style: Theme
                                        .of(context)
                                        .textTheme
                                        .bodySmall
                                        ?.copyWith(color: ColorValues.grey50),
                                    children: [
                                      TextSpan(
                                          text:
                                          ' ${AppLocalizations
                                              .of(context)
                                              .letsLogin}',
                                          style: Theme
                                              .of(context)
                                              .textTheme
                                              .bodySmall
                                              ?.copyWith(
                                              color:
                                              Theme
                                                  .of(context)
                                                  .primaryColor,
                                              fontWeight: FontWeight.w800),
                                          recognizer: TapGestureRecognizer()
                                            ..onTap = () {}
                                      )
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
      ),
    );
  }

  Widget _buildStepWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        GestureDetector(
          onTap: () {
          },
          child: _buildStepItemWidget(
              1, AppLocalizations
              .of(context)
              .registerParent, true),
        ),
        const Icon(UniconsSolid.angle_right, color: ColorValues.grey20,),
        _buildStepItemWidget(
            2, AppLocalizations
            .of(context)
            .registerChild, false),
      ],
    );
  }

  Widget _buildLogo() {
    return Center(
      child: SvgPicture.asset(
        'assets/core/logo_app.svg',
        width: 80.w,
        height: 6.h,
        fit: BoxFit.contain,
      ),
    );
  }

  Row _buildStepItemWidget(int number, String text, bool isActive) {
    return Row(
      mainAxisAlignment: number == 1 ? MainAxisAlignment.end : MainAxisAlignment
          .start,
      children: [
        Container(
          decoration: BoxDecoration(
              color: Theme
                  .of(context)
                  .primaryColor, shape: BoxShape.circle),
          padding: const EdgeInsets.all(UiConstant.smallerSpacing),
          child: Text(
            number.toString(),
            style: Theme
                .of(context)
                .textTheme
                .bodySmall
                ?.copyWith(color: Colors.white),
          ),
        ),
        const SizedBox(
          width: UiConstant.smallerSpacing,
        ),
        Text(
          text,
          style: Theme
              .of(context)
              .textTheme
              .bodySmall
              ?.copyWith(
              color: isActive ? ColorValues.text50 : ColorValues.grey30,
              fontWeight: isActive ? FontWeight.w800 : null),
        ),
      ],
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
                      'assets/authentication/img_registration_success.svg',
                      width: 25.h,
                      height: 25.h,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                const SizedBox(height: UiConstant.sidePadding),
                Text(
                  AppLocalizations.of(context).parentRegistrationSuccessTitle,
                  style: Theme.of(context).textTheme.titleMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  AppLocalizations.of(context).parentRegistrationSuccessDescription,
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
          Row(children: [
            Expanded(child: CustomButton(
              buttonText: AppLocalizations.of(context).skip,
              colorAsOutlineButton: ColorValues.grey50,
              backgroundColor: ColorValues.slidingPanelBackground,
              onPressed: () {},
            )),
            const SizedBox(width: UiConstant.defaultPadding),
            Expanded(child: CustomButton(
              buttonText: AppLocalizations.of(context).registerChildAlt,
              onPressed: () {},
            )),
          ]),
        ],
      ),
    );
  }
}
