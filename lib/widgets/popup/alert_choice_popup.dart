import 'package:edenfarm_test/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:edenfarm_test/utils/size_config.dart';
import 'package:edenfarm_test/utils/v_color.dart';

import '../v_widgets.dart';

class AlertChoicePopup extends StatelessWidget {
  String? title;
  String? message;
  String? positiveText;
  String? negativeText;
  VoidCallback? onPressedOk;
  VoidCallback? onPressedCancel;
  AlertChoicePopup({this.title,this.message,this.positiveText,this.negativeText,this.onPressedOk,this.onPressedCancel});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(paddingExtraLarge),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Align(
            alignment: Alignment.center,
            child: VText(title,color: VColor.black,fontSize: getProportionateScreenWidth(textSizeLarge),isBold: true,),
          ),
          SizedBox(
            height: marginLarge,
          ),
          Align(
            alignment: Alignment.center,
            child: VText(message,color: VColor.grey4,fontSize: getProportionateScreenWidth(textSizeMedium),align:TextAlign.center,isBold: false,),
          ),
          SizedBox(
            height: marginExtraLarge,
          ),
          VButtonBorder(
            negativeText??"Cancel",
            textPadding: paddingMedium,
            textColor : VColor.black,
            textColorDisabled : VColor.black_opacity,
            buttonColor : VColor.white,
            buttonColorDisabled : VColor.grey1,
            borderColor : VColor.grey1,
            onPressed: () => onPressedCancel!(),
          ),
          SizedBox(
            height: marginMedium,
          ),
          VButton(
            positiveText??"Oke",
            textPadding: paddingMedium,
            onPressed: () => onPressedOk!(),
          ),
          SizedBox(
            height: marginMedium,
          ),
        ],
      ),
    );
  }
}
