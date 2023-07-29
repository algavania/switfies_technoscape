import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sizer/sizer.dart';
import 'package:swifties_technoscape/presentation/core/color_values.dart';
import 'package:swifties_technoscape/presentation/core/ui_constant.dart';

import '../../data/models/user/user_model.dart';

class CustomSavingMethod extends StatefulWidget {
  final String text, imageUrl;
  final void Function() onTap;
  const CustomSavingMethod({Key? key, required this.text, required this.imageUrl, required this.onTap}) : super(key: key);

  @override
  State<CustomSavingMethod> createState() => _CustomSavingMethodState();
}

class _CustomSavingMethodState extends State<CustomSavingMethod> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: Container(
        width: 100.w,
        padding: const EdgeInsets.all(UiConstant.smallerPadding),
        decoration: BoxDecoration(
          color: ColorValues.surface,
          borderRadius: BorderRadius.circular(UiConstant.smallerBorder),
          border: Border.all(color: ColorValues.grey10)
        ),
        child: Row(children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              widget.imageUrl,
              width: 32,
              height: 32,
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(width: UiConstant.defaultSpacing),
          Expanded(
            child: Text(
              widget.text,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 12),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(right: UiConstant.smallerPadding),
            child: Icon(
              Iconsax.arrow_right_3,
              color: ColorValues.text50,
              size: 16,
            ),
          )
        ]),
      ),
    );
  }
}
