import 'package:DrHwaida/constants/constans.dart';
import 'package:DrHwaida/constants/themes.dart';
import 'package:DrHwaida/localization/localization_constants.dart';
import 'package:DrHwaida/screens/courses/coursesPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../sharedPreferences.dart';

class CoursesFillter extends StatefulWidget {
  static int filtterTapped;

  final String title;

  const CoursesFillter({Key key, this.title}) : super(key: key);
  @override
  _CoursesFillterState createState() => _CoursesFillterState();
}

class _CoursesFillterState extends State<CoursesFillter> {
  List<String> fillterApi = [
    'latest',
    'price-high-to-low',
    'price-low-to-high',
  ];
  int filtterTapped;
  @override
  Widget build(BuildContext context) {
    List<String> fillterList = [
      getTranslated(context, "Recent"),
      getTranslated(context, "priceLow"),
      getTranslated(context, "priceHigh"),
    ];
    return ListView(
      shrinkWrap: true,
      primary: true,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Transform.rotate(
              angle: 180 * 3.14 / 365,
              child: SvgPicture.asset(
                "assets/icons/filter.svg",
                color: customColor,
                height: 25,
              ),
            ),
          ],
        ),
        SizedBox(height: 40),
        ListView.builder(
          itemCount: fillterList.length,
          shrinkWrap: true,
          primary: false,
          itemBuilder: (context, index) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () {
                    setState(() {
                      CoursesFillter.filtterTapped = index;
                      CoursesPage.fillter = fillterApi[index];
                      MySharedPreferences.saveCoursesFilltterIndex(index);
                      MySharedPreferences.saveCoursesFilltterType(
                          fillterApi[index]);
                    });
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                        builder: (_) => CoursesPage(),
                      ),
                      ModalRoute.withName('/'),
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        fillterList[index],
                        style: AppTheme.heading.copyWith(
                          color: (CoursesFillter.filtterTapped == index)
                              ? Colors.black
                              : Colors.grey[500],
                        ),
                      ),
                      Container(
                        height: 20,
                        width: 20,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: (CoursesFillter.filtterTapped == index)
                              ? customColor
                              : Colors.transparent,
                        ),
                        child: Center(
                          child: Icon(
                            FontAwesomeIcons.check,
                            color: (CoursesFillter.filtterTapped == index)
                                ? Colors.white
                                : Colors.transparent,
                            size: 10,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(
                  color: customColorDivider,
                  thickness: 2,
                ),
                SizedBox(height: 10),
              ],
            );
          },
        ),
      ],
    );
  }
}
