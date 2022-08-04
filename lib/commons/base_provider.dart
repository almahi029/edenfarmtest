import 'dart:developer';
import 'package:edenfarm_test/widgets/v_popup.dart';
import 'package:flutter/material.dart';

abstract class BaseProvider extends ChangeNotifier {
  BuildContext? context;
  bool isLoading = false;
  String message = "";

  void setLog(String data) {
    log(data);
  }

  void setLoading([bool loading = false]) {
    if (loading) setMessage("");
    isLoading = loading;
    notifyListeners();
  }

  void setMessage(String message) => this.message = message;

  void showPopupLoading(BuildContext context) {
    VPopup(context).loading();
  }
  void dismissPopupLoading(BuildContext context) {
    Navigator.pop(context);
  }
}
