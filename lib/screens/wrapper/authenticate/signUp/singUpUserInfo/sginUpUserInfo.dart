import 'package:DrHwaida/constants/constans.dart';
import 'package:DrHwaida/constants/themes.dart';
import 'package:DrHwaida/localization/localization_constants.dart';
import 'package:DrHwaida/screens/wrapper/authenticate/signUp/singUpUserInfo/components/gender.dart';
import 'package:DrHwaida/screens/wrapper/authenticate/signUp/singUpUserInfo/components/status.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'components/age.dart';

class SginUpUserInfo extends StatefulWidget {
  final Function toggleViewSignUp;
  final Function toggleView;
  static String name;

  SginUpUserInfo({this.toggleViewSignUp, this.toggleView});
  @override
  _SginUpUserInfoState createState() => _SginUpUserInfoState();
}

class _SginUpUserInfoState extends State<SginUpUserInfo> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  String error = '';

  @override
  Widget build(BuildContext context) {
    // double width = MediaQuery.of(context).size.width;
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: customColor,
        toolbarHeight: 0,
      ),
      body: Stack(
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
          Padding(
            padding: const EdgeInsets.only(top: 200, left: 30, right: 30),
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
                        Card(
                          elevation: 2.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: TextFormField(
                            style: TextStyle(color: Colors.black),
                            validator: (val) => val.isEmpty
                                ? getTranslated(context, "valid_name")
                                : null,
                            onChanged: (val) {
                              setState(() {
                                SginUpUserInfo.name = val;
                              });
                            },
                            decoration: textFormInputDecoration(
                              Icons.person,
                              getTranslated(context, "name"),
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        Age(),
                        SizedBox(height: 10),
                        Gender(),
                        SizedBox(height: 10),
                        Status(),
                        SizedBox(height: 10),
                        CustomButton(
                          onPress: () {
                            if (Age.resAge != null &&
                                Status.resStautes != null &&
                                Gender.resGender != null) {
                              if (_formKey.currentState.validate()) {
                                widget.toggleViewSignUp();
                              }
                            } else {
                              // ignore: deprecated_member_use
                              _scaffoldKey.currentState.showSnackBar(
                                new SnackBar(
                                  content: new Text(
                                    getTranslated(context, "valid_data"),
                                  ),
                                ),
                              );
                            }
                          },
                          text: getTranslated(context, "next_one"),
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              getTranslated(context, "have_account"),
                              style: AppTheme.heading.copyWith(),
                            ),
                            InkWell(
                              onTap: () => widget.toggleView(),
                              child: Text(
                                getTranslated(context, "Entry"),
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
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
