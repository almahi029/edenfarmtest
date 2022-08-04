import 'package:edenfarm_test/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:edenfarm_test/utils/size_config.dart';
import 'package:edenfarm_test/utils/v_color.dart';
import 'package:edenfarm_test/widgets/v_widgets.dart';

class AlertTextPopup extends StatelessWidget {
  String? title;
  String? message;
  AlertTextPopup({this.title,this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(paddingExtraLarge),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: VText(title,color: VColor.black,fontSize: getProportionateScreenWidth(textSizeLarge),isBold: true,),
          ),
          SizedBox(
            height: marginLarge,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: VText(message,color: VColor.grey3,fontSize: getProportionateScreenWidth(textSizeMedium),isBold: false,),
          ),
          SizedBox(
            height: marginExtraLarge,
          ),
          VButton(
            "Ok",
            textPadding: paddingMedium,
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }
}
