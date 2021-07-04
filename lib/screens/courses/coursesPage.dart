import 'package:DrHwaida/constants/themes.dart';
import 'package:DrHwaida/localization/localization_constants.dart';
import 'package:DrHwaida/models/coursesApi.dart';
import 'package:DrHwaida/screens/CustomBottomNavigationBar.dart';
import 'package:DrHwaida/screens/courses/coursesDetails.dart';
import 'package:DrHwaida/screens/wrapper/home/components/homeFunctions.dart';
import 'package:DrHwaida/services/network_sensitive.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'components/coursesPageAppber.dart';

class CoursesPage extends StatefulWidget {
  final String title;
  static String fillter;

  const CoursesPage({Key key, this.title}) : super(key: key);
  @override
  _CoursesPageState createState() => _CoursesPageState();
}

class _CoursesPageState extends State<CoursesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NetworkSensitive(
        child: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height - 140,
              child: ListView(
                shrinkWrap: true,
                primary: true,
                children: [
                  consultantAppBer(
                    context,
                  ),
                  coursesgraidView(),
                  SizedBox(height: 20),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: CustomBottomNavigationBar(),
            ),
          ],
        ),
      ),
    );
  }

  coursesgraidView() {
    return FutureBuilder(
      future: FiltterCoursesApi.fetchAllCourses(type: CoursesPage.fillter),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return (snapshot.data == null || snapshot.data.isEmpty)
              ? Container(
                  child: Center(
                    child: Text(
                      getTranslated(context, 'networkError'),
                      style: AppTheme.heading,
                      textAlign: TextAlign.center,
                    ),
                  ),
                )
              : GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 5,
                  padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                  primary: false,
                  childAspectRatio: .8,
                  shrinkWrap: true,
                  children: List.generate(
                    snapshot.data.length,
                    (index) {
                      return homeCoursesCard(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => CoursesDetails(
                                courses: snapshot.data[index],
                              ),
                            ),
                          );
                        },
                        courses: snapshot.data[index],
                        context: context,
                        isMycours: false,
                      );
                    },
                  ),
                );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
