import 'package:DrHwaida/constants/constans.dart';
import 'package:DrHwaida/constants/themes.dart';
import 'package:DrHwaida/localization/localization_constants.dart';
import 'package:DrHwaida/screens/wrapper/authenticate/chagePassword.dart';
// import 'package:DrHwaida/screens/wrapper/authenticate/chagePassword.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:code_fields/code_fields.dart';

class VerifyPhone extends StatefulWidget {
  final String phone;

  const VerifyPhone({Key key, this.phone}) : super(key: key);
  @override
  _VerifyPhoneState createState() => _VerifyPhoneState();
}

class _VerifyPhoneState extends State<VerifyPhone> {
  final _formKey = GlobalKey<FormState>();
  final int codeLength = 6;
  String verificationCode;
  String validateCode(String code) {
    if (code.length < codeLength)
      return "من فضلك اكمل الكود";
    else {
      bool isNumeric = int.tryParse(code) != null;
      if (!isNumeric) return "برجاء ادخال الكود المرسل";
    }
    return null;
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
      phoneNumber: '+2' + widget.phone,
      verificationCompleted: (phoneAuthCredential) {
        print(verificationCode);
      },
      verificationFailed: (error) {
        print(error);
      },
    );
  }

  @override
  void initState() {
    super.initState();
  }
  // void onButtonPressed() {
  //   if (_formKey.currentState.validate()) {
  //     _formKey.currentState.save();
  //     Navigator.of(context).push(
  //       MaterialPageRoute(
  //         builder: (_) => ChagePassrowd(),
  //       ),
  //     );
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: customColor,
        toolbarHeight: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        getTranslated(context, "enter_code"),
                        style: AppTheme.heading.copyWith(
                          color: customColor,
                          fontSize: 20,
                        ),
                      ),
                      Text(
                        getTranslated(context, "sent_code_to") + widget.phone,
                        style: AppTheme.subHeading.copyWith(),
                      ),
                      SizedBox(height: 40),
                      Center(
                        child: CodeFields(
                          length: codeLength,
                          validator: validateCode,
                          textStyle: TextStyle(color: Colors.white),
                          autofocus: true,
                          inputDecoration: InputDecoration(
                            filled: true,
                            fillColor: customColor,
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(24.0),
                              borderSide: BorderSide(
                                style: BorderStyle.solid,
                                color: customColor,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(24.0),
                              borderSide: BorderSide(color: Colors.transparent),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(24.0),
                              borderSide: BorderSide(color: customColor),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            getTranslated(context, "not_send"),
                            style: AppTheme.heading.copyWith(
                              color: Colors.white,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              _verifyPhone();
                            },
                            child: Text(
                              getTranslated(context, "resend"),
                              style: AppTheme.heading.copyWith(
                                color: customColor,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      CustomButton(
                        text: getTranslated(context, "send"),
                        onPress: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => ChagePassrowd(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
