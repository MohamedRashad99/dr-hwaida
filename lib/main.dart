import 'dart:io';

import 'package:DrHwaida/constants/constans.dart';
import 'package:DrHwaida/models/user.dart';
import 'package:DrHwaida/routes.dart';
import 'package:DrHwaida/screens/splashscreen.dart';
import 'package:DrHwaida/services/connectivity_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'enums/connectivity_status.dart';
import 'localization/app_localization.dart';
import 'localization/localization_constants.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key key}) : super(key: key);
  static void setLocale(BuildContext context, Locale newLocale) {
    _MyAppState state = context.findAncestorStateOfType<_MyAppState>();
    state.setLocale(newLocale);
  }

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale _locale;
  setLocale(Locale locale) async {
    setState(() {
      _locale = locale;
      // DBHelper.saveAppLang(locale.toString());00
    });
    print('Applan:' + locale.toString());
    print('Applanshard:' + User.appLang);
  }

  @override
  void didChangeDependencies() {
    getLocale().then((locale) {
      // if (User.appLang == null) {
      ////   setState(() {
      //     // ignore: unnecessary_statements
      //     this._locale == null;
      //   });
      // } else {
      setState(() {
        this._locale = locale;
      });
      // }
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return StreamProvider<ConnectivityStatus>(
      initialData: null,
      create: (context) =>
          ConnectivityService().connectionStatusController.stream,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          canvasColor: Colors.white,
          scaffoldBackgroundColor: Color(0xffff1f1f1),
          primaryIconTheme: IconThemeData(color: Colors.white),
          primaryColor: customColor,
          iconTheme: IconThemeData(color: Colors.white),
        ),
        initialRoute: SplashScreen.route,
        routes: routes,
        locale: _locale,
        supportedLocales: [
          const Locale('ar', 'EG'),
          const Locale('en', 'US'),
        ],
        localizationsDelegates: [
          AppLocalization.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        localeResolutionCallback: (deviceLocale, supportedLocales) {
          if (User.appLang == null) {
            for (var locale in supportedLocales) {
              if (locale.languageCode == Platform.localeName.split('_')[0]) {
                print("locale:$locale");
                return locale;
              }
            }

            return supportedLocales.first;
          } else {
            for (var locale in supportedLocales) {
              if (locale.languageCode == User.appLang.split('_')[0]) {
                return locale;
              }
            }

            return supportedLocales.first;
          }
        },
      ),
    );
  }
}
