import 'package:edenfarm_test/utils/size_config.dart';
import 'package:edenfarm_test/utils/v_color.dart';
import 'package:edenfarm_test/widgets/v_widgets.dart';
import 'package:flutter/material.dart';

class LoadingPopup extends StatefulWidget {
  @override
  _LoadingPopupState createState() => _LoadingPopupState();
}

class _LoadingPopupState extends State<LoadingPopup> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        borderRadius: BorderRadius.circular(8.0),
        child: Container(
          padding: EdgeInsets.all(20.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(
                valueColor:AlwaysStoppedAnimation<Color>(VColor.primary),
              ),
              SizedBox(
                width: getProportionateScreenWidth(14),
              ),
              VText("Please wait",color: VColor.grey3,fontSize:getProportionateScreenWidth(14),maxLines: 1,),
            ],
          ),
        ),
      ),
    );
  }
}
