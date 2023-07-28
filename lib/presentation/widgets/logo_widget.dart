import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';

class LogoWidget extends StatelessWidget {
  final bool isBig;

  const LogoWidget({Key? key, this.isBig = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      'assets/core/logo_app.svg',
      width: isBig ? 80.w : 40.w,
      height: isBig ? 6.h : 3.h,
      fit: BoxFit.contain,
    );
  }
}
