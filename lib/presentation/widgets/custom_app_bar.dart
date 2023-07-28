import 'package:flutter/material.dart';
import '../core/ui_constant.dart';
import 'custom_back_button.dart';
import 'custom_logo_button.dart';

class CustomAppBar extends StatelessWidget {
  final Widget body;
  final bool hasBackButton;
  final bool needSpacing;
  final Color? color;

  const CustomAppBar({Key? key, required this.body, required this.hasBackButton, this.needSpacing = false, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color ?? Colors.white,
      padding: const EdgeInsets.fromLTRB(UiConstant.sidePadding, 12,
          UiConstant.sidePadding, UiConstant.sidePadding),
      child: Row(
        children: [
          hasBackButton
            ? const CustomBackButton()
            : const CustomLogoButton(),
          const SizedBox(width: UiConstant.defaultSpacing),
          if (needSpacing) const Spacer(),
          const SizedBox(width: UiConstant.defaultSpacing),
          body,
        ],
      ),
    );
  }
}
