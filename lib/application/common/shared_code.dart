import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../../l10n/l10n.dart';
import '../../presentation/core/color_values.dart';
import '../../presentation/core/ui_constant.dart';

class SharedCode {
  static String convertPhoneNumberToInternationalFormat(String number) {
    number = number.trim();
    if (number[0] == '0') {
      number = number.replaceFirst('0', '+62');
    }
    return number;
  }

  static String? emptyValidators(String? value) {
    return value
        .toString()
        .trim()
        .isEmpty ? 'Tidak boleh kosong' : null;
  }

  static String? usernameValidators(String? value) {
    String? result = emptyValidators(value);
    if (result != null) return result;
    if (value
        .toString()
        .length < 4) return 'Kurang lebih harus ada 4 karakter';
    if (value
        .toString()
        .length > 30) return 'Tidak boleh lebih dari 30 karakter';
    RegExp regex = RegExp(r'^[\w.]+$');
    if (!regex.hasMatch(value ?? ''))
      return 'Hanya boleh alfabet, angka, underscore, dan titik.';
    return null;
  }

  static String? passwordValidators(String? value) {
    String? result = emptyValidators(value);
    if (result != null) return result;
    if (value
        .toString()
        .length < 8) return 'Kurang lebih harus ada 8 karakter';
    return null;
  }

  static String? confirmPasswordValidators(String password, String value) {
    String? result = emptyValidators(value);
    if (result != null) return result;
    if (password == value) return null;
    return 'Password tidak sama';
  }

  static String? emailValidators(String? value) {
    String? result = emptyValidators(value);
    if (result != null) return result;
    bool isValid = RegExp(
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(value ?? '');
    return isValid ? null : 'Email tidak valid';
  }

  static void showSnackbar(
      {required BuildContext context, required String message, bool isSuccess = true, bool isTop = true}) {
    Color backgroundColor = isSuccess ? ColorValues.success10 : ColorValues
        .danger10;
    Color borderColor = isSuccess ? ColorValues.success20 : ColorValues
        .danger20;
    Color color = isSuccess ? ColorValues.success50 : ColorValues.danger50;
    Flushbar flushbar = Flushbar();
    flushbar = Flushbar(
      flushbarStyle: FlushbarStyle.FLOATING,
      flushbarPosition: isTop ? FlushbarPosition.TOP : FlushbarPosition.BOTTOM,
      duration: const Duration(seconds: 3),
      margin: const EdgeInsets.symmetric(vertical: UiConstant.defaultPadding,
          horizontal: UiConstant.sidePadding),
      padding: const EdgeInsets.all(8),
      borderRadius: BorderRadius.circular(UiConstant.defaultBorder),
      backgroundColor: backgroundColor,
      borderWidth: 1,
      borderColor: borderColor,
      messageText: Row(children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(UiConstant.smallerBorder),
            color: color,
            border: Border.all(color: borderColor, width: 1),
          ),
          child: Center(child: Icon(
              isSuccess ? Iconsax.check5 : Iconsax.info_circle5,
              color: ColorValues.surface, size: 16)),
        ),
        Expanded(child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: UiConstant.defaultPadding),
          child: Text(message, style: Theme
              .of(context)
              .textTheme
              .bodySmall),
        )),
        GestureDetector(
            onTap: () => flushbar.dismiss(),
            child: const Icon(
                Iconsax.close_circle5, size: 16, color: ColorValues.text50)
        )
      ]),
    );

    flushbar.show(context);
  }

  static void showAlertDialog({
    required BuildContext context,
    required String title,
    String? description,
    Widget? descriptionWidget,
    required String proceedText,
    required Function() proceedAction
  }) {
    Widget cancelButton = TextButton(
      onPressed: () => Navigator.of(context).pop(),
      child: Text(
          AppLocalizations
              .of(context)
              .cancel,
          style: Theme
              .of(context)
              .textTheme
              .bodySmall
              ?.copyWith(color: Theme
              .of(context)
              .primaryColor)
      ),
    );

    Widget proceedButton = TextButton(
      onPressed: () {
        Navigator.of(context).pop();
        proceedAction();
      },
      child: Text(
          proceedText,
          style: Theme
              .of(context)
              .textTheme
              .bodySmall
              ?.copyWith(color: Theme
              .of(context)
              .primaryColor)
      ),
    );

    AlertDialog alert = AlertDialog(
      title: Text(
          title,
          style: Theme
              .of(context)
              .textTheme
              .titleMedium
      ),
      content: descriptionWidget ?? Text(
          description ?? '',
          style: Theme
              .of(context)
              .textTheme
              .bodyMedium
              ?.copyWith(color: ColorValues.grey50)
      ),
      actions: [
        cancelButton,
        proceedButton,
      ],
    );

    Future.delayed(Duration.zero, () {
      showDialog(
        context: context,
        builder: (_) {
          return alert;
        },
      );
    });
  }
}