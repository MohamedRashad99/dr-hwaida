import 'package:DrHwaida/constants/constans.dart';
import 'package:DrHwaida/localization/localization_constants.dart';
import 'package:DrHwaida/models/consultantApi.dart';
import 'package:DrHwaida/screens/consultantPageView/consultantPageView.dart';
import 'package:flutter/material.dart';

class ConusltantSearch extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
          close(context, null);
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back_ios),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return query.isEmpty
        ? Container()
        : FutureBuilder(
            future: ConsultantApi.consulSreachByName(query),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return (snapshot.data == null || snapshot.data.isEmpty)
                    ? Container(
                        child: Center(
                          child: Text(getTranslated(context, "searchFiled")),
                        ),
                      )
                    : ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, i) {
                          return ListTile(
                            leading: Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                  child: (snapshot.data[i].image == null)
                                      ? Container(
                                          child: Icon(
                                            Icons.image,
                                            color: Colors.lightBlueAccent,
                                          ),
                                        )
                                      : customCachedNetworkImage(
                                          context: context,
                                          url: snapshot.data[i].image,
                                        )),
                            ),
                            title: Text(snapshot.data[i].name),
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) => ConsultantPageView(
                                    consultant: snapshot.data[i],
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return query.isEmpty
        ? Container()
        : FutureBuilder(
            future: ConsultantApi.consulSreachByName(query),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return (snapshot.data == null || snapshot.data.isEmpty)
                    ? Container(
                        child: Center(
                          child: Text(getTranslated(context, "searchFiled")),
                        ),
                      )
                    : ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, i) {
                          return ListTile(
                            leading: Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                  child: (snapshot.data[i].image == null)
                                      ? Container(
                                          child: Icon(
                                            Icons.image,
                                            color: Colors.lightBlueAccent,
                                          ),
                                        )
                                      : customCachedNetworkImage(
                                          context: context,
                                          url: snapshot.data[i].image,
                                        )),
                            ),
                            title: Text(snapshot.data[i].name),
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) => ConsultantPageView(
                                    consultant: snapshot.data[i],
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          );
  }
}
