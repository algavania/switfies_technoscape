import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../core/ui_constant.dart';
import 'custom_button.dart';

class NoAccessWidget extends StatelessWidget {
  const NoAccessWidget(
      {Key? key,
      this.buttonColor,
      required this.title,
      required this.description,
      required this.path,
      required this.onTap,
      required this.buttonText})
      : super(key: key);
  final Color? buttonColor;
  final String buttonText, title, description, path;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(UiConstant.defaultPadding),
      child: Column(
        children: [
          const Spacer(),
          Column(
            children: [
              Image.asset(
                path,
                height: 30.h,
                fit: BoxFit.cover,
              ),
              const SizedBox(
                height: UiConstant.biggerSpacing,
              ),
              Text(
                title,
                style: Theme.of(context).textTheme.titleMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: UiConstant.smallerSpacing,
              ),
              Text(
                description,
                style: Theme.of(context).textTheme.bodySmall,
                textAlign: TextAlign.center,
              ),
            ],
          ),
          const Spacer(),
          CustomButton(
            backgroundColor: buttonColor ?? Theme.of(context).primaryColor,
            buttonText: buttonText,
            onPressed: onTap,
          ),
        ],
      ),
    );
  }
}
