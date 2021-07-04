import 'package:DrHwaida/constants/constans.dart';
import 'package:DrHwaida/constants/themes.dart';
import 'package:DrHwaida/localization/localization_constants.dart';
import 'package:DrHwaida/models/user.dart';
import 'package:DrHwaida/models/utils.dart';
import 'package:DrHwaida/screens/wrapper/authenticate/signUp/singUpUserInfo/components/age.dart';
import 'package:DrHwaida/screens/wrapper/authenticate/signUp/singUpUserInfo/components/gender.dart';
import 'package:DrHwaida/screens/wrapper/authenticate/signUp/singUpUserInfo/components/status.dart';
import 'package:DrHwaida/screens/wrapper/authenticate/signUp/singUpUserInfo/sginUpUserInfo.dart';
import 'package:DrHwaida/screens/wrapper/home/home.dart';
import 'dart:convert';
import 'package:DrHwaida/sharedPreferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Register extends StatefulWidget {
  final Function toggleViewSignUp;
  Register({this.toggleViewSignUp});
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();
  bool loading = false;
  String phoneNumber = '';
  String password = '';
  String confirmPassword = '';
  String name = '';
  String error = '';

  bool obscurePassword = true;
  bool obscureconPassword = true;

  registerWithPhoneAndPassword({
    String phoneNummber,
    String password,
    String age,
    String name,
    String gender,
    String status,
  }) async {
    var body = {
      'name': name,
      'mobile': phoneNummber,
      'password': password,
      'password_confirmation': password,
      'age': age,
      'gender': gender,
      'status': status,
    };
    try {
      var response = await http.post(
        Uri.parse(Utils.REGISTER_URL),
        body: {
          'name': name,
          'mobile': phoneNummber,
          'password': password,
          'password_confirmation': password,
          'age': age,
          'gender': gender,
          'status': status,
        },
        headers: {
          'lang': apiLang(),
        },
      );
      print('stuates Code:${response.statusCode}');
      print(body);

      Map<String, dynamic> map = json.decode(response.body);
      print('stuates Code:${response.statusCode}');
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
            print(map);
            error = map['message'];
            loading = false;
          });
        }
      });
      // Navigator.pop(context);
    } catch (e) {
      setState(() {
        // error = getTranslated(context, "register_error");
        loading = false;
      });
      print("erooooooooooooooooooooooooooooooooooooooooooooooooor");
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: customColor,
        toolbarHeight: 0,
      ),
      body: (loading)
          ? Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            )
          : Stack(
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
                          getTranslated(context, "Join_family"),
                          style: AppTheme.heading.copyWith(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        ),
                        SizedBox(height: 10),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: 20,
                  left: 0,
                  child: IconButton(
                    icon: Icon(
                      Icons.arrow_back,
                      // color: Colors.amber,
                    ),
                    onPressed: () {
                      setState(
                        () {
                          widget.toggleViewSignUp();
                        },
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 220, left: 30, right: 30),
                  child: Form(
                    key: _formKey,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(height: 15),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              TextFormField(
                                keyboardType: TextInputType.number,
                                style: TextStyle(color: Colors.black),
                                validator: (val) => val.isEmpty
                                    ? getTranslated(
                                        context, "valid_email_phone")
                                    : null,
                                onChanged: (val) {
                                  setState(() {
                                    phoneNumber = val;
                                  });
                                },
                                decoration: textFormInputDecoration(
                                  Icons.phone,
                                  getTranslated(context, "phone_num"),
                                ),
                              ),
                              SizedBox(height: 10),
                              TextFormField(
                                style: TextStyle(color: Colors.black),
                                decoration: textFormInputDecorationForPassword(
                                  Icons.visibility_off,
                                  getTranslated(context, "password"),
                                  () {
                                    setState(() {
                                      obscurePassword = !obscurePassword;
                                    });
                                  },
                                  obscurePassword,
                                ),
                                validator: (val) => validatePassord(val),
                                obscureText: obscurePassword,
                                onChanged: (val) {
                                  setState(() {
                                    password = val;
                                  });
                                },
                              ),
                              SizedBox(height: 10),
                              TextFormField(
                                style: TextStyle(color: Colors.black),
                                decoration: textFormInputDecorationForPassword(
                                  Icons.visibility_off,
                                  getTranslated(context, "Confirm_password"),
                                  () {
                                    setState(() {
                                      obscureconPassword = !obscureconPassword;
                                    });
                                  },
                                  obscureconPassword,
                                ),
                                validator: (val) => validateConfrimPassord(
                                  val,
                                  password,
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
                              Text(
                                error,
                                style: AppTheme.heading,
                              ),
                              SizedBox(height: 10),
                              CustomButton(
                                onPress: () async {
                                  if (_formKey.currentState.validate()) {
                                    setState(() {
                                      loading = true;
                                    });

                                    registerWithPhoneAndPassword(
                                      age: Age.resAge,
                                      name: SginUpUserInfo.name,
                                      status: Status.resStautes,
                                      gender: Gender.resGender,
                                      phoneNummber: phoneNumber,
                                      password: password,
                                    );
                                  }
                                },
                                text: getTranslated(context, "Sing_up"),
                              ),
                              SizedBox(height: 10),
                            ],
                          ),
                        ],
                      ),
                    ),
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
}
