import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:status_bar_control/status_bar_control.dart';

import '../../data/models/user/user_model.dart';

class SharedData {
  static DateFormat dateFormat = DateFormat('d MMMM yyyy', 'id_ID');
  static DateFormat regularDateFormat = DateFormat('dd/MM/yyyy');
  static DateFormat authDateFormat = DateFormat('ddMMyyyy');
  static ValueNotifier<UserModel?> userData = ValueNotifier(null);
  static void setStatusBarColorPrimary(BuildContext context) {
    StatusBarControl.setColor(Theme.of(context).primaryColor, animated: true);
    StatusBarControl.setStyle(StatusBarStyle.LIGHT_CONTENT);
  }
  static void setStatusBarColorWhite(BuildContext context) {
    StatusBarControl.setColor(Colors.white, animated: true);
    StatusBarControl.setStyle(StatusBarStyle.DARK_CONTENT);
  }

}
