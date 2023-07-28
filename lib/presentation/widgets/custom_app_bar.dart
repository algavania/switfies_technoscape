import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';
import 'package:swifties_technoscape/presentation/core/color_values.dart';
import 'package:swifties_technoscape/presentation/core/ui_constant.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: UiConstant.mediumPadding, horizontal: UiConstant.sidePadding),
      width: 100.w,
      color: ColorValues.surface,
      child: Row(
        children: [
          SvgPicture.asset(
            'assets/core/logo_app.svg',
            height: 24,
            fit: BoxFit.contain,
          ),
          const Spacer(),
          ClipRRect(
            borderRadius: BorderRadius.circular(UiConstant.smallerBorder),
            child: Image.network(
              'https://t4.ftcdn.net/jpg/00/64/67/27/360_F_64672736_U5kpdGs9keUll8CRQ3p3YaEv2M6qkVY5.jpg',
              width: 40,
              height: 40,
            ),
          )
        ],
      ),
    );
  }
}
