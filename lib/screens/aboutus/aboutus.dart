import 'package:DrHwaida/constants/constans.dart';
import 'package:DrHwaida/constants/themes.dart';
import 'package:DrHwaida/localization/localization_constants.dart';
import 'package:DrHwaida/models/aboutUs.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:html/parser.dart';

import '../CustomBottomNavigationBar.dart';

class AboutUS extends StatefulWidget {
  @override
  _AboutUSState createState() => _AboutUSState();
}

class _AboutUSState extends State<AboutUS> {
  @override
  Widget build(BuildContext context) {
    String _parseHtmlString(String htmlString) {
      final document = parse(htmlString);
      final String parsedString =
          parse(document.body.text).documentElement.text;

      return parsedString;
    }

    return Scaffold(
      appBar: customAppBar(title: getTranslated(context, "About_app")),
      body: FutureBuilder(
        future: AboutUSApi.gitAboutUSApi(),
        builder: (context, snapshot) {
          if (snapshot.data == null) {
            return Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else {
            return Stack(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height - 160,
                  child: ListView(
                    shrinkWrap: true,
                    primary: true,
                    children: [
                      Container(
                        height: 200,
                        width: MediaQuery.of(context).size.width,
                        child: (snapshot.data.imageUrl == null)
                            ? Container(
                                child: Icon(
                                  Icons.image,
                                  color: Colors.lightBlueAccent,
                                ),
                              )
                            : CachedNetworkImage(
                                imageUrl: snapshot.data.imageUrl,
                                fit: BoxFit.cover,
                                placeholder: (context, url) => Center(
                                  child: CircularProgressIndicator(),
                                ),
                                errorWidget: (context, url, error) =>
                                    Icon(Icons.error),
                              ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                        child: Text(
                          _parseHtmlString(snapshot.data.contant),
                          style: AppTheme.subHeading.copyWith(
                            height: 1.5,
                            letterSpacing: .07,
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
            );
          }
        },
      ),
    );
  }
}
