import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:sizer/sizer.dart';
import 'package:swifties_technoscape/application/common/shared_code.dart';
import 'package:swifties_technoscape/application/repositories/repositories.dart';
import 'package:swifties_technoscape/data/models/article/article_model.dart';
import 'package:swifties_technoscape/data/models/transaction/transaction_model.dart';
import 'package:swifties_technoscape/l10n/l10n.dart';
import 'package:swifties_technoscape/presentation/core/color_values.dart';
import 'package:swifties_technoscape/presentation/core/shared_data.dart';
import 'package:swifties_technoscape/presentation/core/ui_constant.dart';
import 'package:swifties_technoscape/presentation/widgets/custom_app_bar.dart';
import 'package:swifties_technoscape/presentation/widgets/custom_article.dart';
import 'package:swifties_technoscape/presentation/widgets/custom_button.dart';
import 'package:swifties_technoscape/presentation/widgets/custom_child_account.dart';
import 'package:swifties_technoscape/presentation/widgets/custom_shadow.dart';
import 'package:swifties_technoscape/presentation/widgets/custom_text_field.dart';
import 'package:swifties_technoscape/presentation/widgets/custom_transaction.dart';

import '../../../../application/common/db_constants.dart';
import '../../../../application/service/shared_preferences_service.dart';
import '../../../../data/models/account/account_model.dart';
import '../../../../data/models/saving/saving_model.dart';
import '../../../../data/models/user/user_model.dart';
import '../../../routes/router.gr.dart';

