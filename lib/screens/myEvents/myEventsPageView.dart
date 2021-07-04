import 'package:DrHwaida/constants/constans.dart';
import 'package:DrHwaida/constants/themes.dart';
import 'package:DrHwaida/localization/localization_constants.dart';
import 'package:DrHwaida/models/events.dart';
import 'package:DrHwaida/screens/cart/cart.dart';
import 'package:DrHwaida/screens/wrapper/home/home.dart';
import 'package:DrHwaida/services/dbhelper.dart';
import 'package:DrHwaida/services/network_sensitive.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../CustomBottomNavigationBar.dart';

class MyEventsPageView extends StatefulWidget {
  final CustomEvent events;

  const MyEventsPageView({Key key, @required this.events}) : super(key: key);
  @override
  _MyEventsPageViewState createState() => _MyEventsPageViewState();
}

class _MyEventsPageViewState extends State<MyEventsPageView> {
  YoutubePlayerController _controller;
  DbHehper helper;
  String id;

  @override
  void initState() {
    super.initState();
    helper = DbHehper();

    if (widget.events.video != null &&
        Uri.parse(widget.events.video).isAbsolute) {
      id = YoutubePlayer.convertUrlToId(widget.events.video);
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

  @override
  void deactivate() {
    if (widget.events.video != null &&
        Uri.parse(widget.events.video).isAbsolute) {
      _controller.pause();
    }
    super.deactivate();
  }

  @override
  void dispose() {
    if (widget.events.video != null &&
        Uri.parse(widget.events.video).isAbsolute) {
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
          return scaffoldWtihVideo(context);
        }
      },
    );
  }

  Scaffold scaffoldWtihVideo(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: NetworkSensitive(
        child: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height - 180,
              child: ListView(
                shrinkWrap: true,
                children: [
                  Container(
                    height: 200,
                    width: MediaQuery.of(context).size.width,
                    child: Stack(
                      children: [
                        Container(
                          child: Container(
                            child: ClipRRect(
                                child: Stack(
                              children: <Widget>[
                                ClipRRect(
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: 200,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(20.0),
                                      ),
                                    ),
                                    child: customCachedNetworkImage(
                                      context: context,
                                      url: widget.events.imageUl,
                                    ),
                                  ),
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: 200,
                                  child: Container(
                                    height: 100,
                                    width: MediaQuery.of(context).size.width,
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
                                          widget.events.title,
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
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                Text(
                                  getTranslated(context, "start_date") + ': ',
                                  style: AppTheme.heading.copyWith(
                                    color: customColor,
                                  ),
                                ),
                                Text(
                                  widget.events.start_date,
                                  style: AppTheme.subHeading,
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  getTranslated(context, "end_date") + ': ',
                                  style: AppTheme.heading.copyWith(
                                    color: customColor,
                                  ),
                                ),
                                Text(
                                  widget.events.start_date,
                                  style: AppTheme.subHeading,
                                ),
                              ],
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                Text(
                                  getTranslated(context, "start_time") + ': ',
                                  style: AppTheme.heading.copyWith(
                                    color: customColor,
                                  ),
                                ),
                                Text(
                                  widget.events.start_time,
                                  style: AppTheme.subHeading,
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  getTranslated(context, "end_time") + ': ',
                                  style: AppTheme.heading.copyWith(
                                    color: customColor,
                                  ),
                                ),
                                Text(
                                  widget.events.start_time,
                                  style: AppTheme.subHeading,
                                ),
                              ],
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              getTranslated(context, "Price") + ': ',
                              style: AppTheme.heading.copyWith(
                                color: customColor,
                              ),
                            ),
                            Row(
                              children: [
                                (widget.events.discount != null &&
                                        widget.events.discount != '0')
                                    ? Text(
                                        widget.events.price,
                                        style: AppTheme.heading.copyWith(
                                          color: Colors.grey[500],
                                          fontSize: 8,
                                          decoration:
                                              TextDecoration.lineThrough,
                                        ),
                                      )
                                    : Container(),
                                SizedBox(width: 5),
                                Text(
                                  gitnewPrice(
                                        price: widget.events.price,
                                        descaound: widget.events.discount,
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
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 50, vertical: 5),
                          child: Divider(
                            thickness: 2,
                            color: customColorDivider,
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              getTranslated(context, "About") + ': ',
                              style: AppTheme.heading.copyWith(
                                color: customColor,
                              ),
                            ),
                            Text(
                              widget.events.title,
                              style: AppTheme.subHeading,
                            ),
                          ],
                        ),
                        SizedBox(height: 5),
                        (widget.events.contant != null)
                            ? Text(
                                parseHtmlString(widget.events.contant),
                                textAlign: TextAlign.justify,
                                style: AppTheme.subHeading.copyWith(
                                  height: 1.5,
                                ),
                              )
                            : Container(),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 50, vertical: 5),
                          child: Divider(
                            thickness: 2,
                            color: customColorDivider,
                          ),
                        ),
                        (widget.events.video != null &&
                                Uri.parse(widget.events.video).isAbsolute)
                            ? youtubePlayer(_controller)
                            : Container(),
                      ],
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
}
