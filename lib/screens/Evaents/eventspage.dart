import 'package:DrHwaida/constants/constans.dart';
import 'package:DrHwaida/constants/themes.dart';
import 'package:DrHwaida/localization/localization_constants.dart';
import 'package:DrHwaida/models/eventApi.dart';
import 'package:DrHwaida/screens/CustomBottomNavigationBar.dart';
import 'package:DrHwaida/screens/Evaents/eventsPageView.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EventsPage extends StatefulWidget {
  @override
  _EventsPageState createState() => _EventsPageState();
}

class _EventsPageState extends State<EventsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        title: getTranslated(context, "Events"),
      ),
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height - 160,
            child: FutureBuilder(
              future: EventsApi.fetchAllEvent(),
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
                      : ListView.builder(
                          shrinkWrap: true,
                          itemCount: snapshot.data.length,
                          padding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (_) => EventsPageView(
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
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              height: 140,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(20.0),
                                                ),
                                              ),
                                              child: customCachedNetworkImage(
                                                context: context,
                                                url: snapshot
                                                    .data[index].imageUl,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            height: 140,
                                            child: Container(
                                              height: 100,
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              decoration: BoxDecoration(
                                                gradient: LinearGradient(
                                                  colors: [
                                                    Color.fromARGB(
                                                        145, 0, 0, 0),
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
                                ),
                                SizedBox(height: 5),
                              ],
                            );
                          },
                        );
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
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
}
