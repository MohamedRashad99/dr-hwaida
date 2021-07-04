import 'package:DrHwaida/constants/constans.dart';
import 'package:DrHwaida/constants/themes.dart';
import 'package:DrHwaida/localization/localization_constants.dart';
import 'package:DrHwaida/models/courses.dart';
import 'package:DrHwaida/models/prodact.dart';
import 'package:DrHwaida/models/user.dart';
import 'package:DrHwaida/models/utils.dart';
import 'package:DrHwaida/screens/cart/cart.dart';
import 'package:DrHwaida/screens/wrapper/home/home.dart';
import 'package:DrHwaida/services/dbhelper.dart';
import 'package:DrHwaida/services/network_sensitive.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;
import '../CustomBottomNavigationBar.dart';
// import 'components/videoscreens.dart';

class CoursesDetails extends StatefulWidget {
  final Courses courses;

  const CoursesDetails({Key key, @required this.courses}) : super(key: key);
  @override
  _CoursesDetailsState createState() => _CoursesDetailsState();
}

class _CoursesDetailsState extends State<CoursesDetails> {
  int qTapped;
  bool showAnwser = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  YoutubePlayerController _controller;

  String id;
  DbHehper helper;

  @override
  void initState() {
    super.initState();
    helper = DbHehper();
    if (widget.courses.courseVideoUrl != null &&
        Uri.parse(widget.courses.courseVideoUrl).isAbsolute) {
      id = YoutubePlayer.convertUrlToId(widget.courses.courseVideoUrl);
      _controller = YoutubePlayerController(
        initialVideoId: id,
        flags: const YoutubePlayerFlags(
          mute: false,
          autoPlay: false,
          disableDragSeek: false,
          loop: false,
          isLive: false,
          forceHD: true,
          enableCaption: true,
        ),
      );
    }
  }

  addRating({double rate, String coment, String answer, int id}) async {
    try {
      var response = await http.post(
        Uri.parse(Utils.COURSESRATE_URL),
        body: {},
        headers: {
          'x-api-key': User.userToken,
        },
      );

      Map<String, dynamic> map = json.decode(response.body);

      if (map['success'] == true) {
        // ignore: deprecated_member_use
        _scaffoldKey.currentState.showSnackBar(
          new SnackBar(
            content: new Text('thank you for rating'),
          ),
        );
      } else {
        print(response.statusCode.toString());
        print(map['message']);
        // ignore: deprecated_member_use
        _scaffoldKey.currentState.showSnackBar(
          new SnackBar(
            content: new Text('Your rating failed,please try again'),
          ),
        );
      }

      // Navigator.pop(context);
    } catch (e) {
      print(e);
    }
  }

  @override
  void deactivate() {
    if (widget.courses.courseVideoUrl != null &&
        Uri.parse(widget.courses.courseVideoUrl).isAbsolute) {
      _controller.pause();
    }
    super.deactivate();
  }

