import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edenfarm_test/commons/base_stateful.dart';
import 'package:edenfarm_test/providers/home_state.dart';
import 'package:edenfarm_test/utils/constants.dart';
import 'package:edenfarm_test/utils/size_config.dart';
import 'package:edenfarm_test/utils/v_color.dart';
import 'package:edenfarm_test/utils/v_navigation.dart';
import 'package:edenfarm_test/widgets/v_popup.dart';
import 'package:edenfarm_test/widgets/v_widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends BaseStateful<HomeScreen, HomeState> {

  Widget _body() {
    return SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(paddingLarge)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: getProportionateScreenWidth(marginExtraLarge),),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        VText(
                          "Welcome,",
                          color: VColor.black,
                          isBold: true,
                          fontSize: getProportionateScreenWidth(textSizeExtraLarge),
                          align: TextAlign.left,
                        ),
                        VText(
                          state.user!.displayName??(state.user!.email??"Guest"),
                          color: VColor.primary,
                          fontSize: getProportionateScreenWidth(textSizeLarge),
                          align: TextAlign.left,
                          isBold: true,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: getProportionateScreenWidth(marginLarge),),
                  Row(
                    children: [
                      VCircleIconButton(
                        imgPath: "person_icon.svg",
                        iconSize: getProportionateScreenWidth(20),
                        iconColor: VColor.white,
                        onPressed: ()async{
                          VNavigation.profile(context);
                        },
                      ),
                      SizedBox(width: getProportionateScreenWidth(marginMedium),),
                      VCircleIconButton(
                        imgPath: "logout_icon.svg",
                        iconSize: getProportionateScreenWidth(20),
                        iconColor: VColor.white,
                        onPressed: ()async{
                          VPopup(context).alertChoiceWithCallback(
                            "Log Out",
                              "Are you sure want to logout?",
                              "Cancel",
                              "Logout Anyway",
                              () {
                                Navigator.pop(context);
                              },
                              () {
                                Navigator.pop(context,1);
                              },
                              (value)async{
                                if(value!=null && value == 1){
                                  try{
                                    VPopup(context).loading();
                                    await state.signOut(context: context);
                                    Navigator.pop(context);
                                    VNavigation.login(context,);
                                  }catch(e){
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      customSnackBar(
                                        content: 'Error signing out. Try again.',
                                      ),
                                    );
                                  }
                                }
                              },
                          );
                        },
                      ),
                    ],
                  )
                ],
              ),
              SizedBox(height: getProportionateScreenWidth(marginExtraLarge),),
              VText("Your weight record",fontSize: getProportionateScreenWidth(textSizeMedium),isBold: true,),
              SizedBox(height: getProportionateScreenWidth(marginMedium),),
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance.collection("weightRecord").snapshots(),
                  builder: (context, snapshot) {
                    return !snapshot.hasData
                        ? Center(child: CircularProgressIndicator())
                        : snapshot.data!.docs.length > 0
                        ? ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        DocumentSnapshot data = snapshot.data!.docs[index];
                        if(data['userModelId']==state.firestoreUserId){
                          return Container(
                            width: double.infinity,
                            margin: EdgeInsets.only(bottom: getProportionateScreenWidth(marginSmall)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                VText("Weight value : "+data['value'].toString(),fontSize: getProportionateScreenWidth(textSizeSmall),),
                                VText("Taken at : "+dateStringFromTimestamp(data['date']),fontSize: getProportionateScreenWidth(textSizeSmall),),
                                SizedBox(height: getProportionateScreenWidth(marginSuperSmall),),
                                Divider(color: VColor.grey1, height: getProportionateScreenWidth(1),),
                              ],
                            ),
                          );
                        }
                        return Container();
                      },
                    ) : Center(
                      child: VText("No Weight Data Yet, Take Data!",fontSize: getProportionateScreenWidth(textSizeMedium),color: VColor.grey3,isBold: true,),
                    );
                  },
                ),
              ),
              SizedBox(height: getProportionateScreenWidth(marginExtraLarge),),
              VButton(
                  "Add Weight Record",
                  textPadding: getProportionateScreenWidth(paddingLarge),
                  onPressed: ()async{
                    VPopup(context).addWeightRecord(
                        (value)async{
                          if(value!=null){
                            await FirebaseFirestore.instance.collection("weightRecord").add({
                              'userModelId': state.firestoreUserId,
                              'value': value["weight"],
                              'date' : DateTime.now()
                            });
                          }
                        }
                    );
                  },
              ),
              SizedBox(height: getProportionateScreenWidth(marginExtraLarge),),
            ],
          ),
        ),
    );
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

  String dateStringFromTimestamp(Timestamp time){
    var date = DateTime.fromMicrosecondsSinceEpoch(time.microsecondsSinceEpoch);
    return DateFormat("dd/MM/yyyy hh:mm:ss").format(date);
  }

  @override
  void registerState() async{
    SizeConfig().init(context);
    state = HomeState();
    state.user = FirebaseAuth.instance.currentUser;
    state.getFirestoreUserId();
  }
}
