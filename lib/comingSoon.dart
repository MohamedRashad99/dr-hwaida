import 'package:DrHwaida/constants/constans.dart';
import 'package:DrHwaida/screens/CustomBottomNavigationBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'constants/themes.dart';
import 'models/visaCard.dart';

class ComingSoon extends StatefulWidget {
  @override
  _ComingSoonState createState() => _ComingSoonState();
}

class _ComingSoonState extends State<ComingSoon> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
                ],
              ),
            ),
          ),
          Positioned(
            top: 200,
            left: 100,
            right: 100,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 200,
                  width: 200,
                  child: SvgPicture.asset(
                    'assets/icons/comingsoon.svg',
                  ),
                ),
                Text(
                  'Coming Soon.......',
                  style: AppTheme.heading.copyWith(
                    color: customColor,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment:
                (apiLang() == "ar") ? Alignment.topRight : Alignment.topLeft,
            child: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                setState(() {
                  Helper.tappedBottomShet = 0;
                });
                Navigator.of(context).pop();
              },
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: CustomBottomNavigationBar(),
          ),
        ],
      ),
    );
  }

  Container newMethod(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
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
                    ],
                  ),
                ),
              ),
              Container(
                height: 200,
                width: 200,
                child: SvgPicture.asset(
                  'assets/icons/comingsoon.svg',
                ),
              ),
              Text(
                'Coming Soon.......',
                style: AppTheme.heading.copyWith(
                  color: customColor,
                  fontSize: 20,
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment.topLeft,
            child: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                setState(() {
                  Helper.tappedBottomShet = 0;
                });
                Navigator.of(context).pop();
              },
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: CustomBottomNavigationBar(),
          ),
        ],
      ),
    );
  }
}
