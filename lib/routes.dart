import 'package:DrHwaida/interNetCon.dart';
import 'package:DrHwaida/screens/splashscreen.dart';
import 'package:DrHwaida/screens/wrapper/home/home.dart';
import 'package:flutter/material.dart';

Map<String, WidgetBuilder> routes = {
  Home.route: (_) => Home(),
  SplashScreen.route: (_) => SplashScreen(),
  EnterNitCON.route: (_) => EnterNitCON(),
};
