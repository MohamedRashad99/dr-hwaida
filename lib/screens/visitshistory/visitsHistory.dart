import 'package:DrHwaida/constants/constans.dart';
import 'package:DrHwaida/localization/localization_constants.dart';
import 'package:DrHwaida/screens/CustomBottomNavigationBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'components/gitAllvisits.dart';

class VisitsHistory extends StatefulWidget {
  @override
  _VisitsHistoryState createState() => _VisitsHistoryState();
}

class _VisitsHistoryState extends State<VisitsHistory> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: customAppBar(title: getTranslated(context, "Visits_History")),
      bottomNavigationBar: CustomBottomNavigationBar(),
      body: ListView(
        shrinkWrap: true,
        primary: true,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        children: [
          // Text(
          //   getTranslated(context, "consultants"),
          //   style: AppTheme.heading.copyWith(
          //     color: customColor,
          //     fontSize: 14,
          //   ),
          // ),
          // Divider(
          //   color: customColorDivider,
          //   thickness: 2,
          // ),
          SizedBox(height: 20),
          GitAllVisist(),
        ],
      ),
    );
  }
}
