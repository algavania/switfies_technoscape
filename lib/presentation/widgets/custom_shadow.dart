import 'package:flutter/material.dart';

import '../core/color_values.dart';

class CustomShadow extends StatefulWidget {
  final bool isShadowAbove;
  final Widget child;
  final double borderRadius;

  const CustomShadow(
      {Key? key, this.isShadowAbove = false, required this.child, this.borderRadius = 0})
      : super(key: key);

  @override
  State<CustomShadow> createState() => _CustomShadowState();
}

class _CustomShadowState extends State<CustomShadow> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(widget.borderRadius),
        boxShadow: [
          BoxShadow(
              color: ColorValues.text50.withOpacity(0.04),
              spreadRadius: 0,
              blurRadius: 32,
              offset: widget.isShadowAbove ? const Offset(0, -8) : const Offset(0, 8)
          ),
        ]
      ),
      child: widget.child
    );
  }
}