  @override
  void dispose() {
    if (widget.courses.courseVideoUrl != null &&
        Uri.parse(widget.courses.courseVideoUrl).isAbsolute) {
      _controller.dispose();
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orien) {
        if (orien == Orientation.landscape) {
          return Scaffold(
            body: youtubePlayer(_controller),
          );
        } else {
          return scafofoldWithappBar(context);
        }
      },
    );
  }

  Scaffold scafofoldWithappBar(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(),
      body: NetworkSensitive(
        child: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height - 150,
              child: ListView(
                shrinkWrap: true,
                primary: true,
                padding: EdgeInsets.symmetric(vertical: 10),
                children: [
                  courseCard(),
                  SizedBox(height: 4),
                  aboutThisCourse(context),
                  (widget.courses.features != null) ? qAs() : Container(),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: CustomButtonWithchild(
                      color: customColor,
                      onPress: () async {
                        ConsultantProdect prodect = ConsultantProdect({
                          'type': 'courses',
                          'consultantId': widget.courses.id,
                          // 'dateId': _timeID,
                          'title': widget.courses.title,
                          'price': double.parse(widget.courses.newPrice),
                          'proImageUrl': widget.courses.courseImageUrl,
                          // 'date': _date,
                          // 'time': _time,
                        });
                        await helper.createProduct(prodect);

                        showmyDialog(context: context);
                      },
                      child: Center(
                        child: Text(
                          getTranslated(context, "Add_to_Cart"),
                          style: AppTheme.heading.copyWith(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
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
      ),
    );
  }

  Future<void> showmyDialog({BuildContext context}) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Center(
                  child: Text(
                    getTranslated(context, "Items_Was_added"),
                    style: AppTheme.heading.copyWith(),
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                getTranslated(context, "home_page"),
                style: AppTheme.heading.copyWith(
                  color: customColor,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (BuildContext context) => Home()),
                );
              },
            ),
            TextButton(
              child: Text(
                getTranslated(context, "Go_to_Cart"),
                style: AppTheme.heading.copyWith(
                  color: customColor,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                    builder: (BuildContext context) => Cart(),
                  ),
                  ModalRoute.withName('/'),
                );
              },
            ),
          ],
        );
      },
    );
  }

  qAs() {
    return ListView.builder(
      shrinkWrap: true,
      primary: false,
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      itemCount: widget.courses.features.length,
      itemBuilder: (context, index) {
        return Column(
          children: [
            InkWell(
              onTap: () {
                setState(() {
                  qTapped = index;
                  showAnwser = !showAnwser;
                });
              },
              child: Container(
                height: 50,
                color: (qTapped == index && showAnwser == true)
                    ? customColor
                    : Colors.grey,
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      widget.courses.features[index]['name'],
                      textDirection: TextDirection.ltr,
                      style: AppTheme.heading.copyWith(color: Colors.white),
                    ),
                    SizedBox(width: 20),
                    Icon(
                      (qTapped == index && showAnwser == true)
                          ? Icons.add
                          : Icons.minimize,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10),
            (qTapped == index && showAnwser == true)
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width - 20,
                        child: Text(
                          widget.courses.features[index]['description'],
                          textDirection: TextDirection.ltr,
                          style: AppTheme.subHeading,
                        ),
                      ),
                    ],
                  )
                : Container(),
          ],
        );
      },
    );
  }

  aboutThisCourse(BuildContext context) {
    return Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          color: customColorDivider.withOpacity(.5),
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        getTranslated(context, "About") + ':',
                        style: AppTheme.heading.copyWith(
                          color: Colors.grey[500],
                        ),
                      ),
                      Text(
                        (widget.courses.title) ?? '',
                        style: AppTheme.heading.copyWith(
                          color: Colors.grey[500],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Text(
                    parseHtmlString((widget.courses.contant) ?? ''),
                    style: AppTheme.heading.copyWith(
                      color: Colors.grey[500],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              rowOfCorseDetaile(
                icon: FontAwesomeIcons.globeAfrica,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      getTranslated(context, "instructor") +
                              ':' +
                              (widget.courses.couslNmae) ??
                          '',
                      style: AppTheme.heading.copyWith(
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              (widget.courses.type == "offline")
                  ? rowOfCorseDetaile(
                      icon: FontAwesomeIcons.calendar,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.courses.type,
                            style: AppTheme.heading.copyWith(
                              fontSize: 12,
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        getTranslated(context, "start_date") +
                                            ': ',
                                        style: AppTheme.heading.copyWith(
                                          color: customColor,
                                          fontSize: 9,
                                        ),
                                      ),
                                      Text(
                                        (widget.courses.start_date) ?? '',
                                        style: AppTheme.heading.copyWith(
                                          color: Colors.grey.withOpacity(.9),
                                          fontSize: 9,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(width: 10),
                                  Row(
                                    children: [
                                      Text(
                                        getTranslated(context, "end_date") +
                                            ': ',
                                        style: AppTheme.heading.copyWith(
                                          color: customColor,
                                          fontSize: 9,
                                        ),
                                      ),
                                      Text(
                                        (widget.courses.end_date) ?? '',
                                        style: AppTheme.heading.copyWith(
                                          color: Colors.grey.withOpacity(.9),
                                          fontSize: 9,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        getTranslated(context, "start_time") +
                                            ': ',
                                        style: AppTheme.heading.copyWith(
                                          color: customColor,
                                          fontSize: 9,
                                        ),
                                      ),
                                      Text(
                                        (widget.courses.start_time) ?? "",
                                        style: AppTheme.heading.copyWith(
                                          color: Colors.grey.withOpacity(.9),
                                          fontSize: 9,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(width: 10),
                                  Row(
                                    children: [
                                      Text(
                                        getTranslated(context, "start_time") +
                                            ': ',
                                        style: AppTheme.heading.copyWith(
                                          color: customColor,
                                          fontSize: 9,
                                        ),
                                      ),
                                      Text(
                                        (widget.courses.end_time) ?? "",
                                        style: AppTheme.heading.copyWith(
                                          color: Colors.grey.withOpacity(.9),
                                          fontSize: 9,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  : rowOfCorseDetaile(
                      icon: FontAwesomeIcons.clock,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.courses.type,
                            style: AppTheme.heading.copyWith(
                              fontSize: 12,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    getTranslated(context, "videos") + ': ',
                                    style: AppTheme.heading.copyWith(
                                      color: customColor,
                                      fontSize: 9,
                                    ),
                                  ),
                                  Text(
                                    widget.courses.videos_count.toString(),
                                    style: AppTheme.heading.copyWith(
                                      color: Colors.grey.withOpacity(.9),
                                      fontSize: 9,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(width: 50),
                              Row(
                                children: [
                                  Text(
                                    getTranslated(context, "total_time") + ': ',
                                    style: AppTheme.heading.copyWith(
                                      color: customColor,
                                      fontSize: 9,
                                    ),
                                  ),
                                  Text(
                                    widget.courses.total_time,
                                    style: AppTheme.heading.copyWith(
                                      color: Colors.grey.withOpacity(.9),
                                      fontSize: 9,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
            ],
          ),
        ),
      ],
    );
  }

  rowOfCorseDetaile({Widget child, IconData icon}) {
    return Row(
      children: [
        Container(
          height: 50,
          width: 50,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: customColor),
          ),
          child: Center(
            child: Icon(
              icon,
              color: customColor,
              size: 30,
            ),
          ),
        ),
        SizedBox(width: 10),
        child,
      ],
    );
  }

  circleContainerWithIcon({IconData icon}) {
    return Container(
      height: 60,
      width: 60,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: customColor),
      ),
      child: Center(
        child: Icon(
          icon,
          color: customColor,
          size: 40,
        ),
      ),
    );
  }

  courseCard() {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 10,
      ),
      child: Card(
        elevation: 4,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            (widget.courses.courseVideoUrl != null &&
                    Uri.parse(widget.courses.courseVideoUrl).isAbsolute)
                ? Container(
                    width: MediaQuery.of(context).size.width,
                    height: 200,
                    child: youtubePlayer(_controller),
                  )
                : Container(),
            courseDetail(),
          ],
        ),
      ),
    );
  }

  courseDetail() {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 10,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 2,
                child: Text(
                  widget.courses.title,
                  style: AppTheme.heading,
                ),
              ),
              (widget.courses.rating == '0')
                  ? Container()
                  : Expanded(
                      flex: 1,
                      child: Row(
                        children: [
                          Icon(
                            FontAwesomeIcons.starHalfAlt,
                            color: Colors.yellow[900],
                          ),
                          SizedBox(width: 5),
                          Text(
                            '(${widget.courses.rating} K)',
                            style: AppTheme.heading,
                          ),
                        ],
                      ),
                    ),
            ],
          ),
          SizedBox(height: 10),
          Row(
            children: [
              (widget.courses.discount != '0')
                  ? Text(
                      widget.courses.newPrice,
                      style: AppTheme.heading.copyWith(
                        color: Colors.grey[500],
                        fontSize: 8,
                        decoration: TextDecoration.lineThrough,
                      ),
                    )
                  : Container(),
              SizedBox(width: 5),
              Text(
                gitnewPrice(
                      price: widget.courses.newPrice,
                      descaound: widget.courses.discount,
                    ) +
                    '\$',
                style: AppTheme.heading.copyWith(
                  fontSize: 10,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
