import 'dart:convert';

import 'package:DrHwaida/constants/constans.dart';
import 'package:DrHwaida/constants/themes.dart';
import 'package:DrHwaida/localization/localization_constants.dart';
import 'package:DrHwaida/models/user.dart';
import 'package:DrHwaida/models/utils.dart';
import 'package:DrHwaida/screens/wrapper/authenticate/passwordRecovery.dart';
import 'package:DrHwaida/screens/wrapper/home/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../sharedPreferences.dart';

class LogIn extends StatefulWidget {
  final Function toggleView;
  LogIn({this.toggleView});
  @override
  _LogInState createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  final _formKey = GlobalKey<FormState>();
  String error = '';
  bool loading = false;
  bool obscurePassword = true;
  String phoneNamber;
  String password;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    logInWithPhoneAndPassword({
      String phoneNummber,
      String password,
      String age,
      String name,
      String gender,
      String status,
    }) async {
      try {
        var response = await http.post(
          Uri.parse(Utils.LOGIN_URL),
          body: {
            'mobile': phoneNummber,
            'password': password,
          },
          headers: {
            'lang': apiLang(),
          },
        );

        Map<String, dynamic> map = json.decode(response.body);
        setState(() async {
          if (map['success'] == true) {
            setState(() {
              User.userToken = map['data']['api_token'].toString();
            });
            MySharedPreferences.saveUserSingIn(true);
            MySharedPreferences.saveUserSkipLogIn(false);
            MySharedPreferences.saveUserUserPassword(password);

            MySharedPreferences.saveUserUserName(
              map['data']['name'].toString(),
            );
            MySharedPreferences.saveUserUserPhoneNumber(
              map['data']['mobile'].toString(),
            );
            MySharedPreferences.saveUserUserGender(
              map['data']['gender'].toString(),
            );
            MySharedPreferences.saveUserUserAge(
              map['data']['age'].toString(),
            );
            MySharedPreferences.saveUserUserStutas(
              map['data']['status'].toString(),
            );
            MySharedPreferences.saveUserUserToken(
              map['data']['api_token'].toString(),
            );
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (_) => Home(),
              ),
            );
          } else {
            setState(() {
              error = map['message'].toString();

              loading = false;
            });
          }
        });
        // Navigator.pop(context);
      } catch (e) {
        setState(() {
          loading = false;
        });

        print(e.toString());
      }
    }

    _loginWithFB(fbID, name) async {
      try {
        var response = await http.post(
          Uri.parse(Utils.FACEBOOK_URL),
          body: {
            'facebook_id': fbID,
            'name': name,
          },
          headers: {
            'lang': apiLang(),
          },
        );
        print(response.statusCode);

        Map<String, dynamic> map = json.decode(response.body);
        print(map);
        setState(
          () async {
            // print('this is the userData data ${userData}');
            if (map['success'] == true) {
              setState(() {
                User.userToken = map['data']['api_token'].toString();
              });
              MySharedPreferences.saveUserSingIn(true);
              MySharedPreferences.saveUserSkipLogIn(false);
              MySharedPreferences.saveUserUserPassword(password);

              MySharedPreferences.saveUserUserName(
                map['data']['name'].toString(),
              );
              MySharedPreferences.saveUserUserPhoneNumber(
                map['data']['mobile'].toString(),
              );
              MySharedPreferences.saveUserUserGender(
                map['data']['gender'].toString(),
              );
              MySharedPreferences.saveUserUserAge(
                map['data']['age'].toString(),
              );
              MySharedPreferences.saveUserUserStutas(
                map['data']['status'].toString(),
              );
              MySharedPreferences.saveUserUserToken(
                map['data']['api_token'].toString(),
              );
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (_) => Home(),
                ),
              );
            } else {
              setState(() {
                error = map['message'].toString();

                loading = false;
              });
            }
          },
        );
        // Navigator.pop(context);
      } catch (e) {
        setState(() {
          loading = !loading;
        });
        print(
            'Catchhhhhhhhhhhhhhhhhhhhhhh errororororrorrorooroeoreoroeroeorero');
        print(e.toString());
      }
    }

    final FacebookLogin facebookSignIn = new FacebookLogin();
    // Future<Null>
    _fblogin() async {
      final FacebookLoginResult result = await facebookSignIn.logIn(['email']);
      print('resssssssssssssssssssssssssssssssssult');
      print(result.status);

      switch (result.status) {
        case FacebookLoginStatus.loggedIn:
          final FacebookAccessToken accessToken = result.accessToken;
          final token = result.accessToken.token;

          final graphResponse = await http.get(
            Uri.parse(
                'https://graph.facebook.com/v2.12/me?fields=name,email&access_token=$token'),
            headers: {
              'lang': apiLang(),
            },
          );
          final profile = json.decode(graphResponse.body);

          print(
              'proooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooofile');

          print(profile);
          _loginWithFB(
            accessToken.userId,
            profile['name'],
          );

          break;
        case FacebookLoginStatus.cancelledByUser:
          print('Login cancelled by the user.');
          setState(() {
            loading = !loading;
          });
          break;
        case FacebookLoginStatus.error:
          setState(() {
            loading = !loading;
          });
          print('Something went wrong with the login process.\n'
              'Here\'s the error Facebook gave us: ${result.errorMessage}');
          break;
      }
      try {} catch (e) {
        print('ErrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrroeoroeorrrrrrrrrrrrrrrrrS');
        print(e.toString());
      }
    }

    _loginWithGOOGLe({googleID, name}) async {
      try {
        var response = await http.post(
          Uri.parse(Utils.GOOGLE_URL),
          body: {
            'google_id': googleID,
            'name': name,
          },
          headers: {
            'lang': apiLang(),
          },
        );
        print(response.statusCode);

        Map<String, dynamic> map = json.decode(response.body);
        print(map);
        setState(
          () async {
            // print('this is the userData data ${userData}');
            if (map['success'] == true) {
              setState(() {
                User.userToken = map['data']['api_token'].toString();
              });
              MySharedPreferences.saveUserSingIn(true);
              MySharedPreferences.saveUserSkipLogIn(false);
              MySharedPreferences.saveUserUserPassword(password);

              MySharedPreferences.saveUserUserName(
                map['data']['name'].toString(),
              );
              MySharedPreferences.saveUserUserPhoneNumber(
                map['data']['mobile'].toString(),
              );
              MySharedPreferences.saveUserUserGender(
                map['data']['gender'].toString(),
              );
              MySharedPreferences.saveUserUserAge(
                map['data']['age'].toString(),
              );
              MySharedPreferences.saveUserUserStutas(
                map['data']['status'].toString(),
              );
              MySharedPreferences.saveUserUserToken(
                map['data']['api_token'].toString(),
              );
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (_) => Home(),
                ),
              );
            } else {
              setState(() {
                error = map['message'].toString();
                loading = !loading;
              });
            }
          },
        );
        // Navigator.pop(context);
      } catch (e) {
        setState(() {
          loading = !loading;
        });
        print(
            'Catchhhhhhhhhhhhhhhhhhhhhhh errororororrorrorooroeoreoroeroeorero');
        print(e.toString());
      }
    }

    _googleLogIn() async {
      try {
        GoogleSignIn _googleSginIn = GoogleSignIn(scopes: ['email']);
        await _googleSginIn.signIn();
        setState(() {
          loading = !loading;
        });
        print(_googleSginIn.currentUser.displayName);
        print(_googleSginIn.currentUser.id);
        _loginWithGOOGLe(
          googleID: _googleSginIn.currentUser.id,
          name: _googleSginIn.currentUser.displayName,
        );
      } catch (e) {
        print("catssssssssss eroooooooooooooor");
        print(e.toString());
      }
    }

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
      ),
      body: (loading)
          ? Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            )
          : ListView(
              shrinkWrap: true,
              primary: true,
              children: [
                Stack(
                  children: [
                    CustomAppBar(
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: Column(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: 100,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage('lib/images/logo.png'),
                                  fit: BoxFit.fitHeight,
                                ),
                              ),
                            ),
                            Text(
                              getTranslated(context, "welcome"),
                              style: AppTheme.heading.copyWith(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 220, left: 30, right: 30),
                      child: Form(
                        key: _formKey,
                        child: SingleChildScrollView(
                          primary: true,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 10),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  TextFormField(
                                    style: TextStyle(color: Colors.black),
                                    keyboardType: TextInputType.phone,
                                    decoration: textFormInputDecoration(
                                      Icons.phone,
                                      getTranslated(context, "phone_num"),
                                    ),
                                    validator: (val) => val.isEmpty
                                        ? getTranslated(
                                            context, "valid_email_phone")
                                        : null,
                                    onChanged: (val) {
                                      setState(() {
                                        phoneNamber = val;
                                      });
                                    },
                                  ),
                                  SizedBox(height: 20),
                                  TextFormField(
                                    style: TextStyle(color: Colors.black),
                                    decoration:
                                        textFormInputDecorationForPassword(
                                      Icons.visibility_off,
                                      getTranslated(context, "password"),
                                      () {
                                        setState(() {
                                          obscurePassword = !obscurePassword;
                                        });
                                      },
                                      obscurePassword,
                                    ),
                                    validator: (val) => val.isEmpty
                                        ? getTranslated(
                                            context, "valid_password")
                                        : null,
                                    obscureText: obscurePassword,
                                    onChanged: (val) {
                                      setState(() {
                                        password = val;
                                      });
                                    },
                                  ),
                                  SizedBox(height: 10),
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        MySharedPreferences.saveUserSkipLogIn(
                                            true);
                                      });
                                      Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                          builder: (_) => Home(),
                                        ),
                                      );
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          getTranslated(context, "skip"),
                                          style: AppTheme.heading
                                              .copyWith(color: customColor),
                                        ),
                                        Transform.rotate(
                                          angle: 180 * 3.14 / 180,
                                          child: Icon(
                                            Icons.arrow_back,
                                            color: customColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Center(
                                    child: Text(
                                      error,
                                      style: AppTheme.heading,
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  CustomButton(
                                    onPress: () async {
                                      if (_formKey.currentState.validate()) {
                                        setState(() {
                                          loading = true;
                                        });

                                        logInWithPhoneAndPassword(
                                          phoneNummber: phoneNamber,
                                          password: password,
                                        );
                                      }
                                    },
                                    text: getTranslated(context, "Entry"),
                                  ),
                                  SizedBox(height: 12),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        getTranslated(context, "forget"),
                                        style: AppTheme.heading.copyWith(),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (_) =>
                                                  PasswordRecovery(),
                                            ),
                                          );
                                        },
                                        child: Text(
                                          getTranslated(context, "password?"),
                                          style: AppTheme.heading.copyWith(
                                            fontWeight: FontWeight.w900,
                                            fontSize: 16,
                                            color: customColor,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 10),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        height: 1,
                                        width: width * .3,
                                        color: customColor,
                                      ),
                                      SizedBox(width: 5),
                                      Text(
                                        getTranslated(context, "or"),
                                        style: AppTheme.heading.copyWith(
                                          fontWeight: FontWeight.w900,
                                          fontSize: 16,
                                          color: customColor,
                                        ),
                                      ),
                                      SizedBox(width: 5),
                                      Container(
                                        height: 1,
                                        width: width * .3,
                                        color: customColor,
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 10),
                                  Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            getTranslated(
                                                context, "havent_account"),
                                            style: AppTheme.heading.copyWith(
                                              fontSize: 12,
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () => widget.toggleView(),
                                            child: Text(
                                              getTranslated(
                                                  context, "create_account"),
                                              style: AppTheme.heading.copyWith(
                                                fontWeight: FontWeight.w900,
                                                fontSize: 16,
                                                color: customColor,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 10),
                                  Row(
                                    children: [
                                      Expanded(
                                        flex: 2,
                                        child: CustomButtonWithchild(
                                          onPress: () {
                                            setState(() {
                                              loading = !loading;
                                            });
                                            _googleLogIn();
                                          },
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Icon(
                                                FontAwesomeIcons.google,
                                                color: Colors.white,
                                              ),
                                            ],
                                          ),
                                          color: Colors.redAccent,
                                        ),
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: CustomButtonWithchild(
                                          onPress: () {
                                            setState(() {
                                              loading = !loading;
                                            });
                                            _fblogin();
                                          },
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Icon(
                                                FontAwesomeIcons.facebookF,
                                                color: Colors.white,
                                              ),
                                            ],
                                          ),
                                          color: Colors.blueAccent,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
              ],
            ),
    );
  }
}
