import 'package:DrHwaida/constants/constans.dart';
import 'package:DrHwaida/constants/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Result extends StatefulWidget {
  @override
  _ResultState createState() => _ResultState();
}

class _ResultState extends State<Result> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        shrinkWrap: true,
        primary: true,
        children: [
          Container(
            height: 150,
            width: 150,
            child: SvgPicture.asset(
              'assets/icons/result.svg',
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '60%',
                style: AppTheme.heading.copyWith(
                  color: customColor,
                  fontSize: 80,
                ),
              ),
              SizedBox(height: 10),
              Text(
                '13 matched of 20',
                style: AppTheme.heading.copyWith(),
              ),
              SizedBox(height: 10),
              Container(
                height: 150,
                width: 300,
                padding: EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                decoration: BoxDecoration(
                    border: Border.all(
                  color: customColorDivider,
                  width: 2,
                )),
                child: Center(
                  child: Text(
                    'your partner love your but you should hear him.  ',
                    style: AppTheme.heading.copyWith(),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Thank for you!',
                style: AppTheme.heading.copyWith(
                  color: customColor,
                  fontSize: 25,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
