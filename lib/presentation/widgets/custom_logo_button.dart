import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';

import 'rounded_button.dart';

class CustomLogoButton extends StatelessWidget {
  const CustomLogoButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RoundedButton(
      onTap: () {},
      child: SvgPicture.asset('assets/core/logo_app.svg', width: 40.w, height: 32),
    );
  }
}