class HomePage extends StatefulWidget {
  final Function openPanel, closePanel;
  const HomePage({Key? key, required this.openPanel, required this.closePanel}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ValueNotifier<bool> _isBalanceVisible = ValueNotifier(false);
  final ValueNotifier<bool> _isBalancePanelVisible = ValueNotifier(false);
  final ValueNotifier<String> _selectedIdentifier = ValueNotifier('No. Rekening');
  final TextEditingController _identifierController = TextEditingController();
  final TextEditingController _transferAmountController = TextEditingController();
  final TextEditingController _transferMessageController = TextEditingController();
  List<UserModel> _childList = [];
  List<ArticleModel> _articleList = [];
  List<TransactionModel> _transactionList = [];
  bool _isLoading = true;
  bool _isParent = true;

  @override
  void initState() {
    _isParent = SharedPreferencesService.getUserData()!.role == DbConstants.parentRole;
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
      List<AccountModel> accounts = await BankRepository().getAllAccount();
      List<SavingModel> savings = await SavingRepository().getSavingList(null);
      if (accounts.isNotEmpty) {
        AccountModel account = accounts.first;
        num balance = account.balance;
        for (var data in savings) {
          balance -= data.currentSaving;
        }
        account = account.copyWith(balance: balance.toDouble());
        SharedData.myAccountData.value = account;
      }
      if (_isParent) {
        _childList = await UserRepository().getMyChildren(limit: 2);
        _transactionList = await TransactionRepository().getTransactions(limit: 2, isRequestedTransaction: true);
      }
      _articleList = await ArticleRepository().getArticleList(2);
      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      SharedCode.showSnackbar(context: context, message: e.toString(), isSuccess: false);
    }
    context.loaderOverlay.hide();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: RefreshIndicator(
        onRefresh: () async {
          _getAllData();
        },
        child: Column(
          children: [
            CustomAppBar(
              needSpacing: true,
              body: ClipRRect(
                borderRadius: BorderRadius.circular(UiConstant.smallerBorder),
                child: Image.network(
                  'https://t4.ftcdn.net/jpg/00/64/67/27/360_F_64672736_U5kpdGs9keUll8CRQ3p3YaEv2M6qkVY5.jpg',
                  width: 40,
                  height: 40,
                ),
              ),
            ),
            Expanded(
              child: Stack(
                children: [
                  ListView(physics: const AlwaysScrollableScrollPhysics()),
                  _isLoading
                      ? Container()
                      : SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: Column(
                      children: [
                        _buildBalance(),
                        _buildActions(),
                        const SizedBox(height: UiConstant.defaultSpacing),
                        _buildMenus(),
                        const SizedBox(height: UiConstant.defaultSpacing),
                        if (_isParent) _buildApprovalRequests(),
                        if (_isParent) const SizedBox(height: UiConstant.defaultSpacing),
                        if (_isParent) _buildChildrenAccounts(),
                        if (_isParent)  const SizedBox(height: UiConstant.defaultSpacing),
                        _buildArticles(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBalance() {
    return ValueListenableBuilder(
        valueListenable: _isBalanceVisible,
        builder: (context, _, __) {
          return Container(
            padding: const EdgeInsets.symmetric(
                vertical: UiConstant.defaultPadding,
                horizontal: UiConstant.sidePadding),
            color: ColorValues.surface,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(AppLocalizations.of(context).mainBalance,
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
            ),
          );
        });
  }

  Widget _buildActions() {
    return Container(
      padding: const EdgeInsets.fromLTRB(32, 8, 32, UiConstant.defaultPadding),
      color: ColorValues.surface,
      child: Row(children: [
        Expanded(child: _buildActionButton(
          AppLocalizations.of(context).topup,
          Iconsax.direct_down5,
              () {},
        )),
        Expanded(child: _buildActionButton(
          AppLocalizations.of(context).transferIn,
          Iconsax.direct_inbox5,
              () {},
        )),
        Expanded(child: _buildActionButton(
          AppLocalizations.of(context).transferOut,
          Iconsax.direct_up5,
          () {
            widget.openPanel(_buildTransferPanel());
          },
        )),
      ]),
    );
  }

  Widget _buildActionButton(String title, IconData iconData, Function() onTap) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: ColorValues.primary10,
            ),
            child: Icon(
              iconData,
              size: 24,
              color: ColorValues.primary50,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: Theme.of(context).textTheme.displayMedium?.copyWith(fontSize: 12),
            textAlign: TextAlign.center,
          )
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

  Widget _buildMenus() {
    return CustomShadow(
      isShadowAbove: true,
      child: Container(
        padding: const EdgeInsets.all(UiConstant.defaultPadding),
        color: ColorValues.surface,
        child: Row(
          children: [
            Expanded(
              child: _buildMenuItem(
                title: AppLocalizations.of(context).createSavingTargetAlt,
                iconData: Iconsax.status_up5,
                iconColor: ColorValues.primary50,
                backgroundColor: ColorValues.primary10,
                onTap: () => AutoRouter.of(context).navigate(const SavingsRoute()),
              ),
            ),
            Expanded(
              child: _buildMenuItem(
                title: AppLocalizations.of(context).saveNowAlt,
                iconData: Iconsax.direct_inbox5,
                iconColor: ColorValues.success30,
                backgroundColor: ColorValues.success10,
                onTap: () {
                  AutoRouter.of(context).push(const SaveNowRoute());
                },
              ),
            ),
            Expanded(
              child: _buildMenuItem(
                title: AppLocalizations.of(context).interestCalculator,
                iconData: Iconsax.calculator5,
                iconColor: ColorValues.danger30,
                backgroundColor: ColorValues.danger10,
                onTap: () {},
              ),
            ),
            Expanded(
              child: _buildMenuItem(
                title: AppLocalizations.of(context).financeArticle,
                iconData: Iconsax.document_text5,
                iconColor: ColorValues.warning30,
                backgroundColor: ColorValues.warning10,
                onTap: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem({required String title, required IconData iconData, required Color iconColor, required Color backgroundColor, required Function() onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Column(children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(UiConstant.smallerBorder)
          ),
          child: Icon(
            iconData,
            color: iconColor,
            size: 24,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          title,
          style: Theme.of(context).textTheme.displayMedium?.copyWith(fontSize: 12),
          textAlign: TextAlign.center,
        )
      ]),
    );
  }


  Widget _buildSectionHeading(
      {required String title,
      required String description,
      required Function() onTap, required bool isListEmpty}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(children: [
          Expanded(
              child: Text(
            title,
            style: Theme.of(context).textTheme.labelLarge,
          )),
          if (!isListEmpty) GestureDetector(
            onTap: onTap,
            child: Text(
              AppLocalizations.of(context).seeAll,
              style: Theme.of(context).textTheme.displayMedium?.copyWith(
                  fontSize: 12, color: Theme.of(context).primaryColor),
            ),
          )
        ]),
        const SizedBox(height: UiConstant.mediumSpacing),
        Text(
          description,
          style:
              Theme.of(context).textTheme.displayMedium?.copyWith(fontSize: 12),
        )
      ],
    );
  }

  Widget _buildApprovalRequests() {
    return CustomShadow(
      isShadowAbove: true,
      child: Container(
        padding: const EdgeInsets.symmetric(
            vertical: UiConstant.defaultPadding,
            horizontal: UiConstant.sidePadding),
        color: ColorValues.surface,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionHeading(
                isListEmpty: _transactionList.isEmpty,
                title: AppLocalizations.of(context).approvalRequestTitle,
                description:
                    AppLocalizations.of(context).approvalRequestDescription,
                onTap: () {}),
            const SizedBox(height: 16),
            _transactionList.isEmpty
                ? _buildEmptyList(
                    AppLocalizations.of(context).requestsEmptyTitle,
                    AppLocalizations.of(context).requestsEmptyDescription)
                : ListView.separated(
                    primary: false,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _transactionList.length,
                    itemBuilder: (context, index) {
                      return CustomTransaction(
                          transactionModel: _transactionList[index]);
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

  Widget _buildChildrenAccounts() {
    return CustomShadow(
      isShadowAbove: true,
      child: Container(
        padding: const EdgeInsets.symmetric(
            vertical: UiConstant.defaultPadding,
            horizontal: UiConstant.sidePadding),
        color: ColorValues.surface,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionHeading(
                isListEmpty: _childList.isEmpty,
                title: AppLocalizations.of(context).childrenAccountsTitle,
                description:
                    AppLocalizations.of(context).childrenAccountsDescription,
                onTap: () {}),
            const SizedBox(height: 16),
            _childList.isEmpty
                ? _buildEmptyList(
                    AppLocalizations.of(context).childrenAccountEmptyTitle,
                    AppLocalizations.of(context)
                        .childrenAccountEmptyDescription)
                : ListView.separated(
                    primary: false,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _childList.length,
                    itemBuilder: (context, index) {
                      return CustomChildAccount(
                        user: _childList[index],
                      );
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

  Widget _buildArticles() {
    return CustomShadow(
      isShadowAbove: true,
      child: Container(
        padding: const EdgeInsets.symmetric(
            vertical: UiConstant.defaultPadding,
            horizontal: UiConstant.sidePadding),
        color: ColorValues.surface,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionHeading(
                isListEmpty: _articleList.isEmpty,
                title: AppLocalizations.of(context).duitKiddoArticleTitle,
                description:
                    AppLocalizations.of(context).duitKiddoArticleDescription,
                onTap: () {}),
            const SizedBox(height: 16),
            _articleList.isEmpty
                ? _buildEmptyList(
                    AppLocalizations.of(context).articleEmptyTitle,
                    AppLocalizations.of(context).articleEmptyDescription)
                : ListView.separated(
                    primary: false,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _articleList.length,
                    itemBuilder: (context, index) {
                      return CustomArticle(article: _articleList[index]);
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

  Widget _buildTransferPanel() {
    return Padding(
      padding: const EdgeInsets.all(UiConstant.sidePadding),
      child: ValueListenableBuilder(
        valueListenable: _selectedIdentifier,
        builder: (context, _, __) {
          bool isAccountId = _selectedIdentifier.value == AppLocalizations.of(context).accountId;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildPanelTitle(AppLocalizations.of(context).transferToOtherUser),
              const SizedBox(height: 16),
              Expanded(child: SingleChildScrollView(
                child: Column(children: [
                  Row(children: [
                    Expanded(
                      child: _buildIdentifierChip(
                        AppLocalizations.of(context).accountId,
                        Iconsax.empty_wallet5,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: _buildIdentifierChip(
                        AppLocalizations.of(context).username,
                        Iconsax.frame5,
                      ),
                    ),
                  ]),
                  const SizedBox(height: 24),
                  CustomTextField(
                    controller: _identifierController,
                    isRequired: true,
                    textInputType: isAccountId ? TextInputType.number : null,
                    validator: SharedCode.emptyValidators,
                    icon: isAccountId ? Iconsax.empty_wallet5 : Iconsax.frame5,
                    label: isAccountId ? AppLocalizations.of(context).receiverAccountId : AppLocalizations.of(context).receiverUsername,
                    hint: isAccountId ? AppLocalizations.of(context).enterAccountId : AppLocalizations.of(context).enterUsername,
                  ),
                ]),
              )),
              const SizedBox(height: 16),
              CustomButton(
                buttonText: AppLocalizations.of(context).validateReceiverAccount,
                onPressed: () {
                  widget.closePanel();
                  widget.openPanel(_buildValidationPanel());
                },
              )
            ],
          );
        }
      ),
    );
  }

  Widget _buildPanelTitle(String title) {
    return GestureDetector(
      onTap: () => widget.closePanel(),
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

  Widget _buildIdentifierChip(String title, IconData iconData) {
    return InkWell(
      onTap: () {
        if (_selectedIdentifier.value != title) {
          _selectedIdentifier.value = title;
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: UiConstant.smallerPadding, horizontal: UiConstant.mediumPadding),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(width: 1, color: ColorValues.primary50),
          color: _selectedIdentifier.value == title ? ColorValues.primary10 : null,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              iconData,
              size: 16,
              color: ColorValues.primary50,
            ),
            const SizedBox(width: 8),
            Text(
                title,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(color: ColorValues.primary50, fontSize: 12)
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildValidationPanel() {
    bool isAccountId = _selectedIdentifier.value == AppLocalizations.of(context).accountId;
    bool isAccountValid = true;

    return Padding(
      padding: const EdgeInsets.all(UiConstant.sidePadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildPanelTitle(AppLocalizations.of(context).receiverAccountValidation),
          const SizedBox(height: 16),
          Expanded(child: SingleChildScrollView(
            child: Column(children: [
              AbsorbPointer(
                child: Row(children: [
                  Expanded(
                    child: _buildIdentifierChip(
                      AppLocalizations.of(context).accountId,
                      Iconsax.empty_wallet5,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _buildIdentifierChip(
                      AppLocalizations.of(context).username,
                      Iconsax.frame5,
                    ),
                  ),
                ]),
              ),
              const SizedBox(height: 24),
              CustomTextField(
                readOnly: true,
                controller: _identifierController,
                isRequired: true,
                textInputType: isAccountId ? TextInputType.number : null,
                validator: SharedCode.emptyValidators,
                icon: isAccountId ? Iconsax.empty_wallet5 : Iconsax.frame5,
                label: isAccountId ? AppLocalizations.of(context).receiverAccountId : AppLocalizations.of(context).receiverUsername,
                hint: isAccountId ? AppLocalizations.of(context).enterAccountId : AppLocalizations.of(context).enterUsername,
              ),
              const SizedBox(height: 16),
              isAccountValid ? _buildReceiverProfile('Fulan bin Fulan', 'fulanbinfulan', '100 000 000 1', isValidating: true) : _buildAccountNotFound()
            ]),
          )),
          const SizedBox(height: 16),
          isAccountValid ? Row(
            children: [
              Expanded(
                child: CustomButton(
                  buttonText: AppLocalizations.of(context).changeReceiver,
                  backgroundColor: ColorValues.slidingPanelBackground,
                  colorAsOutlineButton: ColorValues.text50,
                  onPressed: () {
                    widget.closePanel();
                    widget.openPanel(_buildTransferPanel());
                  },
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: CustomButton(
                  buttonText: AppLocalizations.of(context).proceed,
                  onPressed: () {
                    widget.closePanel();
                    widget.openPanel(_buildAmountPanel());
                  },
                ),
              ),
            ],
          ) : CustomButton(
            buttonText: AppLocalizations.of(context).changeReceiver,
            onPressed: () {
              widget.closePanel();
              widget.openPanel(_buildTransferPanel());
            },
          )
        ],
      ),
    );
  }

  Widget _buildReceiverProfile(String name, String username, String accountId, {isValidating = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          isValidating ? AppLocalizations.of(context).accountFound : AppLocalizations.of(context).receiverAccount,
          style: Theme.of(context).textTheme.displaySmall,
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(vertical: UiConstant.mediumPadding, horizontal: UiConstant.defaultPadding),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(UiConstant.smallerBorder),
            color: ColorValues.success10,
          ),
          child: Row(children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                'assets/activity/img_child_3.png',
                width: 32,
                height: 32,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(fontSize: 12),
                ),
                const SizedBox(height: 4),
                Row(children: [
                  Text(
                    username,
                    style: Theme.of(context).textTheme.displayMedium?.copyWith(fontSize: 12),
                  ),
                  Container(
                    width: 4,
                    height: 4,
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    decoration: BoxDecoration(
                      color: ColorValues.greyBase,
                      borderRadius: BorderRadius.circular(4)
                    ),
                  ),
                  Text(
                    accountId,
                    style: Theme.of(context).textTheme.displayMedium?.copyWith(fontSize: 12),
                  ),
                ]),
              ],
            )),
            const Icon(
              Iconsax.arrow_right_3,
              color: ColorValues.grey90,
              size: 16,
            )
          ]),
        ),
      ],
    );
  }

  Widget _buildAccountNotFound() {
    return Container(
      width: 100.w,
      padding: const EdgeInsets.symmetric(vertical: UiConstant.mediumPadding, horizontal: UiConstant.defaultPadding),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(UiConstant.smallerBorder),
        color: ColorValues.danger10,
      ),
      child: Column(children: [
        Text(
          AppLocalizations.of(context).accountNotFound,
          style: Theme.of(context).textTheme.labelLarge?.copyWith(fontSize: 14),
        ),
        const SizedBox(height: UiConstant.mediumSpacing),
        Text(
          AppLocalizations.of(context).accountNotFoundDescription,
          style: Theme.of(context).textTheme.displayMedium?.copyWith(fontSize: 12),
        )
      ]),
    );
  }

  Widget _buildAmountPanel() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: UiConstant.sidePadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: UiConstant.sidePadding),
            child: _buildPanelTitle(AppLocalizations.of(context).enterAmount),
          ),
          const SizedBox(height: 24),
          Expanded(child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: UiConstant.sidePadding),
                  child: _buildReceiverProfile('Fulan bin Fulan', 'fulanbinfulan', '100 000 000 1'),
                ),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: UiConstant.sidePadding),
                  child: Text(
                    AppLocalizations.of(context).senderAccount,
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: UiConstant.defaultPadding, horizontal: UiConstant.sidePadding),
                  decoration: const BoxDecoration(
                    border: Border(
                      top: BorderSide(color: ColorValues.grey10, width: 1),
                      bottom: BorderSide(color: ColorValues.grey10, width: 1),
                    )
                  ),
                  child: Column(
                    children: [
                      Row(children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            'https://t4.ftcdn.net/jpg/00/64/67/27/360_F_64672736_U5kpdGs9keUll8CRQ3p3YaEv2M6qkVY5.jpg',
                            width: 32,
                            height: 32,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(width: UiConstant.defaultSpacing),
                        Expanded(
                          child: Text(
                            'Fulan bin Fulan',
                            style: Theme.of(context).textTheme.labelLarge?.copyWith(fontSize: 12),
                          ),
                        ),
                        const SizedBox(width: UiConstant.defaultSpacing),
                        GestureDetector(
                          onTap: () {},
                          child: Row(children: [
                            Text(
                              '100 000 000 1',
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
                      const SizedBox(height: 16),
                      ValueListenableBuilder(
                          valueListenable: _isBalancePanelVisible,
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
                                    child: _isBalancePanelVisible.value
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
                                  _buildBalanceToggle(_isBalancePanelVisible),
                                ]),
                              ],
                            );
                          })
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: UiConstant.sidePadding),
                  child: CustomTextField(
                    controller: _transferAmountController,
                    isRequired: true,
                    textInputType: TextInputType.number,
                    validator: SharedCode.emptyValidators,
                    icon: Iconsax.empty_wallet5,
                    label: AppLocalizations.of(context).amount,
                    hint: AppLocalizations.of(context).enterAmount,
                  ),
                ),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: UiConstant.sidePadding),
                  child: CustomTextField(
                    controller: _transferMessageController,
                    isRequired: false,
                    showOptional: true,
                    icon: Iconsax.document_text5,
                    label: AppLocalizations.of(context).message,
                    hint: AppLocalizations.of(context).enterMessage,
                  ),
                ),
              ]
            ),
          )),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: UiConstant.sidePadding),
            child: CustomButton(
              buttonText: AppLocalizations.of(context).proceed,
              onPressed: () {
              },
            ),
          )
        ],
      ),
    );
  }
}
