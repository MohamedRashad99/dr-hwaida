import 'package:DrHwaida/constants/constans.dart';
import 'package:DrHwaida/constants/themes.dart';
import 'package:DrHwaida/screens/Hermonygame/hormonyQpage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class PlayingWait extends StatefulWidget {
  @override
  _PlayingWaitState createState() => _PlayingWaitState();
}

class _PlayingWaitState extends State<PlayingWait> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: SpinKitPumpingHeart(
                duration: const Duration(milliseconds: 500),
                color: Colors.red,
                size: 100,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Wait your Partner',
              style: AppTheme.heading.copyWith(),
            ),
            SizedBox(
              height: 80,
            ),
            CustomButtonWithchild(
              child: Text(
                'Playing Now',
                style: AppTheme.heading.copyWith(
                  color: Colors.white,
                ),
              ),
              color: customColor,
              onPress: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => GameQPageView(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
