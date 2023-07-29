import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:jiffy/jiffy.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:sizer/sizer.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:swifties_technoscape/application/common/shared_code.dart';
import 'package:swifties_technoscape/application/service/shared_preferences_service.dart';
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

import '../../../application/repositories/saving/saving_repository.dart';

class SavingsPage extends StatefulWidget {
  const SavingsPage({Key? key}) : super(key: key);

  @override
  State<SavingsPage> createState() => _SavingsPageState();
}

class _SavingsPageState extends State<SavingsPage> {
  final _formKey = GlobalKey<FormState>();
  final PanelController _panelController = PanelController();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _targetController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();
  final TextEditingController _frequencyController = TextEditingController();
  final ValueNotifier<Widget> _panelContent =
      ValueNotifier(const SizedBox.shrink());
  final ValueNotifier<String> _selectedCategory = ValueNotifier('');
  final ValueNotifier<String> _selectedFrequency = ValueNotifier('');
  List<SavingModel> _savings = [];
  List<String> _savingCategories = [];
  late DateTime _endDate;
  bool _isLoading = true;
  int _balance = 0;

  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      context.loaderOverlay.show();
    });
    _getAllData();
    super.initState();
  }

  Future<void> _getAllData() async {
    if (!context.loaderOverlay.visible) {
      context.loaderOverlay.show();
    }
    try {
      if (mounted) {
        setState(() {
          _isLoading = true;
        });
      }
      _savings = await SavingRepository().getSavingList(null);
      _balance = 0;
      for (var data in _savings) {
        num amount = data.currentSaving;
        _balance += amount.toInt();
      }
      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      SharedCode.showSnackbar(
          context: context, message: e.toString(), isSuccess: false);
    }
    context.loaderOverlay.hide();
  }

  void _clearTextFields() {
    _titleController.clear();
    _targetController.clear();
    _endDateController.clear();
    _frequencyController.clear();
    _selectedCategory.value = '';
    _selectedFrequency.value = '';
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
                backdropColor: ColorValues.grey90,
                backdropOpacity: 0.32,
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(24),
                    topRight: Radius.circular(24)),
                boxShadow: [
                  BoxShadow(color: ColorValues.grey50.withOpacity(0))
                ],
                panel: _panelContent.value,
                body: GestureDetector(
                  onTap: () {
                    FocusScope.of(context).unfocus();
                  },
                  child: RefreshIndicator(
                    onRefresh: () async {
                      _getAllData();
                    },
                    child: Column(
                      children: [
                        CustomAppBar(
                          color: Colors.white,
                          hasBackButton: true,
                          body: Text(
                              AppLocalizations.of(context).createSavingTarget,
                              style: Theme.of(context).textTheme.titleMedium),
                        ),
                        Expanded(
                            child: Stack(
                          children: [
                            ListView(
                                physics: const AlwaysScrollableScrollPhysics()),
                            _isLoading
                                ? Container()
                                : SingleChildScrollView(
                                    physics:
                                        const AlwaysScrollableScrollPhysics(),
                                    padding: const EdgeInsets.symmetric(
                                        vertical: UiConstant.defaultSpacing),
                                    child: Column(children: [
                                      CustomSavingBalance(balance: _balance),
                                      const SizedBox(
                                          height: UiConstant.defaultSpacing),
                                      _buildAddSaving(),
                                      const SizedBox(
                                          height: UiConstant.defaultSpacing),
                                      _buildSavings(),
                                    ]),
                                  ),
                          ],
                        ))
                      ],
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }

  Widget _buildEmptyList(String title, String description) {
    return SizedBox(
      width: 100.w,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24),
        child: Column(children: [
          Text(
            title,
            style:
                Theme.of(context).textTheme.labelLarge?.copyWith(fontSize: 14),
          ),
          const SizedBox(height: UiConstant.mediumSpacing),
          Text(
            description,
            style: Theme.of(context)
                .textTheme
                .displayMedium
                ?.copyWith(fontSize: 12),
          )
        ]),
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
                        AppLocalizations.of(context).createNewTargetTitle,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: ColorValues.primary80, fontSize: 14),
                      ),
                      const SizedBox(height: UiConstant.mediumSpacing),
                      Text(
                        AppLocalizations.of(context).createNewTargetDescription,
                        style: Theme.of(context)
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
        padding: const EdgeInsets.symmetric(
            vertical: UiConstant.defaultPadding,
            horizontal: UiConstant.sidePadding),
        color: ColorValues.surface,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppLocalizations.of(context).yourSavingTargets,
              style: Theme.of(context)
                  .textTheme
                  .labelLarge
                  ?.copyWith(fontSize: 14),
            ),
            const SizedBox(height: 16),
            _savings.isEmpty
                ? _buildEmptyList(
                    AppLocalizations.of(context).targetEmptyTitle,
                    AppLocalizations.of(context).targetEmptyDescription)
                : ListView.separated(
                    primary: false,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _savings.length,
                    itemBuilder: (context, index) {
                      return CustomSaving(savingModel: _savings[index], index: index, setSavingModel: _setSavingModel,);
                    },
                    separatorBuilder: (_, __) {
                      return const SizedBox(height: UiConstant.defaultSpacing);
                    },
                  ),
            if (_savings.isNotEmpty) const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  void _setSavingModel(SavingModel savingModel, int index) {
    setState(() {
      _savings[index] = savingModel;
    });
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
        Text(title,
            style:
                Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 14))
      ]),
    );
  }

  Widget _buildCategoryPanel() {
    return Padding(
      padding: const EdgeInsets.all(UiConstant.sidePadding),
      child: ValueListenableBuilder(
          valueListenable: _selectedCategory,
          builder: (context, _, __) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildPanelTitle(
                    AppLocalizations.of(context).createNewSavingTarget),
                const SizedBox(height: 32),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(AppLocalizations.of(context).savingPurpose,
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(fontSize: 14)),
                        const SizedBox(height: 16),
                        ListView.separated(
                          primary: false,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: _savingCategories.length,
                          itemBuilder: (context, index) {
                            String category = _savingCategories[index];
                            bool isSelected =
                                _selectedCategory.value == category;

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
                                padding: const EdgeInsets.all(
                                    UiConstant.smallerPadding),
                                decoration: BoxDecoration(
                                  color:
                                      isSelected ? ColorValues.primary10 : null,
                                  borderRadius: BorderRadius.circular(
                                      UiConstant.smallerBorder),
                                  border: Border.all(
                                      color: isSelected
                                          ? ColorValues.primary50
                                          : ColorValues.grey10,
                                      width: 1),
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
                                  const SizedBox(
                                      width: UiConstant.defaultSpacing),
                                  Text(category,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium
                                          ?.copyWith(fontSize: 12))
                                ]),
                              ),
                            );
                          },
                          separatorBuilder: (_, __) {
                            return const SizedBox(
                                height: UiConstant.defaultSpacing);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                CustomButton(
                  buttonText: AppLocalizations.of(context).proceed,
                  onPressed: _selectedCategory.value == ''
                      ? null
                      : () {
                          _panelContent.value = _buildCreateTargetPanel();
                        },
                )
              ],
            );
          }),
    );
  }

  Widget _buildCreateTargetPanel() {
    return Padding(
      padding: const EdgeInsets.all(UiConstant.sidePadding),
      child: Form(
        key: _formKey,
        child: ValueListenableBuilder(
            valueListenable: _selectedFrequency,
            builder: (context, _, __) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildPanelTitle(
                      AppLocalizations.of(context).createNewSavingTarget),
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
                              hint:
                                  AppLocalizations.of(context).savingTargetHint,
                              textInputType: TextInputType.number,
                              onChanged: (value) {
                                SharedCode.rupiahTextField(value, _targetController);
                              },
                              icon: Iconsax.empty_wallet_time4),
                          const SizedBox(height: 16),
                          GestureDetector(
                            onTap: () async {
                              DateTime? selectedDate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime.now(),
                                  lastDate: DateTime(2100));
                              if (selectedDate != null) {
                                setState(() {
                                  _endDate = selectedDate;
                                  _endDateController.text = SharedData
                                      .monthYearDateFormat
                                      .format(selectedDate);
                                });
                              }
                            },
                            child: CustomTextField(
                              controller: _endDateController,
                              validator: SharedCode.emptyValidators,
                              isRequired: true,
                              label:
                                  AppLocalizations.of(context).whenSavingEnds,
                              hint:
                                  AppLocalizations.of(context).monthYearFormat,
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
                            Expanded(
                                child: _buildFrequencyChip(
                                    AppLocalizations.of(context).daily)),
                            Expanded(
                                child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: _buildFrequencyChip(
                                  AppLocalizations.of(context).weekly),
                            )),
                            Expanded(
                                child: _buildFrequencyChip(
                                    AppLocalizations.of(context).monthly)),
                          ])
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  CustomButton(
                    buttonText: AppLocalizations.of(context).seeSavingAdvice,
                    onPressed: _selectedFrequency.value == ''
                        ? null
                        : () {
                            _frequencyController.text =
                                _selectedFrequency.value;
                            _panelContent.value = _buildSavingAdvicePanel();
                          },
                  ),
                ],
              );
            }),
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
                ? Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(color: ColorValues.primary50, fontSize: 12)
                : Theme.of(context)
                    .textTheme
                    .displayMedium
                    ?.copyWith(color: ColorValues.greyBase, fontSize: 12),
          ),
        ),
      ),
    );
  }

  Widget _buildSavingAdvicePanel() {
    String frequency = AppLocalizations.of(context).perDay;
    switch (_frequencyController.text) {
      case 'Mingguan':
        frequency = AppLocalizations.of(context).perWeek;
        break;
      case 'Bulanan':
        frequency = AppLocalizations.of(context).perMonth;
        break;
    }

    int frequencyLength = 0;
    DateTime now = DateTime.now();
    now = DateTime(now.year, now.month, now.day);
    Jiffy date = Jiffy.parseFromDateTime(now);

    switch (_frequencyController.text) {
      case 'Harian':
        frequencyLength = Jiffy.parseFromDateTime(_endDate)
            .diff(date, unit: Unit.day)
            .toInt();
        debugPrint('days diff $frequencyLength');
        break;
      case 'Mingguan':
        frequencyLength = Jiffy.parseFromDateTime(_endDate)
            .diff(date, unit: Unit.week)
            .toInt();
        debugPrint('weeks diff $frequencyLength');
        break;
      case 'Bulanan':
        frequencyLength = Jiffy.parseFromDateTime(_endDate)
            .diff(date, unit: Unit.month)
            .toInt();
        debugPrint('months diff $frequencyLength');
        break;
    }

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(UiConstant.sidePadding,
              UiConstant.sidePadding, UiConstant.sidePadding, 0),
          child: _buildPanelTitle(AppLocalizations.of(context).savingAdvice),
        ),
        const SizedBox(height: 32),
        Expanded(
            child: SingleChildScrollView(
                child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: UiConstant.sidePadding),
              child: CustomTextField(
                controller: _targetController,
                label: AppLocalizations.of(context).savingTarget,
                icon: Iconsax.empty_wallet_time4,
                readOnly: true,
                isRequired: false,
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: UiConstant.sidePadding),
              child: CustomTextField(
                controller: _endDateController,
                label: AppLocalizations.of(context).whenSavingEnds,
                icon: Iconsax.calendar5,
                readOnly: true,
                isRequired: false,
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: UiConstant.sidePadding),
              child: CustomTextField(
                controller: _frequencyController,
                validator: SharedCode.emptyValidators,
                label: AppLocalizations.of(context).savingFrequency,
                icon: Iconsax.menu_board5,
                readOnly: true,
                isRequired: false,
              ),
            ),
            const SizedBox(height: 16),
            _buildSavingPerFrequency(frequency, frequencyLength),
          ],
        ))),
        const SizedBox(height: 24),
        Padding(
          padding: const EdgeInsets.fromLTRB(UiConstant.sidePadding, 0,
              UiConstant.sidePadding, UiConstant.sidePadding),
          child: Row(
            children: [
              Expanded(
                child: CustomButton(
                  buttonText:
                      AppLocalizations.of(context).createSavingTargetButton,
                  onPressed: () async {
                    context.loaderOverlay.show();
                    try {
                      SavingModel savingModel = SavingModel(
                          title: _titleController.text,
                          category: _selectedCategory.value,
                          frequency: frequency,
                          hasClaimedReward: SharedPreferencesService.getUserData()!.relatedId == null ? null : false,
                          savingAdviceAmount: SharedCode.formatFromRupiah(
                                  _targetController.text) /
                              frequencyLength,
                          currentSaving: 0,
                          savingTarget: SharedCode.formatFromRupiah(
                              _targetController.text),
                          startDate: DateTime.now(),
                          endDate: _endDate,
                          createdAt: DateTime.now());
                      String id = await SavingRepository().addSaving(savingModel);
                      savingModel = savingModel.copyWith(id: id);
                      List<SavingModel> list = [];
                      list.add(savingModel);
                      list.addAll(_savings);
                      SharedCode.showSnackbar(
                          context: context,
                          message:
                              AppLocalizations.of(context).savingTargetCreated);
                      _clearTextFields();
                      setState(() {
                        _savings = list;
                      });
                      _panelController.close();
                    } catch (e) {
                      SharedCode.showSnackbar(
                          context: context,
                          message: e.toString(),
                          isSuccess: false);
                    }
                    context.loaderOverlay.hide();
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSavingPerFrequency(String frequency, int frequencyLength) {
    return Container(
      width: 100.w,
      padding: const EdgeInsets.symmetric(
          vertical: UiConstant.defaultPadding,
          horizontal: UiConstant.sidePadding),
      color: ColorValues.primary10,
      child: Row(children: [
        Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(UiConstant.smallerBorder),
              color: ColorValues.primary20),
          child: const Icon(
            Iconsax.empty_wallet_time4,
            color: ColorValues.primary50,
            size: 48,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(children: [
              Text('${AppLocalizations.of(context).savingAdvice} ',
                  style: Theme.of(context)
                      .textTheme
                      .displayMedium
                      ?.copyWith(fontSize: 14)),
              Text(frequency,
                  style: Theme.of(context)
                      .textTheme
                      .displayLarge
                      ?.copyWith(fontSize: 14)),
            ]),
            const SizedBox(height: 4),
            Row(children: [
              Text('Rp ',
                  style: Theme.of(context)
                      .textTheme
                      .displayMedium
                      ?.copyWith(fontSize: 20)),
              Text(
                  SharedCode.formatThousands(
                      SharedCode.formatFromRupiah(_targetController.text) /
                          frequencyLength),
                  style: Theme.of(context)
                      .textTheme
                      .displayLarge
                      ?.copyWith(fontSize: 20)),
            ])
          ],
        ))
      ]),
    );
  }
}
