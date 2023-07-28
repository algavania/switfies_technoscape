import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:unicons/unicons.dart';

import '../core/color_values.dart';
import 'rounded_button.dart';

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AutoRouter.of(context).canPop() ? RoundedButton(
      color: Theme.of(context).scaffoldBackgroundColor,
      onTap: () {
        AutoRouter.of(context).pop();
      },
      child: const Icon(Iconsax.arrow_left, color: ColorValues.text50, size: 24),
    ) : const SizedBox.shrink();
  }
}
