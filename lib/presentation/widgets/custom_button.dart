import 'package:flutter/material.dart';

import '../core/color_values.dart';
import '../core/ui_constant.dart';

class CustomButton extends StatefulWidget {
  const CustomButton(
      {Key? key,
      this.onPressed,
      required this.buttonText,
      this.fontSize = 15,
      this.prefixIcon,
      this.colorAsOutlineButton,
      this.backgroundColor = ColorValues.primary50,
      this.borderRadius = UiConstant.defaultBorder})
      : super(key: key);
  final Function()? onPressed;
  final String buttonText;
  final double fontSize, borderRadius;
  final IconData? prefixIcon;
  final Color? colorAsOutlineButton;
  final Color backgroundColor;

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: widget.onPressed,
        style: ElevatedButton.styleFrom(
            minimumSize: const Size(double.infinity, 48),
            elevation: 0,
            backgroundColor: widget.backgroundColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(widget.borderRadius),
                side: BorderSide(
                    color: widget.onPressed == null ? Colors.transparent : widget.colorAsOutlineButton ?? widget.backgroundColor,
                    width: 1))),
        child: FittedBox(
          child: Row(
            children: [
              if (widget.prefixIcon != null)
                Icon(widget.prefixIcon,
                    size: 18,
                    color: widget.colorAsOutlineButton ?? ColorValues.white),
              if (widget.prefixIcon != null)
                const SizedBox(width: UiConstant.smallerSpacing),
              Text(
                widget.buttonText,
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    fontSize: widget.fontSize,
                    color: widget.colorAsOutlineButton ?? Colors.white),
              ),
            ],
          ),
        ));
  }
}
