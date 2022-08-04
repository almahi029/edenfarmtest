import 'package:edenfarm_test/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:edenfarm_test/utils/size_config.dart';
import 'package:edenfarm_test/utils/v_color.dart';

import '../v_widgets.dart';

class AddWeightRecordPopup extends StatelessWidget {
  final TextEditingController controllerWeight = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(paddingExtraLarge),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          VText("Weight",color: VColor.black,fontSize: getProportionateScreenWidth(textSizeLarge),isBold: true,),
          SizedBox(height: marginLarge,),
          VInputText(
            hint: "Your Weight",
            textEditingController: controllerWeight,
            keyboardType: TextInputType.number,
          ),
          SizedBox(height: marginExtraLarge,),
          VButtonBorder(
            "Cancel",
            textPadding: paddingMedium,
            textColor : VColor.black,
            textColorDisabled : VColor.black_opacity,
            buttonColor : VColor.white,
            buttonColorDisabled : VColor.grey1,
            borderColor : VColor.grey1,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          SizedBox(
            height: marginMedium,
          ),
          VButton(
            "Add",
            textPadding: paddingMedium,
            onPressed: () {
              Navigator.pop(context,{"weight" : controllerWeight.text});
            },
          ),
          SizedBox(
            height: marginMedium,
          ),
        ],
      ),
    );
  }
}
