import 'package:edenfarm_test/commons/base_stateful.dart';
import 'package:edenfarm_test/providers/login_state.dart';
import 'package:edenfarm_test/providers/register_state.dart';
import 'package:edenfarm_test/utils/constants.dart';
import 'package:edenfarm_test/utils/size_config.dart';
import 'package:edenfarm_test/utils/v_color.dart';
import 'package:edenfarm_test/utils/v_navigation.dart';
import 'package:edenfarm_test/widgets/v_popup.dart';
import 'package:edenfarm_test/widgets/v_widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends BaseStateful<RegisterScreen, RegisterState> {
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
                      "Create your account",
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
                      textCapitalization : TextCapitalization.none,
                      hint: "Email",
                      textEditingController: state.controllerEmail,
                    ),
                    SizedBox(height: getProportionateScreenWidth(marginLarge),),
                    VText(
                      "Password",
                      color: VColor.black,
                      isBold: true,
                      fontSize: getProportionateScreenWidth(textSizeMedium),
                      align: TextAlign.left,
                    ),
                    SizedBox(height: getProportionateScreenWidth(getProportionateScreenWidth(marginSmall)),),
                    VInputText(
                      textCapitalization : TextCapitalization.none,
                      hint: "Password",
                      maxLines: 1,
                      textEditingController: state.controllerPassword,
                      isSecureText: state.isSecureText,
                      suffixIcon: IconButton(
                        onPressed: () {
                          state.isSecureText = !state.isSecureText;
                          state.notifyListeners();
                        },
                        icon: state.isSecureText
                            ? Icon(
                          Icons.visibility,
                        )
                            : Icon(
                          Icons.visibility_off,
                        ),
                      ),
                    ),
                    SizedBox(height: getProportionateScreenWidth(marginLarge*2),),
                    VButton(
                      "Register",
                      textPadding: getProportionateScreenWidth(paddingMedium),
                      onPressed: () async{
                        try{
                          if(isValidated()){
                            VPopup(context).loading();
                            User? user = await state.registerWithEmail(context: context);
                            Navigator.pop(context);
                            if(user!=null){
                              if(user.email != null) {
                                await state.addUsertoFirestore();
                                VPopup(context).alertTextWithCallback(
                                    "Succes",
                                    "Congratulation, your account was created. Please login to continue the session",
                                        (value) {
                                      Navigator.pop(context);
                                    }
                                );
                              }
                            }else{
                              VPopup(context).alertText("Oopps", "Register failed, please try again");
                            }
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
    if(state.controllerPassword.text.isEmpty){
      VPopup(context).alertText("Fill not complete", "Password cannot be an empty",);
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
    state = RegisterState();

  }
}
