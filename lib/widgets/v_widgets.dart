import 'package:edenfarm_test/utils/constants.dart';
import 'package:edenfarm_test/utils/extensions.dart';
import 'package:edenfarm_test/utils/size_config.dart';
import 'package:edenfarm_test/utils/v_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class VInputText extends StatelessWidget {
  final String initialValue;
  final TextEditingController? textEditingController;
  final FocusNode? focusNode;
  final String hint;
  final FormFieldSetter<String>? onSaved;
  final ValueChanged<String>? onChanged;
  final bool isSecureText;
  final FormFieldValidator<String>? validator;
  final Widget? suffixIcon;
  final bool readOnly;
  final TextInputType keyboardType;
  final TextInputAction? textInputAction;
  final Widget? prefixIcon;
  final Color? fillColor;
  final Color filledBorderColor;
  final Color? hintTextColor;
  final Color? textColor;
  final bool filled;
  final double textPadding;
  int? maxLines = 1;
  final TextCapitalization textCapitalization;


  VInputText(
      {this.initialValue = "",
        this.textEditingController,
        this.hint = "",
        this.onSaved,
        this.focusNode,
        this.filled = false,
        this.fillColor = VColor.primary_opacity,
        this.textColor = VColor.grey4,
        this.hintTextColor = VColor.grey4,
        this.filledBorderColor = Colors.transparent,
        this.onChanged,
        this.isSecureText = false,
        this.validator,
        this.suffixIcon,
        this.readOnly = false,
        this.keyboardType = TextInputType.text,
        this.textInputAction,
        this.prefixIcon,
        this.textCapitalization = TextCapitalization.characters,
        this.textPadding = 14,
        this.maxLines});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: readOnly,
      textInputAction: textInputAction,
      controller: textEditingController?.text == ''
          ? (textEditingController?..text = initialValue)
          : textEditingController,
      focusNode: focusNode,
      style: TextStyle(
          fontFamily: interFontFamily,
          fontSize: getProportionateScreenWidth(textSizeMedium),
          color: filled ? textColor : VColor.grey4),
      maxLines: maxLines,
      obscureText: isSecureText,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        hintText: hint,
        hintStyle: TextStyle(
          fontSize: getProportionateScreenWidth(textSizeMedium),
          fontFamily: interFontFamily,
          color: filled ? hintTextColor : VColor.grey1,
        ),
        filled: filled,
        fillColor: fillColor,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: filled ? filledBorderColor : VColor.primary,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: filled ? filledBorderColor : VColor.grey1,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: filled ? filledBorderColor : VColor.grey1,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: filled ? filledBorderColor : VColor.grey1,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        contentPadding: EdgeInsets.symmetric(
          vertical: getProportionateScreenWidth(textPadding),
          horizontal: getProportionateScreenWidth(textPadding),
        ),
      ),
      textCapitalization: textCapitalization,
      validator: validator,
      onSaved: onSaved,
      onChanged: onChanged,
    );
  }
}

class VLoadingPage extends StatelessWidget {
  Widget _loadingPage() {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(VColor.primary),
          ),
          SizedBox(
            height: 14,
          ),
          VText(
            "Please wait . . .",
            color: VColor.grey4,
            fontSize: 14,
            maxLines: 1,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _loadingPage();
  }
}

class VAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget> action;
  final bool isCenter;
  final bool isLightTheme;
  final double elevation;

  VAppBar(this.title,
      {this.action = const [],
        this.isCenter = true,
        this.isLightTheme = true,
        this.elevation = 0.0});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: elevation,
      centerTitle: isCenter,
      backgroundColor: isLightTheme ? VColor.white : VColor.primary,
      titleTextStyle: TextStyle(
        color: isLightTheme ? VColor.black : VColor.white,
      ),
      title: VText(
        title,
        isBold: true,
        fontSize: 17.0,
        color: isLightTheme ? VColor.black : VColor.white,
      ),
      leadingWidth: 32.0,
      iconTheme:
      IconThemeData(color: isLightTheme ? VColor.black : VColor.white),
      actions: action,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(50.0);
}

class VText extends StatelessWidget {
  final String? title;
  final double? fontSize;
  final TextOverflow? overflow;
  final TextAlign? align;
  final bool? money;
  final TextDecoration? decoration;
  final int? maxLines;
  final Color? color;
  final bool? isBold;
  final VoidCallback? onPressed;

  VText(this.title,
      {this.fontSize,
        this.overflow,
        this.money = false,
        this.onPressed,
        this.decoration,
        this.maxLines,
        this.align,
        this.color = VColor.black,
        this.isBold = false});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Text(
        money! ? title!.currency : title!,
        style: TextStyle(
          fontFamily: interFontFamily,
          color: color,
          fontSize: fontSize,
          fontWeight: isBold! ? FontWeight.bold : FontWeight.normal,
          decoration: decoration,
        ),
        overflow: overflow,
        textAlign: align,
        maxLines: maxLines,
      ),
    );
  }
}

