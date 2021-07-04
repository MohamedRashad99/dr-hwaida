import 'package:DrHwaida/constants/constans.dart';
import 'package:DrHwaida/constants/themes.dart';
import 'package:DrHwaida/localization/localization_constants.dart';
import 'package:DrHwaida/models/consultant.dart';
import 'package:DrHwaida/models/prodact.dart';
import 'package:DrHwaida/screens/cart/cart.dart';
import 'package:DrHwaida/screens/wrapper/home/home.dart';
import 'package:DrHwaida/services/dbhelper.dart';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../CustomBottomNavigationBar.dart';

class ScheduleAppo extends StatefulWidget {
  final Consultant consultant;
  const ScheduleAppo({Key key, @required this.consultant}) : super(key: key);
  @override
  _ScheduleAppoState createState() => _ScheduleAppoState();
}

class _ScheduleAppoState extends State<ScheduleAppo> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool showDate = false;
  bool showTime = false;
  bool showEvenig = false;
  bool iscelcted = false;
  int tappedDate;
  int tappedTime;
  var listTimes = [];
  String _date;
  String _time;
  int _timeID;
  DbHehper helper;
  @override
  void initState() {
    super.initState();
    helper = DbHehper();
  }

  @override
  Widget build(BuildContext context) {
    // List<ConsulAvailable> consulAvailable = widget.consultant.available_in;

    return Scaffold(
      appBar: customAppBar(
        title: getTranslated(context, "schedule_appoint"),
      ),
      key: _scaffoldKey,
      bottomNavigationBar: CustomBottomNavigationBar(),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Stack(
          children: [
            (widget.consultant.available_in.isEmpty)
                ? Container()
                : Align(
                    alignment: Alignment.topCenter,
                    child: Column(
                      children: [
                        rowTitle(
                          title: getTranslated(context, "Date"),
                        ),
                        (widget.consultant.availableIn.isEmpty)
                            ? Container()
                            : dateListView(),
                        SizedBox(height: 20),
                        (listTimes.isEmpty)
                            ? Container()
                            : Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    rowTitle(
                                      title: getTranslated(context, "Time"),
                                    ),
                                    timeListView(),
                                  ],
                                ),
                              ),
                        // (_date == null) ? Container() : Text(_date),
                        // (_time == null) ? Container() : Text(_time),
                      ],
                    ),
                  ),
            SizedBox(height: 40),
            Align(
              alignment: Alignment.bottomCenter,
              child: CustomButtonWithchild(
                color: customColor,
                onPress: () async {
                  if (_date != null && _time != null) {
                    ConsultantProdect prodect = ConsultantProdect({
                      'type': 'visit',
                      'consultantId': widget.consultant.id,
                      'dateId': _timeID,
                      'title': widget.consultant.name,
                      'price': widget.consultant.total_coust,
                      'proImageUrl': widget.consultant.image,
                      'date': _date,
                      'time': _time,
                    });
                    await helper.createProduct(prodect);

                    showmyDialog(context: context);
                  } else {
                    // ignore: deprecated_member_use
                    _scaffoldKey.currentState.showSnackBar(
                      new SnackBar(
                        content: new Text(getTranslated(context, "chooseDate")),
                      ),
                    );
                  }
                },
                child: Text(
                  getTranslated(context, "Add_to_Cart"),
                  style: AppTheme.heading.copyWith(
                    color: Colors.white,
                  ),
                ),
              ),
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

  Container timeListView() {
    return Container(
      height: 110,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: listTimes.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          if (listTimes[index].isEmpty) {
            return Container();
          } else {
            return timeCard(
              time: listTimes[index]["time"],
              index: index,
              timeID: listTimes[index]["id"],
            );
          }
        },
      ),
    );
  }

  Container dateListView() {
    return Container(
      height: 110,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: widget.consultant.availableIn.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              setState(() {
                tappedDate = index;

                listTimes = widget.consultant.availableIn[index]['times'];
                print(listTimes.toString());
                _date = widget.consultant.availableIn[index]['date'];
              });
            },
            child: Card(
              elevation: 4,
              semanticContainer: false,
              color: tappedDate == index ? customColor : Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Container(
                width: 100,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      widget.consultant.availableIn[index]["day"],
                      style: AppTheme.heading.copyWith(
                        color:
                            tappedDate == index ? Colors.white : Colors.black,
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      widget.consultant.availableIn[index]["date"],
                      style: AppTheme.subHeading.copyWith(
                        color:
                            tappedDate == index ? Colors.white : Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  timeCard({int index, String time, int timeID}) {
    return InkWell(
      onTap: () {
        setState(() {
          tappedTime = index;
          _timeID = timeID;
          _time = time;
        });
      },
      child: Card(
        elevation: 4,
        color: tappedTime == index ? customColor : Colors.white,
        semanticContainer: false,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Container(
          width: 80,
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  FontAwesomeIcons.clock,
                  color: tappedTime == index ? Colors.white : Colors.black,
                  size: 35,
                ),
                SizedBox(height: 5),
                Text(
                  time,
                  style: AppTheme.subHeading.copyWith(
                    color: tappedTime == index ? Colors.white : Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  rowTitle({String title}) {
    return Container(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: AppTheme.heading,
              ),
              SizedBox(width: 10),
              Icon(
                Icons.arrow_drop_down,
                color: customColor,
              ),
            ],
          ),
          SizedBox(height: 10),
          Divider(
            color: customColorDivider,
            thickness: 1,
          ),
        ],
      ),
    );
  }
}
