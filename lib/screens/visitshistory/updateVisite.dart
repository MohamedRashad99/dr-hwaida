import 'dart:convert';

import 'package:DrHwaida/constants/constans.dart';
import 'package:DrHwaida/constants/themes.dart';
import 'package:DrHwaida/localization/localization_constants.dart';
import 'package:DrHwaida/models/consultant.dart';
import 'package:DrHwaida/models/consultantApi.dart';
import 'package:DrHwaida/models/user.dart';
import 'package:DrHwaida/models/utils.dart';
import 'package:DrHwaida/screens/wrapper/home/home.dart';
import 'package:DrHwaida/services/dbhelper.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../CustomBottomNavigationBar.dart';

class UpdateVisits extends StatefulWidget {
  final int consultantId;
  final int visitsId;
  final Consultant consultant;
  const UpdateVisits(
      {Key key,
      @required this.consultantId,
      @required this.visitsId,
      @required this.consultant})
      : super(key: key);
  @override
  _UpdateVisitsState createState() => _UpdateVisitsState();
}

class _UpdateVisitsState extends State<UpdateVisits> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool showDate = false;
  bool showTime = false;
  bool showEvenig = false;
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
      appBar: customAppBar(title: 'Schedule Appointment'),
      key: _scaffoldKey,
      bottomNavigationBar: CustomBottomNavigationBar(),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: FutureBuilder(
          future: ConsultantApi.fetchConsultantById(widget.consultantId),
          builder: (contaxt, snapshot) {
            if (snapshot.data == null) {
              return Container(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            } else {
              return Stack(
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: Column(
                      children: [
                        rowTitle(
                          title: getTranslated(context, "Date"),
                        ),
                        (snapshot.data.availableIn.isEmpty)
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
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: CustomButtonWithchild(
                      color: customColor,
                      onPress: () async {
                        if (_date != null && _time != null) {
                          updateAppointment(
                              id: widget.visitsId,
                              availableId: _timeID,
                              date: _date);
                        } else {
                          // ignore: deprecated_member_use
                          _scaffoldKey.currentState.showSnackBar(
                            new SnackBar(
                              content: new Text(
                                  getTranslated(context, "chooseDate")),
                            ),
                          );
                        }
                      },
                      child: Text(
                        getTranslated(context, "update_appoint"),
                        style: AppTheme.heading.copyWith(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }

  updateAppointment({int id, int availableId, String date}) async {
    final uri = Uri.parse(Utils.VISITS_URL + "/$id").replace(
      queryParameters: <String, String>{
        "available_id": "$availableId",
        "visit_date": "$date",
      },
    );
    print(uri.toString());
    try {
      var respes = await http.put(
        uri,
        headers: {'x-api-key': User.userToken},
      );
      print(respes.statusCode.toString());
      final data = json.decode(respes.body);
      if (data['success'] != true) {
        // ignore: deprecated_member_use
        _scaffoldKey.currentState.showSnackBar(
          new SnackBar(
            content: new Text(
                'Update failed,(We have a server error${data['message']}), Please try again later'),
          ),
        );
      } else {
        showmyDialog(context: context);
      }
    } catch (e) {
      // ignore: deprecated_member_use
      _scaffoldKey.currentState.showSnackBar(
        new SnackBar(
          content: new Text(
              'Update failed(We have a server error ${e.toString()}), Please try again  later '),
        ),
      );

      print('catch Error is:' + e.toString());
    }
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
                Text(
                  'Appointment was Update',
                  style: AppTheme.heading.copyWith(
                    color: customColor,
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                'Oki',
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
