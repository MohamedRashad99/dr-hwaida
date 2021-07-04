import 'package:DrHwaida/screens/wrapper/authenticate/signUp/register/register.dart';
import 'package:DrHwaida/screens/wrapper/authenticate/signUp/singUpUserInfo/sginUpUserInfo.dart';
import 'package:flutter/material.dart';

//create class SginUp
class SginUp extends StatefulWidget {
  final Function toggleView;
  SginUp({this.toggleView});
  @override
  _SginUpState createState() => _SginUpState();
}

class _SginUpState extends State<SginUp> {
  bool showNextSignUp = true;
  void toggleViewSginUp() {
    setState(() => showNextSignUp = !showNextSignUp);
  }

  @override
  Widget build(BuildContext context) {
    if (showNextSignUp) {
      return Container(
        child: SginUpUserInfo(
          toggleView: widget.toggleView,
          toggleViewSignUp: toggleViewSginUp,
        ),
      );
    } else {
      return Container(
        child: Register(
          toggleViewSignUp: toggleViewSginUp,
        ),
      );
    }
  }
}
