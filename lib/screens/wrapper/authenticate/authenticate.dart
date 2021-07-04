import 'package:DrHwaida/models/user.dart';
import 'package:DrHwaida/screens/wrapper/authenticate/login.dart';
import 'package:DrHwaida/screens/wrapper/authenticate/signUp/sign_up.dart';
import 'package:DrHwaida/screens/wrapper/home/home.dart';
import 'package:DrHwaida/sharedPreferences.dart';

import 'package:flutter/material.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showSignIn = true;
  void toggleView() {
    setState(() => showSignIn = !showSignIn);
  }

  getUserToke() async {
    User.userToken = await MySharedPreferences.getUserUserToken();
  }

  @override
  void initState() {
    getUserToke();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (User.userToken == null) {
      if (showSignIn) {
        return Container(
          child: LogIn(toggleView: toggleView),
        );
      } else {
        return Container(
          child: SginUp(toggleView: toggleView),
        );
      }
    } else {
      return Home();
    }
  }
}
