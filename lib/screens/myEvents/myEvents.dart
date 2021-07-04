import 'package:DrHwaida/constants/constans.dart';
import 'package:DrHwaida/constants/themes.dart';
import 'package:DrHwaida/localization/localization_constants.dart';
import 'package:DrHwaida/models/eventApi.dart';
import 'package:DrHwaida/screens/myEvents/myEventsPageView.dart';
import 'package:DrHwaida/services/network_sensitive.dart';
import 'package:flutter/material.dart';

class MyEvents extends StatefulWidget {
  @override
  _MyEventsState createState() => _MyEventsState();
}

class _MyEventsState extends State<MyEvents> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: NetworkSensitive(
        child: ListView(
          shrinkWrap: true,
          primary: true,
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          children: [
            FutureBuilder(
              future: EventsApi.fetchMyEvent(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return (snapshot.data == null && snapshot.data.isEmpaty)
                      ? Container(
                          child: Center(
                            child: Text(
                              getTranslated(context, 'networkError'),
                              style: AppTheme.heading,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        )
                      : ListView.builder(
                          shrinkWrap: true,
                          primary: false,
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (_) => MyEventsPageView(
                                      events: snapshot.data[index],
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
                                            url: snapshot.data[index].imageUl,
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
                                                snapshot.data[index].title,
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
                            );
                          },
                        );
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
