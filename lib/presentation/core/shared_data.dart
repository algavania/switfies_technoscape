import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../data/models/user/user_model.dart';

class SharedData {
  static DateFormat dateFormat = DateFormat('d MMM', 'id_ID');
  static DateFormat regularDateFormat = DateFormat('dd/MM/yyyy');
  static ValueNotifier<UserModel?> userData = ValueNotifier(null);
}
