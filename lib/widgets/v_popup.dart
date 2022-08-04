import 'package:edenfarm_test/utils/constants.dart';
import 'package:edenfarm_test/utils/v_color.dart';
import 'package:edenfarm_test/widgets/popup/add_weight_record_popup.dart';
import 'package:edenfarm_test/widgets/popup/alert_text_popup.dart';
import 'package:edenfarm_test/widgets/popup/loading_popup.dart';
import 'package:flutter/material.dart';
import 'popup/alert_choice_popup.dart';

class VPopup {
  VPopup._privateConstructor();

  static final VPopup _instance = VPopup._privateConstructor();

  static BuildContext? _context;

  factory VPopup(BuildContext context) {
    _context = context;
    return _instance;
  }


  AlertDialog _alertDialog({@required Widget? content}) {
    return AlertDialog(
      scrollable: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      backgroundColor: VColor.white,
      content: content,
      contentPadding: EdgeInsets.zero,
      insetPadding: EdgeInsets.all(paddingExtraLarge),
    );
  }

  AlertDialog dialogFull({@required Widget? content}) {
    return AlertDialog(
      scrollable: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radiusMedium),
      ),
      backgroundColor: VColor.white,
      content: content,
    );
  }

  void loading() async {
    showDialog(
      context: _context!,
      barrierDismissible: false,
      builder: (c) => LoadingPopup(),
    );
  }

  void addWeightRecord(Function(dynamic) callback){
    showGeneralDialog(
      barrierDismissible: false,
      transitionDuration: Duration(milliseconds: 200),
      transitionBuilder: (context, anim1, anim2, child) {
        return SlideTransition(
          position: Tween(begin: Offset(0, 1), end: Offset(0, 0)).animate(anim1),
          child: child,
        );
      },
      context: _context!,
      pageBuilder: (context, anim1, anim2) {
        return Container(
          height: 400,
          width: double.infinity,
          child: _alertDialog(content: AddWeightRecordPopup()),
          margin: EdgeInsets.only(bottom: 30,left: 10,right: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
          ),
        );
      },
    ).then((value) {
      callback(value);
    });
  }

  void alertText(String title,String message){
    showGeneralDialog(
      barrierDismissible: false,
      transitionDuration: Duration(milliseconds: 200),
      transitionBuilder: (context, anim1, anim2, child) {
        return SlideTransition(
          position: Tween(begin: Offset(0, 1), end: Offset(0, 0)).animate(anim1),
          child: child,
        );
      },
      context: _context!,
      pageBuilder: (context, anim1, anim2) {
        return Container(
          height: 400,
          width: double.infinity,
          child: _alertDialog(content: AlertTextPopup(title: title,message: message,)),
          margin: EdgeInsets.only(bottom: 30,left: 10,right: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
          ),
        );
      },
    );
  }

  void alertTextWithCallback(String title,String message,Function(dynamic) callback){
    showGeneralDialog(
      barrierDismissible: false,
      transitionDuration: Duration(milliseconds: 200),
      transitionBuilder: (context, anim1, anim2, child) {
        return SlideTransition(
          position: Tween(begin: Offset(0, 1), end: Offset(0, 0)).animate(anim1),
          child: child,
        );
      },
      context: _context!,
      pageBuilder: (context, anim1, anim2) {
        return Container(
          height: 400,
          width: double.infinity,
          child: _alertDialog(content: AlertTextPopup(title: title,message: message,)),
          margin: EdgeInsets.only(bottom: 30,left: 10,right: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
          ),
        );
      },
    ).then((value) {
      callback(value);
    });
  }


  void alertChoice(String title,String message,String positiveText,String negativeText,VoidCallback onPressOk, VoidCallback onPressCancel){
    showGeneralDialog(
      barrierDismissible: false,
      transitionDuration: Duration(milliseconds: 200),
      transitionBuilder: (context, anim1, anim2, child) {
        return SlideTransition(
          position: Tween(begin: Offset(0, 1), end: Offset(0, 0)).animate(anim1),
          child: child,
        );
      },
      context: _context!,
      pageBuilder: (context, anim1, anim2) {
        return Container(
          height: 400,
          width: double.infinity,
          child: _alertDialog(content: AlertChoicePopup(title: title,message: message,positiveText: positiveText,negativeText: negativeText,onPressedOk: onPressOk,onPressedCancel: onPressCancel,)),
          margin: EdgeInsets.only(bottom: 30,left: 10,right: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
          ),
        );
      },
    );
  }

  void alertChoiceWithCallback(String title,String message,String positiveText,String negativeText,VoidCallback onPressOk, VoidCallback onPressCancel, Function(dynamic) callback){
    showGeneralDialog(
      barrierDismissible: false,
      transitionDuration: Duration(milliseconds: 200),
      transitionBuilder: (context, anim1, anim2, child) {
        return SlideTransition(
          position: Tween(begin: Offset(0, 1), end: Offset(0, 0)).animate(anim1),
          child: child,
        );
      },
      context: _context!,
      pageBuilder: (context, anim1, anim2) {
        return Container(
          height: 400,
          width: double.infinity,
          child: _alertDialog(content: AlertChoicePopup(title: title,message: message,positiveText: positiveText,negativeText: negativeText,onPressedOk: onPressOk,onPressedCancel: onPressCancel,)),
          margin: EdgeInsets.only(bottom: 30,left: 10,right: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
          ),
        );
      },
    ).then((value) {
      callback(value);
    });
  }

}