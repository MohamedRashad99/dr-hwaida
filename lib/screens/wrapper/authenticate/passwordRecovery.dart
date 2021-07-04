import 'package:DrHwaida/constants/constans.dart';
import 'package:DrHwaida/constants/themes.dart';
import 'package:DrHwaida/localization/localization_constants.dart';
import 'package:DrHwaida/screens/wrapper/authenticate/verfyPassword.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PasswordRecovery extends StatefulWidget {
  @override
  _PasswordRecoveryState createState() => _PasswordRecoveryState();
}

class _PasswordRecoveryState extends State<PasswordRecovery> {
  final _formKey = GlobalKey<FormState>();
  bool verification = true;
  bool changePass = false;
  String phone;
  String verificationCode;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: customColor,
        toolbarHeight: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Stack(
            children: [
              CustomAppBar(
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 100,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('lib/images/logo.png'),
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 220, left: 30, right: 30),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        getTranslated(context, "password_recovery"),
                        style: AppTheme.heading.copyWith(
                          fontSize: 25,
                          color: customColor,
                        ),
                      ),
                      Text(
                        getTranslated(context, "valid_email_phone"),
                        style: AppTheme.subHeading.copyWith(),
                      ),
                      SizedBox(height: 40),
                      TextFormField(
                        onChanged: (val) {
                          setState(() {
                            phone = val;
                          });
                        },
                        keyboardType: TextInputType.phone,
                        style: TextStyle(color: Colors.black),
                        validator: (val) => val.isEmpty
                            ? getTranslated(context, "valid_email_phone")
                            : null,
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          labelText: getTranslated(context, "phone_num"),
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
                        ),
                      ),
                      SizedBox(height: 20),
                      CustomButton(
                        text: getTranslated(context, "send"),
                        onPress: () {
                          _verifyPhone();
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => VerifyPhone(
                                phone: phone,
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _verifyPhone() async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      codeAutoRetrievalTimeout: (String verificationId) {
        setState(() {
          verificationCode = verificationId;
        });
        print('verificationId:$verificationId');
      },
      codeSent: (String verificationId, [int forceResendingToken]) {
        setState(() {
          verificationCode = verificationId;
        });
        print('verificationId:$verificationId');
      },
      timeout: Duration(seconds: 60),
      phoneNumber: '+2' + phone,
      verificationCompleted: (phoneAuthCredential) {
        print(verificationCode);
      },
      verificationFailed: (error) {
        print(error);
      },
    );
  }
}
