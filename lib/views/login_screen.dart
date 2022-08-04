import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edenfarm_test/commons/base_stateful.dart';
import 'package:edenfarm_test/providers/login_state.dart';
import 'package:edenfarm_test/utils/constants.dart';
import 'package:edenfarm_test/utils/size_config.dart';
import 'package:edenfarm_test/utils/v_color.dart';
import 'package:edenfarm_test/utils/v_navigation.dart';
import 'package:edenfarm_test/widgets/v_popup.dart';
import 'package:edenfarm_test/widgets/v_widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends BaseStateful<LoginScreen, LoginState> {

  Widget _body() {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(paddingLarge)),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  SizedBox(height: getProportionateScreenWidth(marginExtraLarge),),
                  VText(
                    "Welcome to,",
                    color: VColor.black,
                    isBold: true,
                    fontSize: getProportionateScreenWidth(textSizeSuperLarge),
                    align: TextAlign.left,
                  ),
                  SizedBox(height: getProportionateScreenWidth(marginSmall),),
                  VText(
                    "Fit Tracker App",
                    color: VColor.primary,
                    fontSize: getProportionateScreenWidth(textSizeExtraLarge),
                    align: TextAlign.left,
                    isBold: true,
                  ),
                  SizedBox(height: getProportionateScreenWidth(marginExtraLarge*2),),
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
                  SizedBox(height: getProportionateScreenWidth(marginLarge),),
                  VButton(
                    "Login",
                    textPadding: getProportionateScreenWidth(paddingMedium),
                    onPressed: () async{
                      try{
                        if(isValidated()){
                          VPopup(context).loading();
                          User? user = await state.signInWithEmail(context: context);
                          Navigator.pop(context);
                          if(user!=null){
                            if(user.email != null){
                              VNavigation.home(context,);
                            }
                          }else{
                            VPopup(context).alertText("Oopps", "Looks like we can't find your account, try to register");
                          }
                        }
                      }catch(e){
                        Navigator.pop(context);
                        throw Exception(e);
                      }
                    },
                  ),
                  SizedBox(height: getProportionateScreenWidth(marginExtraLarge),),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                          height:0.2,
                          width: getProportionateScreenWidth(75),
                          color:VColor.grey3
                      ),
                      SizedBox(width: getProportionateScreenWidth(marginSmall),),
                      VText("or sign with",
                        color: VColor.grey3,
                        fontSize: getProportionateScreenWidth(textSizeMedium),
                      ),
                      SizedBox(width: getProportionateScreenWidth(marginSmall),),
                      Container(
                          height:0.2,
                          width: getProportionateScreenWidth(75),
                          color:VColor.grey3
                      ),
                    ],
                  ),
                  SizedBox(height: getProportionateScreenWidth(marginExtraLarge),),
                  VButtonIcon(
                    "Continue with Google",
                    imgPath: "google.svg",
                    iconSize: getProportionateScreenWidth(textSizeLarge),
                    textColor: VColor.white,
                    buttonColor: VColor.grey1,
                    onPressed: ()async{
                      try{
                        User? user = await state.signInWithGoogle(context: context);
                        if(user!=null){
                          if(user.email != null){
                            await FirebaseFirestore.instance.collection("userModel").add({
                              'email': user.email.toString(),
                            });
                            VNavigation.home(context,);
                          }
                        }
                      }catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          customSnackBar(
                            content: 'Error occurred using Google Sign In. Try again.',
                          ),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: getProportionateScreenWidth(marginExtraLarge),),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget> [
                VText("Don't have an account?" ,color: VColor.grey4, fontSize: getProportionateScreenWidth(textSizeMedium),),
                SizedBox(width: getProportionateScreenWidth(5.0),),
                VText("Register",isBold: true,color: VColor.primary, fontSize: getProportionateScreenWidth(textSizeMedium),decoration: TextDecoration.underline,
                  onPressed: (){
                    VNavigation.register(context);
                  },
                )
              ],
            ),
            SizedBox(height: getProportionateScreenWidth(30),),
          ],
        ),
      )
    );
  }

  bool isValidated(){
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
    state = LoginState();

  }
}
