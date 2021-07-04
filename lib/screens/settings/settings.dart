import 'package:DrHwaida/constants/constans.dart';
import 'package:DrHwaida/constants/themes.dart';
import 'package:DrHwaida/localization/localization_constants.dart';
import 'package:DrHwaida/main.dart';
import 'package:DrHwaida/models/language.dart';
import 'package:DrHwaida/models/user.dart';
import 'package:flutter/material.dart';
import 'package:DrHwaida/models/utils.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../sharedPreferences.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  String error = '';
  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  bool obscurePassword = true;
  bool obscureconPassword = true;
  String newPassword = '';
  String oldPassPassword = '';
  String confirmPassword = '';
  bool loading = false;
  bool showChangePas = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(title: getTranslated(context, "settings")),
      key: _scaffoldKey,
      body: (loading)
          ? Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            )
          : Container(
              padding: EdgeInsets.only(left: 16, right: 16, top: 30),
              child: ListView(
                children: [
                  Form(
                    key: _formKey,
                    child: (User.userSkipLogIn == true)
                        ? Container()
                        : Column(
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.person,
                                    color: customColor,
                                  ),
                                  SizedBox(width: 5),
                                  Text(
                                    getTranslated(context, "account"),
                                    style: AppTheme.heading,
                                  ),
                                ],
                              ),
                              Divider(
                                height: 15,
                                thickness: 2,
                              ),
                              SizedBox(height: 20),
                              acountBody(
                                  title:
                                      getTranslated(context, "Change_password"),
                                  onTap: () {
                                    setState(() {
                                      showChangePas = !showChangePas;
                                    });
                                  }),
                              (showChangePas)
                                  ? Container()
                                  : (User.userSkipLogIn == true)
                                      ? Container()
                                      : Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 10, horizontal: 10),
                                          child: Column(
                                            children: [
                                              SizedBox(height: 10),
                                              TextFormField(
                                                style: TextStyle(
                                                    color: Colors.black),
                                                decoration:
                                                    textFormInputDecorationForPassword(
                                                  Icons.visibility_off,
                                                  getTranslated(
                                                      context, "old_password"),
                                                  () {
                                                    setState(() {
                                                      obscurePassword =
                                                          !obscurePassword;
                                                    });
                                                  },
                                                  obscurePassword,
                                                ),
                                                validator: (val) =>
                                                    validateOldPassord(
                                                        val, oldPassPassword),
                                                obscureText: obscurePassword,
                                                onChanged: (val) {
                                                  setState(() {
                                                    oldPassPassword = val;
                                                  });
                                                },
                                              ),
                                              SizedBox(height: 10),
                                              TextFormField(
                                                style: TextStyle(
                                                    color: Colors.black),
                                                decoration:
                                                    textFormInputDecorationForPassword(
                                                  Icons.visibility_off,
                                                  getTranslated(
                                                      context, "new_password"),
                                                  () {
                                                    setState(() {
                                                      obscurePassword =
                                                          !obscurePassword;
                                                    });
                                                  },
                                                  obscurePassword,
                                                ),
                                                validator: (val) =>
                                                    validatePassord(val),
                                                obscureText: obscurePassword,
                                                onChanged: (val) {
                                                  setState(() {
                                                    newPassword = val;
                                                  });
                                                },
                                              ),
                                              SizedBox(height: 10),
                                              TextFormField(
                                                style: TextStyle(
                                                    color: Colors.black),
                                                decoration:
                                                    textFormInputDecorationForPassword(
                                                  Icons.visibility_off,
                                                  getTranslated(context,
                                                      "Confirm_password"),
                                                  () {
                                                    setState(() {
                                                      obscureconPassword =
                                                          !obscureconPassword;
                                                    });
                                                  },
                                                  obscureconPassword,
                                                ),
                                                validator: (val) =>
                                                    validateConfrimPassord(
                                                  val,
                                                  newPassword,
                                                  confirmPassword,
                                                ),
                                                obscureText: obscureconPassword,
                                                onChanged: (val) {
                                                  setState(() {
                                                    confirmPassword = val;
                                                  });
                                                },
                                              ),
                                              SizedBox(height: 10),
                                              // ignore: deprecated_member_use
                                              RaisedButton(
                                                color: customColor,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(35),
                                                ),
                                                child: Text(
                                                  getTranslated(
                                                      context, "Change"),
                                                  style:
                                                      AppTheme.heading.copyWith(
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                onPressed: () async {
                                                  if (_formKey.currentState
                                                      .validate()) {
                                                    setState(() {
                                                      loading = !loading;
                                                    });
                                                    chagePassword(
                                                      newPasswrod: newPassword,
                                                      oldPassword:
                                                          oldPassPassword,
                                                    );
                                                  }
                                                },
                                              ),
                                              Text(
                                                error,
                                                style: AppTheme.heading,
                                              ),
                                              SizedBox(height: 10),
                                            ],
                                          ),
                                        ),
                              SizedBox(height: 10),
                              Divider(
                                height: 15,
                                thickness: 2,
                              ),
                              SizedBox(height: 20),
                            ],
                          ),
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.app_settings_alt,
                        color: customColor,
                      ),
                      SizedBox(width: 5),
                      Text(
                        getTranslated(context, "app_settings"),
                        style: AppTheme.heading,
                      ),
                    ],
                  ),
                  Divider(
                    height: 15,
                    thickness: 2,
                  ),
                  SizedBox(height: 20),
                  lan(),
                  Divider(
                    height: 15,
                    thickness: 2,
                  ),
                ],
              ),
            ),
    );
  }

  GestureDetector acountBody({String title, Function onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: AppTheme.heading,
          ),
          Transform.rotate(
            angle: 180 * 3.14 / 180,
            child: Icon(
              Icons.arrow_back_ios,
              color: customColor,
            ),
          ),
        ],
      ),
    );
  }

  String validatePassord(String val) {
    if (val.isEmpty) {
      return getTranslated(context, "valid_password");
    } else if (val.length < 6) {
      return getTranslated(context, "valid_password_len");
    } else {
      return null;
    }
  }

  String validateConfrimPassord(
    String val,
    String password,
    String confrimPassord,
  ) {
    if (val.isEmpty) {
      return getTranslated(context, "valid_password");
    } else if (password != confirmPassword) {
      return getTranslated(context, "password_not_mat");
    } else {
      return null;
    }
  }

  String validateOldPassord(
    String val,
    String oldPassword,
  ) {
    if (val.isEmpty) {
      return getTranslated(context, "valid_password");
    } else if (val.length < 6) {
      return getTranslated(context, "valid_password_len");
    } else if (oldPassword != User.userPassword) {
      return getTranslated(context, "valid_old_password");
    } else {
      return null;
    }
  }

  Widget lan() {
    return DropdownButton<Language>(
      dropdownColor: Colors.white,
      underline: SizedBox(),
      hint: Text(
        getTranslated(context, 'language'),
        style: AppTheme.heading,
      ),
      isExpanded: true,
      elevation: 0,
      icon: Icon(
        Icons.language,
        color: Colors.lightBlueAccent,
      ),
      onChanged: (Language language) {
        _changeLanguage(language);
        print(language.toString());
      },
      items: Language.languageList()
          .map<DropdownMenuItem<Language>>(
            (e) => DropdownMenuItem<Language>(
              value: e,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Text(
                    e.flag,
                    style: TextStyle(fontSize: 30),
                  ),
                  Text(e.name)
                ],
              ),
            ),
          )
          .toList(),
    );
  }

  void _changeLanguage(Language language) async {
    Locale _locale = await setLocale(language.languageCode);

    MyApp.setLocale(context, _locale);

    MySharedPreferences.saveAppLang(_locale.toString());
    User.appLang = await MySharedPreferences.getAppLang();
    // MySharedPreferences.saveApiLang(apiLang());
    // User.apiLang = await MySharedPreferences.getApiLang();
  }

  chagePassword({String oldPassword, String newPasswrod}) async {
    try {
      var response =
          await http.post(Uri.parse(Utils.CHANGEPASSWORD_URL), headers: {
        'x-api-key': User.userToken,
        'lang': User.apiLang,
      }, body: {
        'new_password': newPassword,
        'old_password': oldPassword,
      });

      Map<String, dynamic> map = json.decode(response.body);

      if (map['success'] == true) {
        setState(() {
          loading = !loading;
          MySharedPreferences.saveUserUserPassword(newPasswrod);
        });
        // ignore: deprecated_member_use
        _scaffoldKey.currentState.showSnackBar(
          new SnackBar(
            content: new Text('password was changed'),
          ),
        );

        MySharedPreferences.saveUserUserPassword(newPasswrod);
      } else {
        print('seroro Massege:' + map['message']);
        print(response.statusCode.toString());
        setState(() {
          loading = false;
          error = map['message'];
        });
        // ignore: deprecated_member_use
        _scaffoldKey.currentState.showSnackBar(
          new SnackBar(
            content: new Text(' password was not changed,please try again'),
          ),
        );
      }
    } catch (e) {
      setState(() {
        setState(() {
          loading = false;
        });
      });
      print(e.toString());
    }
  }

  Future<void> showMyDialog({BuildContext context}) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  getTranslated(context, "password_Changed"),
                  style: AppTheme.heading.copyWith(
                    color: customColor,
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            // ignore: deprecated_member_use
            RaisedButton(
              color: customColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(35),
              ),
              child: Text(
                'oki',
                style: AppTheme.heading.copyWith(
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                    builder: (_) => Settings(),
                  ),
                  ModalRoute.withName('/'),
                );
              },
            ),
          ],
        );
      },
    );
  }
}
