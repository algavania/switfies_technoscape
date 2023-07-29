import 'package:flutter/material.dart';
import 'package:swifties_technoscape/presentation/widgets/custom_shadow.dart';
import 'package:swifties_technoscape/presentation/widgets/logo_widget.dart';
import '../core/ui_constant.dart';
import 'custom_back_button.dart';

class CustomAppBar extends StatelessWidget {
  final Widget body;
  final bool hasBackButton;
  final bool needSpacing;
  final Color? color;

  const CustomAppBar({Key? key, required this.body, this.hasBackButton = false, this.needSpacing = false, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomShadow(
      child: Container(
        color: color ?? Colors.white,
        padding: const EdgeInsets.fromLTRB(UiConstant.sidePadding, 12,
            UiConstant.sidePadding, UiConstant.defaultPadding),
        child: Row(
          children: [
            hasBackButton
              ? const CustomBackButton()
              : const LogoWidget(),
            const SizedBox(width: UiConstant.defaultSpacing),
            if (needSpacing) const Spacer(),
            const SizedBox(width: UiConstant.defaultSpacing),
            body,
          ],
        ),
      ),
    );
  }
}
