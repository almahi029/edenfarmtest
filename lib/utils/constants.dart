import 'package:google_fonts/google_fonts.dart';

String imagePath = "assets/images/";
const kAnimationDuration = Duration(milliseconds: 200);

class PrefConst {
  static const String keyAccessToken = 'accessToken';
  static const String keyRefreshToken = 'refreshToken';
  static const String keyIsLoggedIn = 'isLoggedIn';
  static const String keyEmailAddress = 'emailAddress';
  static const String keyUsername = 'username';
  static const String keyPassword = 'password';
  static const String keyUserHeight = 'userHeight';
  static const String keyUserWeight = 'userWeight';

}


double textSizeSmall = 12.0;
double textSizeMedium = 14.0;
double textSizeLarge = 18.0;
double textSizeExtraLarge = 20.0;
double textSizeSuperLarge = 24.0;

double radiusSmall = 8.0;
double radiusMedium = 10.0;
double radiusLarge = 12.0;
double radiusExtraLarge = 16.0;
double radiusSuperLarge = 20.0;


double paddingSuperSmall = 5.0;
double paddingSmall = 10.0;
double paddingMedium = 14.0;
double paddingLarge = 18.0;
double paddingExtraLarge = 24.0;

double marginSuperSmall = 5.0;
double marginSmall = 10.0;
double marginMedium = 14.0;
double marginLarge = 18.0;
double marginExtraLarge = 24.0;

double defaultHeightBackroundPrimary = 195.0;
double defaultHeightContainerCard = 145.0;
double defaultWidthContainerCard = 335.0;

String getMessage(String message) =>
    _listMessage[message] ?? "Something Went Wrong";
Map<String, String> _listMessage = {"": ""};

String? interFontFamily = GoogleFonts.inter().fontFamily;
