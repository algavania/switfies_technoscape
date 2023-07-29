import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sizer/sizer.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:swifties_technoscape/application/common/shared_code.dart';
import 'package:swifties_technoscape/data/models/saving/saving_model.dart';
import 'package:swifties_technoscape/l10n/l10n.dart';
import 'package:swifties_technoscape/presentation/core/color_values.dart';
import 'package:swifties_technoscape/presentation/core/shared_data.dart';
import 'package:swifties_technoscape/presentation/core/ui_constant.dart';
import 'package:swifties_technoscape/presentation/widgets/custom_app_bar.dart';
import 'package:swifties_technoscape/presentation/widgets/custom_button.dart';
import 'package:swifties_technoscape/presentation/widgets/custom_saving.dart';
import 'package:swifties_technoscape/presentation/widgets/custom_saving_balance.dart';
import 'package:swifties_technoscape/presentation/widgets/custom_shadow.dart';
import 'package:swifties_technoscape/presentation/widgets/custom_text_field.dart';

class SavingsPage extends StatefulWidget {
  const SavingsPage({Key? key}) : super(key: key);

  @override
  State<SavingsPage> createState() => _SavingsPageState();
}

class _SavingsPageState extends State<SavingsPage> {
  final _formKey = GlobalKey<FormState>();
  final PanelController _panelController = PanelController();
  final SavingModel _dummySaving1 = SavingModel(title: 'Beli Laptop', category: 'Pendidikan', currentSaving: 120000, savingTarget: 12000000, startDate: DateTime.now(), endDate: DateTime.now());
  final SavingModel _dummySaving2 = SavingModel(title: 'Beli PS5', category: 'Hiburan', currentSaving: 164000, savingTarget: 8400000, startDate: DateTime.now(), endDate: DateTime.now());
  final SavingModel _dummySaving3 = SavingModel(title: 'Beli S500', category: 'Kendaraan', currentSaving: 600000000, savingTarget: 6000000000, startDate: DateTime.now(), endDate: DateTime.now());
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _targetController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();
  final ValueNotifier<Widget> _panelContent = ValueNotifier(const SizedBox.shrink());
  final ValueNotifier<String> _selectedCategory = ValueNotifier('');
  final ValueNotifier<String> _selectedFrequency = ValueNotifier('');
  List<SavingModel> _savings = [];
  List<String> _savingCategories = [];

  @override
  void initState() {
    _savings = [_dummySaving1, _dummySaving2, _dummySaving3];

    super.initState();
  }

  void _getCategories() {
    _savingCategories = [
      AppLocalizations.of(context).education,
      AppLocalizations.of(context).entertainment,
      AppLocalizations.of(context).vehicle,
      AppLocalizations.of(context).others
    ];
  }

