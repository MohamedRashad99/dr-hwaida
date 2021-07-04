import 'package:DrHwaida/constants/themes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NotificationsContant extends StatelessWidget {
  const NotificationsContant({
    Key key,
    @required this.title,
    @required this.contant,
    @required this.date,
    @required this.onTap,
  }) : super(key: key);

  final String title;
  final String contant;
  final String date;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 120,
        width: MediaQuery.of(context).size.width,
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(
          horizontal: 10,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 60,
              width: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                gradient: AppTheme.containerBackground,
              ),
              child: Center(
                child: Icon(
                  Icons.notifications,
                  size: 30,
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTheme.heading,
                ),
                SizedBox(height: 10),
                SizedBox(
                  width: 200,
                  child: Text(
                    contant,
                    style: AppTheme.subHeading.copyWith(
                      fontSize: 10,
                      color: Colors.grey[500],
                    ),
                  ),
                ),
              ],
            ),
            Text(
              date,
              style: AppTheme.subHeading.copyWith(
                color: Colors.grey[500],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
