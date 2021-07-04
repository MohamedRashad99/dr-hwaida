import 'package:DrHwaida/constants/constans.dart';
import 'package:DrHwaida/constants/themes.dart';
import 'package:DrHwaida/localization/localization_constants.dart';
import 'package:DrHwaida/models/consultant.dart';
import 'package:DrHwaida/models/consultantApi.dart';

import 'package:DrHwaida/models/courses.dart';
import 'package:DrHwaida/models/coursesApi.dart';
import 'package:DrHwaida/models/eventApi.dart';
import 'package:DrHwaida/screens/Consultant/consultant.dart';
import 'package:DrHwaida/screens/Evaents/eventsPageView.dart';
import 'package:DrHwaida/screens/Evaents/eventspage.dart';
import 'package:DrHwaida/screens/consultantPageView/consultantPageView.dart';
import 'package:DrHwaida/screens/courses/chosesColurses.dart';

import 'package:DrHwaida/screens/courses/coursesDetails.dart';
import 'package:DrHwaida/screens/courses/coursesPage.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

FutureBuilder<List<Consultant>> getConsultant() {
  return FutureBuilder(
    future: ConsultantApi.fetchAllConsultant(),
    builder: (context, snapshot) {
      if (snapshot.hasData) {
        return (snapshot.data == null || snapshot.data.isEmpty)
            ? Container()
            : Column(
                children: [
                  sctionTitle(
                      title: getTranslated(context, "consultants"),
                      context: context,
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => ConsultantPage(),
                          ),
                        );
                      }),
                  Container(
                    height: 200,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemCount: snapshot.data.length,
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      itemBuilder: (context, index) {
                        print(snapshot.data[index].badges);
                        return consulHomeCard(
                          context: context,
                          imageUrl: snapshot.data[index].image,
                          oldPrie: snapshot.data[index].coust,
                          newPrie: snapshot.data[index].total_coust,
                          consulName: snapshot.data[index].name,
                          discount: snapshot.data[index].discount,
                          rate: double.parse(
                            snapshot.data[index].rate,
                          ),
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => ConsultantPageView(
                                  consultant: snapshot.data[index],
                                  consulId: snapshot.data[index].id,
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              );
      } else {
        return Center(child: CircularProgressIndicator());
      }
    },
  );
}

///////////////////////////////////////////////////////////////////////////////////////
FutureBuilder<List<Courses>> getCourses() {
  return FutureBuilder(
    future: CoursesApi.fetchAllCourses(),
    builder: (context, snapshot) {
      if (snapshot.hasData) {
        return (snapshot.data == null || snapshot.data.isEmpty)
            ? Container()
            : Column(
                children: [
                  sctionTitle(
                    title: getTranslated(context, 'Courses'),
                    context: context,
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => CoursesPage(title: 'All Courses'),
                        ),
                      );
                    },
                  ),
                  Container(
                    height: 200,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemCount: snapshot.data.length,
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      itemBuilder: (context, index) {
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
                  ),
                ],
              );
      } else {
        return Center(child: CircularProgressIndicator());
      }
    },
  );
}

//////////////////////////////////////////////////////////////////////////////////////

Container rowofHmeTaps(BuildContext context) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
    height: 130,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: 1,
          child: homeTabs(
            title: getTranslated(context, "consultants"),
            iconImage: 'lib/images/consulantent.png',
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => ConsultantPage(),
                ),
              );
            },
          ),
        ),
        Expanded(
          flex: 1,
          child: homeTabs(
            title: getTranslated(context, "Courses"),
            iconImage: 'lib/images/courses.png',
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => ChosesCourses(),
                ),
              );
            },
          ),
        ),
        Expanded(
          flex: 1,
          child: homeTabs(
            title: getTranslated(context, "Events"),
            iconImage: 'lib/images/eventicons.png',
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => EventsPage(),
                ),
              );
            },
          ),
        ),
      ],
    ),
  );
}
///////////////////////////////////////////////////////////////////////////////////////

