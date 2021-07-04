import 'package:DrHwaida/constants/constans.dart';
// import 'package:DrHwaida/constants/themes.dart';
import 'package:DrHwaida/localization/localization_constants.dart';
import 'package:flutter/material.dart';
// import 'components/NotificationsContant.dart';

class Notificatios extends StatefulWidget {
  @override
  _NotificatiosState createState() => _NotificatiosState();
}

class _NotificatiosState extends State<Notificatios> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(title: getTranslated(context, "notifications")),
      body: ListView(
        shrinkWrap: true,
        primary: true,
        padding: EdgeInsets.only(
          top: 40,
          right: 8,
          left: 8,
        ),
        children: [
          Center(
            child: Icon(
              Icons.notifications_active,
              color: customColor,
              size: 100,
            ),
          ),
          // Text(
          //   'Today',
          //   style: AppTheme.heading.copyWith(
          //     color: Colors.grey[500],
          //     fontSize: 20,
          //     fontWeight: FontWeight.w900,
          //   ),
          // ),
          // SizedBox(height: 10),
          // ListView.builder(
          //   shrinkWrap: true,
          //   primary: false,
          //   itemCount: 1,
          //   itemBuilder: (context, index) {
          //     return Column(
          //       mainAxisAlignment: MainAxisAlignment.center,
          //       crossAxisAlignment: CrossAxisAlignment.center,
          //       children: [

          //         // NotificationsContant(
          //         //   title: title,
          //         //   contant: contant,
          //         //   date: date,
          //         //   onTap: () {},
          //         // ),
          //         // Divider(
          //         //   color: customColorDivider,
          //         //   thickness: 1,
          //         // ),
          //       ],
          //     );
          //   },
          // ),
        ],
      ),
    );
  }
}
