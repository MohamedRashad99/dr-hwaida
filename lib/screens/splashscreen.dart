import 'dart:async';
import 'dart:io';
import 'package:DrHwaida/constants/constans.dart';
import 'package:DrHwaida/models/user.dart';
import 'package:DrHwaida/services/network_sensitive.dart';
import 'package:flutter/material.dart';
import '../sharedPreferences.dart';
import 'onboarding/onboarding.dart';

class SplashScreen extends StatefulWidget {
  static final route = '/splashScreen';

  static bool slider = true;
  static void isSlider() {
    slider = !slider;
  }

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  getDateOfUser() async {
    User.userLogIn = await MySharedPreferences.getUserSingIn();
    User.userToken = await MySharedPreferences.getUserUserToken();
    if (User.appLang == null) {
      // setState(() {
      //   MySharedPreferences.saveAppLang(Platform.localeName);
      // });
      if (Platform.localeName.split('_')[0] == 'ar') {
        setState(() {
          MySharedPreferences.saveAppLang('ar_EG');
        });
      } else {
        setState(() {
          MySharedPreferences.saveAppLang('en_US');
        });
      }
    }
    User.appLang = await MySharedPreferences.getAppLang();
  }

  @override
  void initState() {
    getDateOfUser();

    super.initState();

    Timer(
      Duration(seconds: 10),
      () {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (_) => OnBoard(),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: customColor,
      ),
      body: NetworkSensitive(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Container(
                height: 200,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('lib/images/logowhite.png'),
                    fit: BoxFit.fitHeight,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
