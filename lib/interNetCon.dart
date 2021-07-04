import 'package:DrHwaida/constants/constans.dart';
import 'package:flutter/material.dart';

class EnterNitCON extends StatefulWidget {
  static final route = '/enternet';
  @override
  _EnterNitCONState createState() => _EnterNitCONState();
}

class _EnterNitCONState extends State<EnterNitCON> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: customColor,
      body: Center(
        child: Text('no enterNet '),
      ),
    );
  }
}
