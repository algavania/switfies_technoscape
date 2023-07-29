import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sizer/sizer.dart';
import 'package:swifties_technoscape/presentation/core/color_values.dart';
import 'package:swifties_technoscape/presentation/core/ui_constant.dart';
import 'package:swifties_technoscape/presentation/routes/router.gr.dart';

import '../../data/models/user/user_model.dart';

class CustomChildAccount extends StatefulWidget {
  final UserModel user;
  const CustomChildAccount({Key? key, required this.user}) : super(key: key);

  @override
  State<CustomChildAccount> createState() => _CustomChildAccountState();
}

class _CustomChildAccountState extends State<CustomChildAccount> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        AutoRouter.of(context).navigate(AccountDetailRoute(childModel: widget.user));
      },
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
            child: Image.network(
              'https://t4.ftcdn.net/jpg/00/64/67/27/360_F_64672736_U5kpdGs9keUll8CRQ3p3YaEv2M6qkVY5.jpg',
              width: 32,
              height: 32,
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(width: UiConstant.defaultSpacing),
          Expanded(
            child: Text(
              widget.user.displayName,
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