Container homeTabs({String title, String iconImage, Function onTap}) {
  return Container(
    width: 120,
    height: 100,
    // padding: EdgeInsets.symmetric(horizontal: 5),
    child: InkWell(
      onTap: onTap,
      child: Card(
        elevation: 3,
        child: Container(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 40,
                width: 60,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(iconImage),
                    fit: BoxFit.fitHeight,
                  ),
                ),
              ),
              SizedBox(height: 5),
              Text(
                title,
                style: AppTheme.subHeading,
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
///////////////////////////////////////////////////////////////////////////////////////

consulHomeCard({
  String imageUrl,
  String oldPrie,
  double newPrie,
  String consulName,
  double rate,
  String discount,
  Function onTap,
  BuildContext context,
}) {
  return InkWell(
    onTap: onTap,
    child: Container(
      width: 200,
      child: Card(
        elevation: 3,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              Container(
                child: Stack(
                  children: [
                    CircleAvatar(
                      maxRadius: 65,
                      // backgroundImage: NetworkImage(imageUrl),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Container(
                          height: MediaQuery.of(context).size.height,
                          decoration: BoxDecoration(shape: BoxShape.circle),
                          child: customCachedNetworkImage(
                            context: context,
                            url: imageUrl,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        height: 70,
                        width: 70,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: AppTheme.containerBackground,
                        ),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              (discount != '0')
                                  ? Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          oldPrie,
                                          style: AppTheme.subHeading.copyWith(
                                            color: customColorDivider,
                                            decoration:
                                                TextDecoration.lineThrough,
                                            fontSize: 12,
                                          ),
                                        ),
                                        Icon(
                                          FontAwesomeIcons.poundSign,
                                          color: Colors.white,
                                          size: 10,
                                        ),
                                      ],
                                    )
                                  : Container(),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    newPrie.toString(),
                                    style: AppTheme.heading.copyWith(
                                      color: Colors.white,
                                    ),
                                  ),
                                  Icon(
                                    FontAwesomeIcons.poundSign,
                                    color: Colors.white,
                                    size: 10,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: 15,
                child: Column(
                  children: [
                    Text(
                      consulName,
                      style: AppTheme.subHeading.copyWith(
                        color: customColor,
                      ),
                    ),
                    RatingStar(
                      isReadOnly: true,
                      rating: rate,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
///////////////////////////////////////////////////////////////////////////////////////

sctionTitle({String title, Function onTap, BuildContext context}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: AppTheme.heading.copyWith(
            color: customColor,
            fontSize: 16,
          ),
        ),
        InkWell(
          onTap: onTap,
          child: Text(
            getTranslated(context, "more"),
            style: AppTheme.subHeading,
          ),
        ),
      ],
    ),
  );
}
///////////////////////////////////////////////////////////////////////////////////////

paner(BuildContext context) {
  return FutureBuilder(
    future: EventsApi.fetchAllEvent(),
    builder: (context, snapshot) {
      if (snapshot.hasData) {
        List list = snapshot.data;
        return (snapshot.data == null || snapshot.data.isEmpty)
            ? Container()
            : Container(
                child: Column(
                  children: <Widget>[
                    CarouselSlider(
                      options: CarouselOptions(
                        autoPlayInterval: Duration(seconds: 2),
                        // autoPlay: true,
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
                                    builder: (_) => EventsPageView(
                                      events: items,
                                    ),
                                  ),
                                );
                              },
                              child: Container(
                                child: Container(
                                  child: ClipRRect(
                                      child: Stack(
                                    children: <Widget>[
                                      ClipRRect(
                                        child: Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          height: 140,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(20.0),
                                            ),
                                          ),
                                          child: customCachedNetworkImage(
                                            context: context,
                                            url: items.imageUl,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        height: 140,
                                        child: Container(
                                          height: 100,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          decoration: BoxDecoration(
                                            gradient: LinearGradient(
                                              colors: [
                                                Color.fromARGB(145, 0, 0, 0),
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
                                              SizedBox(height: 80),
                                              Text(
                                                items.title,
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 14,
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
      } else {
        return Center(child: CircularProgressIndicator());
      }
    },
  );
}

///////////////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////
Container homecoursesList(context) {
  return Container(
    height: 300,
    child: ListView.builder(
      itemCount: listCourses.length,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        return homeCoursesCard(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => CoursesDetails(
                  courses: listCourses[index],
                ),
              ),
            );
          },
          courses: listCourses[index],
          context: context,
          isMycours: false,
        );
      },
    ),
  );
}

////////////////////////////////////////////////////////////////
homeCoursesCard(
    {BuildContext context, Function onTap, Courses courses, bool isMycours}) {
  return GestureDetector(
    onTap: onTap,
    child: SizedBox(
      width: 200,
      child: Card(
        elevation: 3,
        child: Column(
          children: [
            Container(
              height: 100,
              width: MediaQuery.of(context).size.width,
              child: customCachedNetworkImage(
                context: context,
                url: courses.courseImageUrl,
              ),
            ),
            (isMycours == true)
                ? Center(
                    child: Text(
                      courses.title,
                      style: AppTheme.heading.copyWith(
                        fontSize: 10,
                      ),
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    courses.title,
                                    style: AppTheme.heading.copyWith(
                                      fontSize: 10,
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  (courses.couslNmae == '')
                                      ? Container()
                                      : Text(
                                          courses.couslNmae,
                                          style: AppTheme.subHeading.copyWith(
                                            fontSize: 10,
                                            color: customColor,
                                          ),
                                        ),
                                  Row(
                                    children: [
                                      Text(
                                        courses.type,
                                        style: AppTheme.heading.copyWith(
                                          fontSize: 10,
                                        ),
                                      ),
                                      SizedBox(width: 10),
                                      Text(
                                        gitnewPrice(
                                              price: courses.newPrice,
                                              descaound: courses.discount,
                                            ) +
                                            '\$',
                                        style: AppTheme.heading.copyWith(
                                          fontSize: 10,
                                          color: customColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                  (courses.rating == '0')
                                      ? Container()
                                      : Row(
                                          children: [
                                            Icon(
                                              FontAwesomeIcons.starHalfAlt,
                                              color: Colors.yellow[900],
                                            ),
                                            SizedBox(width: 5),
                                            Text(
                                              '(${courses.rating} K)',
                                              style: AppTheme.heading,
                                            ),
                                          ],
                                        ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
          ],
        ),
      ),
    ),
  );
}
