import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:swifties_technoscape/application/common/shared_code.dart';
import 'package:swifties_technoscape/l10n/l10n.dart';
import 'package:swifties_technoscape/presentation/core/color_values.dart';
import 'package:swifties_technoscape/presentation/core/ui_constant.dart';

class CustomSavingBalance extends StatefulWidget {
  final int balance;
  const CustomSavingBalance({Key? key, required this.balance}) : super(key: key);

  @override
  State<CustomSavingBalance> createState() => _CustomSavingBalanceState();
}

class _CustomSavingBalanceState extends State<CustomSavingBalance> {
  final ValueNotifier<bool> _isBalanceVisible = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: _isBalanceVisible,
        builder: (context, _, __) {
          return Container(
            padding: const EdgeInsets.symmetric(vertical: UiConstant.defaultPadding, horizontal: UiConstant.sidePadding),
            color: ColorValues.surface,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(AppLocalizations.of(context).yourSavings, style: Theme.of(context).textTheme.displayMedium?.copyWith(fontSize: 14)),
                const SizedBox(height: 4),
                Row(children: [
                  Expanded(
                    child: _isBalanceVisible.value ? RichText(
                        text: TextSpan(
                            text: 'Rp',
                            style: Theme.of(context).textTheme.displayMedium?.copyWith(fontSize: 20),
                            children: [
                              TextSpan(
                                text:' ${SharedCode.formatThousands(widget.balance)}',
                                style: Theme.of(context).textTheme.displayLarge,
                              )
                            ]
                        )
                    ) : SizedBox(
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
                              color: i % 2 == 0 ? ColorValues.primary30 : ColorValues.primary20,
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
                  _buildBalanceToggle(),
                ]),
              ],
            ),
          );
        }
    );
  }

  Widget _buildBalanceToggle() {
    return InkWell(
      onTap: () {
        _isBalanceVisible.value = !_isBalanceVisible.value;
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: ColorValues.text50, width: 1)
        ),
        child: Row(
          children: [
            Icon(
              _isBalanceVisible.value ? Iconsax.eye_slash5 : Iconsax.eye4,
              color: ColorValues.text50,
              size: 16,
            ),
            const SizedBox(width: 4),
            Text(
              _isBalanceVisible.value ? AppLocalizations.of(context).hide : AppLocalizations.of(context).show,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(letterSpacing: 0.8),
            ),
          ],
        ),
      ),
    );
  }
}
