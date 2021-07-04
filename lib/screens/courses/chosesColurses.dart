import 'package:DrHwaida/constants/constans.dart';
import 'package:DrHwaida/constants/themes.dart';
import 'package:DrHwaida/localization/localization_constants.dart';
import 'package:DrHwaida/models/categories.dart';
import 'package:DrHwaida/models/coursesApi.dart';
import 'package:DrHwaida/screens/CustomBottomNavigationBar.dart';
import 'package:DrHwaida/screens/courses/categoriesCourse.dart';
import 'package:DrHwaida/screens/courses/coursesDetails.dart';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class ChosesCourses extends StatefulWidget {
  @override
  _ChosesCoursesState createState() => _ChosesCoursesState();
}

class _ChosesCoursesState extends State<ChosesCourses> {
  List<int> paners = [1, 2, 3, 4, 5, 6, 7];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          getTranslated(context, 'Courses'),
          style: AppTheme.heading.copyWith(
            color: Colors.white,
          ),
        ),
      ),
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height - 150,
            child: ListView(
              shrinkWrap: true,
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              children: [
                // coursesSilder(
                //   context: context,
                // ),
                FutureBuilder(
                  future: CoursesApi.fetchAllFeaturedCourses(),
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
                          : coursesSilder(
                              context: context, list: snapshot.data);
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  },
                ),

                SizedBox(height: 10),
                FutureBuilder(
                  future: CategoriesApi.fetchAllCategories(),
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
                          : Container(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: GridView.count(
                                crossAxisCount: 2,
                                crossAxisSpacing: 5,
                                mainAxisSpacing: 5,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 5, vertical: 10),
                                primary: false,
                                childAspectRatio: .9,
                                shrinkWrap: true,
                                children: List.generate(
                                  snapshot.data.length,
                                  (index) {
                                    return Padding(
                                      padding: const EdgeInsets.all(0.0),
                                      child: InkWell(
                                        onTap: () {
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (_) => CategoriesCourse(
                                                cateId: snapshot.data[index].id,
                                              ),
                                            ),
                                          );
                                        },
                                        child: Card(
                                          elevation: 0,
                                          shape: RoundedRectangleBorder(
                                            side: BorderSide(
                                              color:
                                                  customColor.withOpacity(.3),
                                            ),
                                          ),
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 10, vertical: 10),
                                            child: Column(
                                              children: [
                                                Container(
                                                  height: 100,
                                                  child:
                                                      customCachedNetworkImage(
                                                    context: context,
                                                    url: snapshot
                                                        .data[index].image_path,
                                                  ),
                                                ),
                                                Container(
                                                  child: Center(
                                                    child: Text(
                                                      snapshot.data[index].name,
                                                      style: AppTheme.heading
                                                          .copyWith(
                                                        color: customColor,
                                                        fontSize: 10,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            );
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  },
                ),
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

  InkWell statusConrainer({Function onTap, String imgUrl, String title}) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            height: 120,
            width: 120,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(imgUrl),
              ),
            ),
          ),
          Text(
            title,
            style: AppTheme.heading.copyWith(
              color: customColor,
            ),
          )
        ],
      ),
    );
  }

  Container coursesSilder({
    BuildContext context,
    List list,
  }) {
    return Container(
      child: Column(
        children: <Widget>[
          CarouselSlider(
            options: CarouselOptions(
              autoPlayInterval: Duration(seconds: 2),
              autoPlay: true,
              // reverse: widget.reverse,
              aspectRatio: 2.0,
              enlargeCenterPage: true,
              enlargeStrategy: CenterPageEnlargeStrategy.scale,
            ),
            items: list
                .map(
                  (items) => GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => CoursesDetails(
                            courses: items,
                          ),
                        ),
                      );
                    },
                    child: Container(
                      child: Container(
                        margin: EdgeInsets.all(5.0),
                        child: ClipRRect(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0)),
                            child: Stack(
                              children: <Widget>[
                                ClipRRect(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20.0)),
                                  child: Container(
                                    width: 300,
                                    height: 140,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(20.0),
                                      ),
                                      // image: DecorationImage(
                                      //   image:
                                      //       AssetImage('lib/images/event.jpg'),
                                      //   fit: BoxFit.cover,
                                      // ),
                                    ),
                                    child: customCachedNetworkImage(
                                      context: context,
                                      url: items.courseImageUrl,
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 300,
                                  height: 140,
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20.0)),
                                  ),
                                  child: Container(
                                    height: 100,
                                    width: MediaQuery.of(context).size.width,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(20.0),
                                        bottomRight: Radius.circular(20.0),
                                      ),
                                      gradient: LinearGradient(
                                        colors: [
                                          Color.fromARGB(200, 0, 0, 0),
                                          Color.fromARGB(0, 0, 0, 0)
                                        ],
                                        begin: Alignment.bottomCenter,
                                        end: Alignment.topCenter,
                                      ),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        SizedBox(height: 40),
                                        Text(
                                          items.title,
                                          style: TextStyle(
                                            color: Colors.deepOrangeAccent,
                                            fontSize: 25,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            )),
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}
