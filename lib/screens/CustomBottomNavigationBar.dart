import 'package:DrHwaida/comingSoon.dart';
import 'package:DrHwaida/constants/constans.dart';
import 'package:DrHwaida/constants/themes.dart';
import 'package:DrHwaida/localization/localization_constants.dart';
import 'package:DrHwaida/models/user.dart';
import 'package:DrHwaida/models/visaCard.dart';
// import 'package:DrHwaida/screens/Hermonygame/hormonygame.dart';
import 'package:DrHwaida/screens/userProfile/userprofile.dart';
import 'package:DrHwaida/screens/wrapper/home/home.dart';
import 'package:flutter/material.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  @override
  _CustomBottomNavigationBarState createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      color: Colors.transparent,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: 50,
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: Stack(
                children: [
                  Align(
                    alignment: (User.appLang == 'ar_EG')
                        ? Alignment.centerLeft
                        : Alignment.centerRight,
                    child: InkWell(
                      onTap: () {
                        if (User.userSkipLogIn != true) {
                          setState(() {
                            Helper.tappedBottomShet = 1;
                          });

                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => UserProfile(
                                userName: (User.userName) ?? 'Tessting',
                                userimgUrl: 'lib/images/man.png',
                              ),
                            ),
                          );
                        } else {
                          showMyDialog(context: context);
                        }
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.person,
                            color: (Helper.tappedBottomShet == 1)
                                ? customColor
                                : customColor.withOpacity(.5),
                          ),
                          Text(
                            getTranslated(context, 'profile'),
                            style: AppTheme.heading.copyWith(
                              color: (Helper.tappedBottomShet == 1)
                                  ? customColor
                                  : customColor.withOpacity(.5),
                              fontSize: 10,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Align(
                    alignment: (User.appLang == 'ar_EG')
                        ? Alignment.centerRight
                        : Alignment.centerLeft,
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          Helper.tappedBottomShet = 0;
                        });
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => Home(),
                          ),
                        );
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.home,
                            color: (Helper.tappedBottomShet == 0)
                                ? customColor
                                : customColor.withOpacity(.5),
                          ),
                          Text(
                            getTranslated(context, 'home_page'),
                            style: AppTheme.heading.copyWith(
                              color: (Helper.tappedBottomShet == 0)
                                  ? customColor
                                  : customColor.withOpacity(.5),
                              fontSize: 10,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 20,
            child: InkWell(
              onTap: () {
                setState(() {
                  Helper.tappedBottomShet = 2;
                });
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => ComingSoon(),
                  ),
                );
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: (Helper.tappedBottomShet == 2)
                            ? customColor
                            : customColor.withOpacity(.5),
                        width: 2,
                      ),
                      color: Colors.white,
                      image: DecorationImage(
                        image: AssetImage('lib/images/logowhite.png'),
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Text(
                      getTranslated(context, 'harmony'),
                      style: AppTheme.heading.copyWith(
                        color: (Helper.tappedBottomShet == 2)
                            ? customColor
                            : customColor.withOpacity(.5),
                        fontSize: 10,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
