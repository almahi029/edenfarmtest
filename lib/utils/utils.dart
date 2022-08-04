import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Utils {
  static Future<DateTime> vShowDatePicker(BuildContext context,
      {DateTime? selectedDate}) async {
    var data = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    return data ?? DateTime.now();
  }

  static String getFormatedStringTime(DateTime dateTime){
    return DateFormat("yyyy-MM-dd'T'HH:mm:ss'Z'").format(dateTime);
  }
}
