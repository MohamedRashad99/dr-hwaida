import 'package:DrHwaida/constants/themes.dart';
import 'package:DrHwaida/localization/localization_constants.dart';
import 'package:DrHwaida/models/coursesApi.dart';
import 'package:DrHwaida/screens/CustomBottomNavigationBar.dart';
import 'package:DrHwaida/screens/courses/coursesDetails.dart';
import 'package:DrHwaida/screens/wrapper/home/components/homeFunctions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CategoriesCourse extends StatefulWidget {
  final int cateId;

  const CategoriesCourse({Key key, @required this.cateId}) : super(key: key);
  @override
  _CategoriesCourseState createState() => _CategoriesCourseState();
}

class _CategoriesCourseState extends State<CategoriesCourse> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height - 60,
            child: ListView(
              shrinkWrap: true,
              primary: true,
              children: [
                // consultantAppBer(
                //   context,
                // ),
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
      future: CoursesApi.fetchAllCategoriesCourses(widget.cateId),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return (snapshot.data == null || snapshot.data.isEpmty)
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
