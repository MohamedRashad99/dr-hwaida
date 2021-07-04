import 'package:DrHwaida/constants/constans.dart';
import 'package:DrHwaida/constants/themes.dart';
import 'package:DrHwaida/localization/localization_constants.dart';
import 'package:flutter/material.dart';
import 'package:DrHwaida/models/utils.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RegisterAsConsultant extends StatefulWidget {
  @override
  _RegisterAsConsultantState createState() => _RegisterAsConsultantState();
}

class _RegisterAsConsultantState extends State<RegisterAsConsultant> {
  String error = '';
  String bio;
  String name;
  String phone;
  String address;
  String email;
  bool loading = false;
  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      key: _scaffoldKey,
      body: (loading)
          ? Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            )
          : ListView(
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              children: [
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        validator: (val) => val.isEmpty
                            ? getTranslated(context, "valid_name")
                            : null,
                        decoration: conectedTextFormStyle(
                          lableText: getTranslated(context, "name"),
                        ),
                        onChanged: (val) {
                          setState(
                            () {
                              name = val;
                            },
                          );
                        },
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        validator: (val) => val.isEmpty
                            ? getTranslated(context, "valid_email")
                            : null,
                        keyboardType: TextInputType.emailAddress,
                        decoration: conectedTextFormStyle(
                          lableText: getTranslated(context, "email"),
                        ),
                        onChanged: (val) {
                          setState(
                            () {
                              email = val;
                            },
                          );
                        },
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        validator: (val) => val.isEmpty
                            ? getTranslated(context, "valid_email_phone")
                            : null,
                        keyboardType: TextInputType.number,
                        decoration: conectedTextFormStyle(
                          lableText: getTranslated(context, "phone_num"),
                        ),
                        onChanged: (val) {
                          setState(
                            () {
                              phone = val;
                            },
                          );
                        },
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        validator: (val) => val.isEmpty
                            ? getTranslated(context, "valid_address")
                            : null,
                        decoration: conectedTextFormStyle(
                          lableText: getTranslated(context, "address"),
                        ),
                        onChanged: (val) {
                          setState(
                            () {
                              address = val;
                            },
                          );
                        },
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        validator: (val) => val.isEmpty
                            ? getTranslated(context, "valid_bio")
                            : null,
                        maxLines: null,
                        decoration: conectedTextFormStyle(
                          lableText: getTranslated(context, "bio"),
                        ),
                        onChanged: (val) {
                          setState(
                            () {
                              bio = val;
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
                Text(
                  error,
                  style: AppTheme.heading.copyWith(),
                ),
                CustomButtonWithchild(
                  color: customColor,
                  onPress: () {
                    setState(() {
                      loading = !loading;
                    });
                    // sentDateOfRegister(
                    //   address: address,
                    //   email: email,
                    //   name: name,
                    //   bio: bio,
                    //   phone: phone,
                    // );
                    if (_formKey.currentState.validate()) {
                      sentDateOfRegister(
                        address: address,
                        email: email,
                        name: name,
                        bio: bio,
                        phone: phone,
                      );
                    } else {
                      setState(() {
                        loading = !loading;
                      });
                    }
                  },
                  child: Center(
                    child: Text(
                      getTranslated(context, "Register"),
                      style: AppTheme.heading.copyWith(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }

  sentDateOfRegister({
    String name,
    String phone,
    String email,
    String bio,
    String address,
  }) async {
    var body = {
      'name': name,
      'email': email,
      'phone': phone,
      'address': address,
      'bio': bio,
    };
    try {
      var response = await http.post(
        Uri.parse(Utils.REGISTERASCONSUL_URL),
        body: {
          'name': name,
          'email': email,
          'phone': phone,
          'address': address,
          'bio': bio,
        },
        headers: {
          'Accept': "application/json",
          'lang': apiLang(),
        },
      );
      Map<String, dynamic> map = json.decode(response.body);
      if (map["success"] == true) {
        print('doneeeeeeeee');
        setState(() {
          loading = !loading;
        });
        // ignore: deprecated_member_use
        _scaffoldKey.currentState.showSnackBar(
          new SnackBar(
            content: new Text(
              'We\'ve received your and we\'re starting our review.',
            ),
          ),
        );
      } else {
        setState(
          () {
            loading = !loading;
            error = 'your request was failed please try later';
          },
        );
      }
    } catch (e) {
      setState(() {
        loading = !loading;
        error = 'your request was failed please try later';
      });
      print('catch error:' + e.toString());
      print(body);
    }
  }
}
