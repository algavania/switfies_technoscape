import 'package:flutter/material.dart';

import '../core/color_values.dart';
import '../core/ui_constant.dart';
import 'custom_shadow.dart';

class RoundedButton extends StatefulWidget {
  const RoundedButton({Key? key, this.onTap, this.withOnlineIndicator = false, this.border, required this.child, this.color}) : super(key: key);
  final void Function()? onTap;
  final Border? border;
  final Widget child;
  final Color? color;
  final bool withOnlineIndicator;

  @override
  State<RoundedButton> createState() => _RoundedButtonState();
}

class _RoundedButtonState extends State<RoundedButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Stack(
        children: [
          CustomShadow(
            borderRadius: UiConstant.defaultBorder,
            child: Container(
              height: 48,
              width: 48,
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                  color: widget.color ?? Colors.white,
                  border: widget.border,
                  borderRadius: BorderRadius.circular(UiConstant.defaultBorder)
              ),
              child: Center(
                child: widget.child,
              ),
            ),
          ),
          if (widget.withOnlineIndicator) SizedBox(
            height: 48,
            width: 48,
            child: Align(
              alignment: Alignment.bottomRight,
              child: Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: ColorValues.primary40,
                    border: Border.all(color: ColorValues.primary50, width: 1)
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
