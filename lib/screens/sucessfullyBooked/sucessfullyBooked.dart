import 'package:DrHwaida/constants/constans.dart';
import 'package:DrHwaida/constants/themes.dart';
import 'package:DrHwaida/localization/localization_constants.dart';
import 'package:DrHwaida/screens/wrapper/home/home.dart';
import 'package:flutter/material.dart';

class SucessfullyBooked extends StatefulWidget {
  @override
  _SucessfullyBookedState createState() => _SucessfullyBookedState();
}

class _SucessfullyBookedState extends State<SucessfullyBooked> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Container(
              height: 150,
              width: 150,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey[300],
              ),
              child: Center(
                child: Container(
                  height: 50,
                  width: 50,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: customColor,
                  ),
                  child: Center(
                    child: Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 10),
          Text(
            getTranslated(context, "Sucessfully"),
            style: AppTheme.heading,
          ),
          Text(
            getTranslated(context, "Sucessfully_book_mess"),
            style: AppTheme.subHeading,
          ),
          Text(
            getTranslated(context, "doc_confirm"),
            style: AppTheme.subHeading,
          ),
          SizedBox(height: 10),
          CustomButton(
            text: getTranslated(context, "home_page"),
            onPress: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (_) => Home(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