class VButtonBorder extends StatelessWidget {
  final String title;
  final Color textColor;
  final Color textColorDisabled;
  final Color buttonColor;
  final Color buttonColorDisabled;
  final Color borderColor;
  final VoidCallback? onPressed;
  final bool disabled;
  final double textPadding;
  final double borderRadius;

  VButtonBorder(
      this.title, {
        this.textColor = VColor.white,
        this.textColorDisabled = VColor.grey1,
        this.buttonColor = VColor.primary,
        this.buttonColorDisabled = VColor.primary_opacity,
        this.borderColor = VColor.primary,
        @required this.onPressed,
        this.disabled = false,
        this.textPadding = 24,
        this.borderRadius = 10,
      });

  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
      absorbing: disabled,
      child: TextButton(
        onPressed: onPressed,
        child: VText(
          title,
          isBold: true,
          color: !disabled ? textColor : textColorDisabled,
        ),
        style: ButtonStyle(
          padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
              EdgeInsets.all(textPadding)),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                  side: BorderSide(
                      color: borderColor, width: 0.5, style: BorderStyle.solid),
                  borderRadius: BorderRadius.circular(borderRadius))),
          backgroundColor: MaterialStateProperty.all<Color>(
            !disabled ? buttonColor : buttonColorDisabled,
          ),
        ),
      ),
    );
  }
}

class VButtonIcon extends StatelessWidget {
  final String title, imgPath;
  final double iconSize;
  final Color textColor, textColorDisabled, buttonColor, buttonColorDisabled;
  final VoidCallback? onPressed;
  final bool disabled;

  VButtonIcon(this.title,
      {this.imgPath = "assets/images/logo_float.svg",
        this.iconSize = 40,
        this.textColor = VColor.white,
        this.textColorDisabled = VColor.grey1,
        this.buttonColor = VColor.primary,
        this.buttonColorDisabled = VColor.primary_opacity,
        @required this.onPressed,
        this.disabled = false});

  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
      absorbing: disabled,
      child: FlatButton(
        onPressed: onPressed,
        color: buttonColor,
        disabledColor: buttonColorDisabled,
        textColor: textColor,
        disabledTextColor: textColorDisabled,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        padding: EdgeInsets.all(14.0),
        child: Row(
          // Replace with a Row for horizontal icon + text
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            VSvgPicture(imagePath + imgPath, height: iconSize, width: iconSize),
            SizedBox(
              width: 20,
            ),
            Text(
              title,
              textAlign: TextAlign.center,
              style: new TextStyle(fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}

class VButton extends StatelessWidget {
  final String title;
  final Color textColor;
  final Color textColorDisabled;
  final Color buttonColor;
  final Color buttonColorDisabled;
  final VoidCallback? onPressed;
  final bool disabled;
  final double textPadding;
  final double borderRadius;

  VButton(
      this.title, {
        this.textColor = VColor.white,
        this.textColorDisabled = VColor.grey1,
        this.buttonColor = VColor.primary,
        this.buttonColorDisabled = VColor.primary_opacity,
        @required this.onPressed,
        this.disabled = false,
        this.textPadding = 24,
        this.borderRadius = 10,
      });

  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
      absorbing: disabled,
      child: TextButton(
        onPressed: onPressed,
        child: VText(
          title,
          isBold: true,
          color: !disabled ? textColor : textColorDisabled,
        ),
        style: ButtonStyle(
          padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
              EdgeInsets.all(textPadding)),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(borderRadius)),
          ),
          backgroundColor: MaterialStateProperty.all<Color>(
            !disabled ? buttonColor : buttonColorDisabled,
          ),
        ),
      ),
    );
  }
}

class VSvgPicture extends StatelessWidget {
  final String img;
  final double? height;
  final double? width;
  final Color? color;
  final VoidCallback? onPressed;

  VSvgPicture(this.img, {this.color, this.height, this.width, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: SvgPicture.asset(
        img,
        width: width,
        height: height,
        color: color,
        placeholderBuilder: (BuildContext context) {
          return Icon(
            Icons.error,
            color: VColor.primary,
          );
        },
      ),
    );
  }
}

class VCircleIconButton extends StatelessWidget {
  final String imgPath;
  final double iconSize;
  final Color buttonColor,buttonColorDisabled,iconColor;
  final VoidCallback? onPressed;
  final bool disabled;
  final double padding;

  VCircleIconButton(
      {this.imgPath = "assets/images/logo_float.svg",
        this.iconSize = 40,
        this.padding = 10,
        this.iconColor = VColor.white,
        this.buttonColor = VColor.primary,
        this.buttonColorDisabled = VColor.primary_opacity,
        @required this.onPressed, this.disabled = false});

  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
      absorbing: disabled,
      child: FlatButton(
        onPressed: onPressed,
        color: buttonColor,
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap, //limits the touch area to the button area
        minWidth: 0, //wraps child's width
        height: 0, //wraps child's height
        disabledColor: buttonColorDisabled,
        shape: CircleBorder(),
        padding: EdgeInsets.all(padding),
        child: VSvgPicture(imagePath + imgPath,color: iconColor, height: getProportionateScreenWidth(iconSize),width:getProportionateScreenWidth(iconSize)),
      ),
    );
  }
}




