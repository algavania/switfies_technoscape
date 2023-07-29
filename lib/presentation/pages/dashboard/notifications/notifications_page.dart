import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:swifties_technoscape/data/models/transaction/transaction_model.dart';
import 'package:swifties_technoscape/l10n/l10n.dart';
import 'package:swifties_technoscape/presentation/core/color_values.dart';
import 'package:swifties_technoscape/presentation/core/ui_constant.dart';
import 'package:swifties_technoscape/presentation/widgets/custom_app_bar.dart';
import 'package:swifties_technoscape/presentation/widgets/custom_transaction.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({Key? key}) : super(key: key);

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  final TransactionModel _dummyTrax1 = const TransactionModel(uid: 0, amount: 200000, createTime: 1690625019447, senderAccountNo: '', traxType: 'Transfer Out', receiverAccountNo: '', senderName: 'Fulan bin Fulan', receiverName: 'Naluf bin Naluf', relatedId: 0, isApproved: true);
  final TransactionModel _dummyTrax2 = const TransactionModel(uid: 0, amount: 200000, createTime: 1690625019447, senderAccountNo: '', traxType: 'Transfer Out', receiverAccountNo: '', senderName: 'Fulan bin Fulan', receiverName: 'Naluf bin Naluf', relatedId: 0, isApproved: false);
  final TransactionModel _dummyTrax3 = const TransactionModel(uid: 0, amount: 200000, createTime: 1690625019447, senderAccountNo: '', traxType: 'Transfer Out', receiverAccountNo: '', senderName: 'Fulan bin Fulan', receiverName: 'Naluf bin Naluf', relatedId: 0, isApproved: null);
  List<TransactionModel> _transactionList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _transactionList = [_dummyTrax1, _dummyTrax2, _dummyTrax3];
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: RefreshIndicator(
        onRefresh: () async {
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
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.symmetric(vertical: UiConstant.mediumPadding),
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: UiConstant.defaultPadding, horizontal: UiConstant.sidePadding),
                  color: ColorValues.surface,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildHeading(),
                      const SizedBox(height: UiConstant.defaultSpacing),
                      _transactionList.isNotEmpty ? _buildRequestList() : _buildEmptyList(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeading() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context).notifications,
          style: Theme.of(context).textTheme.labelLarge,
        ),
        const SizedBox(height: UiConstant.mediumSpacing),
        Text(
          AppLocalizations.of(context).notificationsDescription,
          style: Theme.of(context).textTheme.displayMedium?.copyWith(fontSize: 12),
        )
      ],
    );
  }

  Widget _buildRequestList() {
    return ListView.separated(
      primary: false,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: _transactionList.length,
      itemBuilder: (context, index) {
        return CustomTransaction(transactionModel: _transactionList[index], isNotification: true);
      },
      separatorBuilder: (_, __) {
        return const SizedBox(height: UiConstant.defaultSpacing);
      },
    );
  }

  Widget _buildEmptyList() {
    return SizedBox(
      width: 100.w,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24),
        child: Column(children: [
          Text(
            AppLocalizations.of(context).emptyNotifications,
            style:
            Theme.of(context).textTheme.labelLarge?.copyWith(fontSize: 14),
          ),
          const SizedBox(height: UiConstant.mediumSpacing),
          Text(
            AppLocalizations.of(context).emptyNotificationsDescription,
            style: Theme.of(context)
                .textTheme
                .displayMedium
                ?.copyWith(fontSize: 12),
          )
        ]),
      ),
    );
  }
}
