import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sizer/sizer.dart';
import 'package:swifties_technoscape/presentation/core/color_values.dart';
import 'package:swifties_technoscape/presentation/core/ui_constant.dart';

class CustomChildAccount extends StatefulWidget {
  final String name;
  const CustomChildAccount({Key? key, required this.name}) : super(key: key);

  @override
  State<CustomChildAccount> createState() => _CustomChildAccountState();
}

class _CustomChildAccountState extends State<CustomChildAccount> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
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
              'assets/activity/img_child.png',
              width: 32,
              height: 32,
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(width: UiConstant.defaultSpacing),
          Expanded(
            child: Text(
              widget.name,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(fontSize: 12),
            ),
          ),
          const Icon(
            Iconsax.arrow_right_25,
            color: ColorValues.text50,
            size: 16,
          )
        ]),
      ),
    );
  }
}
