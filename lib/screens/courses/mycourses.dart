import 'package:DrHwaida/constants/themes.dart';
import 'package:DrHwaida/localization/localization_constants.dart';
import 'package:DrHwaida/models/coursesApi.dart';
import 'package:DrHwaida/screens/courses/mycoursesdetails.dart';
import 'package:DrHwaida/screens/wrapper/home/components/homeFunctions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../CustomBottomNavigationBar.dart';

class MyCourses extends StatefulWidget {
  @override
  _MyCoursesState createState() => _MyCoursesState();
}

class _MyCoursesState extends State<MyCourses> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height - 140,
            child: ListView(
              shrinkWrap: true,
              primary: true,
              children: [
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
    );
  }

  coursesgraidView() {
    return FutureBuilder(
      future: CoursesApi.fetchMYCourses(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return (snapshot.data == null && snapshot.data.isEmpty)
              ? Container(
                  child: Center(
                    child: Text(
                      getTranslated(context, "myCouresIsempaty"),
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
                  childAspectRatio: 1.2,
                  shrinkWrap: true,
                  children: List.generate(
                    snapshot.data.length,
                    (index) {
                      return homeCoursesCard(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => MyCoursesDetails(
                                courses: snapshot.data[index],
                              ),
                            ),
                          );
                        },
                        courses: snapshot.data[index],
                        context: context,
                        isMycours: true,
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
