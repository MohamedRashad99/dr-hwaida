import 'package:DrHwaida/constants/constans.dart';
import 'package:DrHwaida/models/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'components/menuAppBer.dart';
import 'components/menubody.dart';

class Menu extends StatefulWidget {
  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  String userName = 'Naden Droz';
  String userImgUrl = 'lib/images/female.png';
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: customColor,
        toolbarHeight: 0,
      ),
      body: Column(
        children: [
          (User.userSkipLogIn != false)
              ? Container()
              : MenuAppBer(
                  width: width,
                  userImageurl: userImgUrl,
                  userName: userName,
                ),
          (User.userSkipLogIn != false)
              ? Container()
              : Divider(
                  color: Colors.grey[300],
                  thickness: 2,
                ),
          MenuBody(
            height: height,
            userImUrl: userImgUrl,
            userName: userName,
          ),
        ],
      ),
    );
  }
}