  @override
  Widget build(BuildContext context) {
    _getCategories();

    return Scaffold(
      body: SafeArea(
        child: ValueListenableBuilder(
          valueListenable: _panelContent,
          builder: (context, _, __) {
            return SlidingUpPanel(
              controller: _panelController,
              minHeight: 0,
              maxHeight: 80.h,
              backdropTapClosesPanel: false,
              color: ColorValues.slidingPanelBackground,
              backdropEnabled: true,
              backdropColor: ColorValues.grey50,
              backdropOpacity: 0.32,
              borderRadius: const BorderRadius.only(topLeft: Radius.circular(24), topRight: Radius.circular(24)),
              boxShadow: [BoxShadow(color: ColorValues.grey50.withOpacity(0))],
              panel: Padding(
                padding: const EdgeInsets.all(UiConstant.sidePadding),
                child: _panelContent.value,
              ),
              body: Column(
                children: [
                  CustomAppBar(
                    color: Colors.white,
                    hasBackButton: true,
                    body: Text(AppLocalizations.of(context).createSavingTarget, style: Theme.of(context).textTheme.titleMedium),
                  ),
                  Expanded(child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(vertical: UiConstant.defaultSpacing),
                    child: Column(children: [
                      const CustomSavingBalance(balance: 2200000),
                      const SizedBox(height: UiConstant.defaultSpacing),
                      _buildAddSaving(),
                      const SizedBox(height: UiConstant.defaultSpacing),
                      _buildSavings(),
                    ]),
                  ))
                ],
              ),
            );
          }
        ),
      ),
    );
  }

  Widget _buildAddSaving() {
    return CustomShadow(
      child: InkWell(
        onTap: () {
          _panelContent.value = _buildCategoryPanel();
          _panelController.open();
        },
        child: Container(
          padding: const EdgeInsets.symmetric(
              vertical: UiConstant.defaultPadding,
              horizontal: UiConstant.sidePadding),
          color: ColorValues.primary10,
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(UiConstant.smallerBorder),
                child: Image.asset(
                  'assets/activity/img_child.png',
                  width: 62,
                  height: 62,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: UiConstant.defaultPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppLocalizations
                            .of(context)
                            .createNewTargetTitle,
                        style: Theme
                            .of(context)
                            .textTheme
                            .titleLarge
                            ?.copyWith(
                            color: ColorValues.primary80, fontSize: 14),
                      ),
                      const SizedBox(height: UiConstant.mediumSpacing),
                      Text(
                        AppLocalizations
                            .of(context)
                            .createNewTargetDescription,
                        style: Theme
                            .of(context)
                            .textTheme
                            .displayMedium
                            ?.copyWith(fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ),
              const Icon(
                Iconsax.arrow_right_3,
                color: ColorValues.primary90,
                size: 24,
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSavings() {
    return CustomShadow(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: UiConstant.defaultPadding, horizontal: UiConstant.sidePadding),
        color: ColorValues.surface,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppLocalizations.of(context).createNewTargetTitle,
              style: Theme.of(context).textTheme.labelLarge?.copyWith(fontSize: 14),
            ),
            const SizedBox(height: 16),
            ListView.separated(
              primary: false,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _savings.length,
              itemBuilder: (context, index) {
                return CustomSaving(savingModel: _savings[index]);
              },
              separatorBuilder: (_, __) {
                return const SizedBox(height: UiConstant.defaultSpacing);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPanelTitle(String title) {
    return GestureDetector(
      onTap: () => _panelController.close(),
      child: Row(children: [
        const Icon(
          Iconsax.arrow_left,
          size: 24,
          color: ColorValues.text50,
        ),
        const SizedBox(width: 16),
        Text(title, style: Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 14))
      ]),
    );
  }

  Widget _buildCategoryPanel() {
    return ValueListenableBuilder(
      valueListenable: _selectedCategory,
      builder: (context, _, __) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildPanelTitle(AppLocalizations.of(context).createNewSavingTarget),
            const SizedBox(height: 32),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                        AppLocalizations.of(context).savingPurpose,
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 14)
                    ),
                    const SizedBox(height: 16),
                    ListView.separated(
                      primary: false,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: _savingCategories.length,
                      itemBuilder: (context, index) {
                        String category = _savingCategories[index];
                        bool isSelected = _selectedCategory.value == category;

                        IconData iconData = Iconsax.more_square5;
                        switch (category) {
                          case 'Pendidikan':
                            iconData = Iconsax.teacher5;
                            break;
                          case 'Hiburan':
                            iconData = Iconsax.game5;
                            break;
                          case 'Kendaraan':
                            iconData = Iconsax.car5;
                            break;
                        }

                        return InkWell(
                          onTap: () {
                            if (isSelected) {
                              _selectedCategory.value = '';
                            } else {
                              _selectedCategory.value = category;
                            }
                          },
                          child: Container(
                            width: 100.w,
                            padding: const EdgeInsets.all(UiConstant.smallerPadding),
                            decoration: BoxDecoration(
                              color: isSelected ? ColorValues.primary10 : null,
                              borderRadius: BorderRadius.circular(UiConstant.smallerBorder),
                              border: Border.all(color: isSelected ? ColorValues.primary50 : ColorValues.grey10, width: 1),
                            ),
                            child: Row(children: [
                              Container(
                                padding: const EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  color: ColorValues.primary10,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Icon(
                                  iconData,
                                  size: 24,
                                  color: ColorValues.primary50,
                                ),
                              ),
                              const SizedBox(width: UiConstant.defaultSpacing),
                              Text(category, style: Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 12))
                            ]),
                          ),
                        );
                      },
                      separatorBuilder: (_, __) {
                        return const SizedBox(height: UiConstant.defaultSpacing);
                      },
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            CustomButton(
              buttonText: AppLocalizations.of(context).proceed,
              onPressed: _selectedCategory.value == '' ? null : () {
                _panelContent.value = _buildCreateTargetPanel();
              },
            )
          ],
        );
      }
    );
  }

  Widget _buildCreateTargetPanel() {
    return Form(
      key: _formKey,
      child: ValueListenableBuilder(
        valueListenable: _selectedFrequency,
        builder: (context, _, __) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildPanelTitle(AppLocalizations.of(context).createNewSavingTarget),
              const SizedBox(height: 32),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomTextField(
                        controller: _titleController,
                        validator: SharedCode.emptyValidators,
                        isRequired: true,
                        label: AppLocalizations.of(context).savingTitle,
                        hint: AppLocalizations.of(context).savingTitleHint,
                        icon: Iconsax.status_up5,
                      ),
                      const SizedBox(height: 16),
                      CustomTextField(
                          controller: _targetController,
                          validator: SharedCode.emptyValidators,
                          isRequired: true,
                          label: AppLocalizations.of(context).savingTarget,
                          hint: AppLocalizations.of(context).savingTargetHint,
                          icon: Iconsax.empty_wallet_time4
                      ),
                      const SizedBox(height: 16),
                      GestureDetector(
                        onTap: () async {
                          DateTime? selectedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(1900),
                              lastDate: DateTime(2100));
                          if (selectedDate != null) {
                            setState(() {
                              _endDateController.text = SharedData.monthYearDateFormat.format(selectedDate);
                            });
                          }
                        },
                        child: CustomTextField(
                          controller: _endDateController,
                          validator: SharedCode.emptyValidators,
                          isRequired: true,
                          label: AppLocalizations.of(context).birthdate,
                          hint: AppLocalizations.of(context).chooseBirthdate,
                          icon: Iconsax.calendar5,
                          readOnly: true,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        AppLocalizations.of(context).savingFrequency,
                        style: Theme.of(context).textTheme.displaySmall,
                      ),
                      const SizedBox(height: 8),
                      Row(children: [
                        Expanded(child: _buildFrequencyChip(AppLocalizations.of(context).daily)),
                        Expanded(child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: _buildFrequencyChip(AppLocalizations.of(context).weekly),
                        )),
                        Expanded(child: _buildFrequencyChip(AppLocalizations.of(context).monthly)),
                      ])
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              CustomButton(
                buttonText: AppLocalizations.of(context).seeSavingAdvice,
                onPressed: _selectedFrequency.value == '' ? null : () {
                },
              ),
            ],
          );
        }
      ),
    );
  }

  Widget _buildFrequencyChip(String frequency) {
    bool isSelected = _selectedFrequency.value == frequency;

    return InkWell(
      onTap: () {
        if (isSelected) {
          _selectedFrequency.value = '';
        } else {
          _selectedFrequency.value = frequency;
        }
      },
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: isSelected ? ColorValues.primary10 : null,
          borderRadius: BorderRadius.circular(UiConstant.smallerBorder),
          border: Border.all(
            color: isSelected ? ColorValues.primary50 : ColorValues.grey10,
            width: 1,
          ),
        ),
        child: Center(
          child: Text(
            frequency,
            style: isSelected
              ? Theme.of(context).textTheme.titleMedium?.copyWith(
                color: ColorValues.primary50,
                fontSize: 12
              )
              : Theme.of(context).textTheme.displayMedium?.copyWith(
                color: ColorValues.greyBase,
                fontSize: 12
              ),
          ),
        ),
      ),
    );
  }
}
