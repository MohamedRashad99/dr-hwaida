import 'package:DrHwaida/constants/constans.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static final TextStyle heading = TextStyle(
    fontFamily: 'BebasNeue',
    fontWeight: FontWeight.w700,
    fontSize: 12,
    letterSpacing: 1.2,
    color: Colors.black,
  );
  static final TextStyle subHeading = TextStyle(
    fontFamily: 'BebasNeue',
    fontSize: 10,
    color: Colors.black,
  );
  static final containerBackground = LinearGradient(
    begin: Alignment.centerRight,
    end: Alignment.centerLeft,
    colors: [
      Color(0xfffa901d4),
      Color(0xfffA8932d7),
      Color(0xfffA5486dd),
      Color(0xfff33b9e1),
    ],
  );
}

///////////////////////////////////////////////////////////////////////////
InputDecoration textFormInputDecorationForPassword(
    IconData icon, String label, Function obscureText, bool obscurepasswrod) {
  return InputDecoration(
    errorStyle: AppTheme.subHeading.copyWith(
      color: customColor,
    ),
    hintText: label,
    hintStyle: AppTheme.heading.copyWith(
      color: customColor,
      fontSize: 14,
    ),
    fillColor: Colors.white,
    filled: true,
    isDense: true,
    contentPadding: EdgeInsets.all(10),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(20),
      borderSide: BorderSide(
        style: BorderStyle.solid,
        color: customColor,
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(20),
      borderSide: BorderSide(
        style: BorderStyle.solid,
        color: customColor,
      ),
    ),
    suffixIcon: IconButton(
      onPressed: obscureText,
      icon: obscurepasswrod
          ? Icon(
              icon,
              color: customColor,
            )
          : Icon(
              Icons.visibility,
              color: customColor,
            ),
    ),
  );
}

//////////////////////////////////////////////////////////////////////
InputDecoration textFormInputDecoration(
  IconData icon,
  String label,
) {
  return InputDecoration(
    errorStyle: AppTheme.subHeading.copyWith(
      color: customColor,
    ),
    hintText: label,
    hintStyle: AppTheme.heading.copyWith(
      color: customColor,
      fontSize: 14,
    ),
    fillColor: Colors.white,
    filled: true,
    isDense: true,
    contentPadding: EdgeInsets.all(10),
    suffixIcon: Icon(
      icon,
      color: customColor,
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(20),
      borderSide: BorderSide(
        style: BorderStyle.solid,
        color: customColor,
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(20),
      borderSide: BorderSide(
        style: BorderStyle.solid,
        color: customColor,
      ),
    ),
  );
}

///////////////////////////////////////////////////////////////
InputDecoration conectedTextFormStyle({String lableText}) {
  return InputDecoration(
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(28),
      borderSide: BorderSide(color: customColor),
      gapPadding: 10,
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(28),
      borderSide: BorderSide(color: customColor),
      gapPadding: 10,
    ),
    // suffixIcon: Icon(
    //   Icons.edit,
    //   color: customColor,
    // ),
    contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    labelStyle: AppTheme.heading.copyWith(
      color: customColor,
    ),
    labelText: lableText,
  );
}

/////////////////////////////////////////////////////////
