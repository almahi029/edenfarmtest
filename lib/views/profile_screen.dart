import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edenfarm_test/commons/base_stateful.dart';
import 'package:edenfarm_test/providers/login_state.dart';
import 'package:edenfarm_test/providers/profile_state.dart';
import 'package:edenfarm_test/providers/register_state.dart';
import 'package:edenfarm_test/utils/constants.dart';
import 'package:edenfarm_test/utils/size_config.dart';
import 'package:edenfarm_test/utils/v_color.dart';
import 'package:edenfarm_test/widgets/v_popup.dart';
import 'package:edenfarm_test/widgets/v_widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends BaseStateful<ProfileScreen, ProfileState> {
  Widget _body() {
    return SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(paddingLarge)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: getProportionateScreenWidth(marginExtraLarge),),
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(
                  Icons.arrow_back_outlined,
                  color: VColor.black,
                  size: getProportionateScreenWidth(textSizeExtraLarge),
                ),
              ),
              Expanded(
                child: ListView(
                  children: [
                    SizedBox(height: getProportionateScreenWidth(marginExtraLarge),),
                    VText(
                      "Complete your profile",
                      color: VColor.black,
                      isBold: true,
                      fontSize: getProportionateScreenWidth(textSizeExtraLarge),
                      align: TextAlign.left,
                    ),
                    SizedBox(height: getProportionateScreenWidth(marginExtraLarge*2),),
                    VText(
                      "Username",
                      color: VColor.black,
                      isBold: true,
                      fontSize: getProportionateScreenWidth(textSizeMedium),
                      align: TextAlign.left,
                    ),
                    SizedBox(height: getProportionateScreenWidth(getProportionateScreenWidth(marginSmall)),),
                    VInputText(
                      textCapitalization : TextCapitalization.none,
                      hint: "Username",
                      textEditingController: state.controllerUsername,
                    ),
                    SizedBox(height: getProportionateScreenWidth(marginLarge),),
                    VText(
                      "Email",
                      color: VColor.black,
                      isBold: true,
                      fontSize: getProportionateScreenWidth(textSizeMedium),
                      align: TextAlign.left,
                    ),
                    SizedBox(height: getProportionateScreenWidth(getProportionateScreenWidth(marginSmall)),),
                    VInputText(
                      readOnly: true,
                      textCapitalization : TextCapitalization.none,
                      hint: "Email",
                      textEditingController: state.controllerEmail,
                    ),
                    SizedBox(height: getProportionateScreenWidth(marginLarge),),
                    VText(
                      "Birth Date",
                      color: VColor.black,
                      isBold: true,
                      fontSize: getProportionateScreenWidth(textSizeMedium),
                      align: TextAlign.left,
                    ),
                    SizedBox(height: getProportionateScreenWidth(getProportionateScreenWidth(marginSmall)),),
                    InkWell(
                      onTap: (){
                        state.selectDate(context);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: VColor.grey1),
                        ),
                        padding: EdgeInsets.only(
                            left: getProportionateScreenWidth(paddingLarge),
                            top: getProportionateScreenWidth(8),
                            bottom: getProportionateScreenWidth(8),
                            right: getProportionateScreenWidth(paddingSmall),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child:VText(
                                  state.birthDate,
                                  fontSize: getProportionateScreenWidth(14),
                                  color: state.birthDate == "Your Birth Date" ? VColor.grey3 : VColor.black,
                                  isBold: false,
                                  maxLines: 1,),
                              ),
                            ),
                            SizedBox(width: getProportionateScreenWidth(10),),
                            Container(
                              child: VCircleIconButton(
                                  imgPath:"calendar_icon.svg",
                                  buttonColor: VColor.white,
                                  buttonColorDisabled:
                                  VColor.white,
                                  iconColor: VColor.primary,
                                  padding: getProportionateScreenWidth(2),
                                  iconSize: getProportionateScreenWidth(25),
                                  onPressed: (){state.selectDate(context);}),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: getProportionateScreenWidth(marginLarge),),
                    VText(
                      "Height",
                      color: VColor.black,
                      isBold: true,
                      fontSize: getProportionateScreenWidth(textSizeMedium),
                      align: TextAlign.left,
                    ),
                    SizedBox(height: getProportionateScreenWidth(getProportionateScreenWidth(marginSmall)),),
                    VInputText(
                      textCapitalization : TextCapitalization.none,
                      hint: "Height",
                      textEditingController: state.controllerHeight,
                    ),
                    SizedBox(height: getProportionateScreenWidth(marginLarge*2),),
                    VButton(
                      "Save",
                      textPadding: getProportionateScreenWidth(paddingMedium),
                      onPressed: () async{
                        try{
                          if(isValidated()){
                            VPopup(context).loading();
                            await FirebaseFirestore.instance
                                .collection('userModel')
                                .doc(state.fireStoreUserId)
                                .set(
                              {
                                'name' : state.controllerUsername.text,
                                'email' : state.controllerEmail.text,
                                'birthDate' : state.selectedDate,
                                'height' : state.controllerHeight.text,
                              },
                            );
                            Navigator.pop(context);
                          }
                        }catch(e){
                          Navigator.pop(context);
                          throw Exception(e);
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        )
    );
  }

  bool isValidated(){
    if(state.controllerUsername.text.isEmpty){
      VPopup(context).alertText("Fill not complete", "Username cannot be an empty",);
      return false;
    }
    if(state.controllerEmail.text.isEmpty){
      VPopup(context).alertText("Fill not complete", "Email cannot be an empty",);
      return false;
    }
    if(state.birthDate==""){
      VPopup(context).alertText("Fill not complete", "Please select your birthdate",);
      return false;
    }
    if(state.controllerHeight.text.isEmpty){
      VPopup(context).alertText("Fill not complete", "Height cannot be an empty",);
      return false;
    }


    return true;
  }


  SnackBar customSnackBar({required String content}) {
    return SnackBar(
      backgroundColor: VColor.primary.withOpacity(0.5),
      content: VText(content,color: VColor.white,fontSize: getProportionateScreenWidth(textSizeMedium),isBold: false,),
    );
  }

  @override
  Widget layout(BuildContext context) {
    return createNotifier(
      builder: (context, state, child) {
        return Scaffold(
          body: _body(),
        );
      },
    );
  }

  @override
  void registerState() {
    SizeConfig().init(context);
    state = ProfileState();
    state.getFirestoreUserData();
  }
}
