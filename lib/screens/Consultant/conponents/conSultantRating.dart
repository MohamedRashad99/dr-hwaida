import 'dart:convert';
import 'package:DrHwaida/localization/localization_constants.dart';
import 'package:DrHwaida/models/sttingesApi.dart';
import 'package:http/http.dart' as http;

import 'package:DrHwaida/constants/constans.dart';
import 'package:DrHwaida/constants/themes.dart';
import 'package:DrHwaida/models/user.dart';
import 'package:DrHwaida/models/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class ConsultantRating extends StatefulWidget {
  final String title;

  // ignore: non_constant_identifier_names
  final int consultant_id;

  const ConsultantRating({
    Key key,
    @required this.title,

    // ignore: non_constant_identifier_names
    @required this.consultant_id,
  }) : super(key: key);
  @override
  _ConsultantRatingState createState() => _ConsultantRatingState();
}

class _ConsultantRatingState extends State<ConsultantRating> {
  double rate = 2.5;
  bool loading = false;
  String error = '';
  String coment;
  String anwser;
  String lang;
  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  gitUserLaing() {
    if (User.appLang == 'ar_EG') {
      setState(() {
        lang = 'ar';
      });
    } else {
      lang = 'en';
    }
    print(lang);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: FutureBuilder(
        future: CoutactUSApi.gitContactUS(),
        builder: (context, snapshot) {
          if (snapshot.data == null) {
            return Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else {
            return (loading)
                ? Container(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
                : ListView(
                    shrinkWrap: true,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 20,
                    ),
                    children: [
                      Container(
                        child: Form(
                          key: _formKey,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Center(
                                  child: Text(
                                    getTranslated(context, 'addRate'),
                                    style: AppTheme.heading.copyWith(
                                      color: customColor,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 20),
                                Text(
                                  widget.title,
                                  style: AppTheme.heading.copyWith(),
                                ),
                                SizedBox(height: 10),
                                Center(
                                  child: SmoothStarRating(
                                    rating: rate,
                                    size: 25,
                                    onRated: (val) {
                                      setState(() {
                                        rate = val;
                                      });
                                    },
                                    filledIconData: Icons.star,
                                    color: Colors.yellow[700],
                                    halfFilledIconData: Icons.star_half,
                                    borderColor: Colors.yellow[900],
                                    defaultIconData: Icons.star_border,
                                    starCount: 5,
                                    allowHalfRating: true,
                                    spacing: 2.0,
                                  ),
                                ),
                                SizedBox(height: 10),
                                TextFormField(
                                  onChanged: (val) {
                                    setState(() {
                                      coment = val;
                                    });
                                  },
                                  decoration: conectedTextFormStyle(
                                    lableText:
                                        getTranslated(context, 'addComment'),
                                  ),
                                ),
                                SizedBox(height: 20),
                                Center(
                                  child: Text(
                                    snapshot.data.rate_question,
                                    textDirection: TextDirection.ltr,
                                    style: AppTheme.heading.copyWith(),
                                  ),
                                ),
                                SizedBox(height: 10),
                                TextFormField(
                                  onChanged: (val) {
                                    setState(() {
                                      anwser = val;
                                    });
                                  },
                                  validator: (val) => val.isEmpty
                                      ? getTranslated(context, 'addAnswers')
                                      : null,
                                  decoration: conectedTextFormStyle(
                                    lableText: getTranslated(context, 'answer'),
                                  ),
                                ),
                                SizedBox(height: 10),
                                Text(error),
                                SizedBox(height: 10),
                                CustomButtonWithchild(
                                  color: customColor,
                                  onPress: () {
                                    if (_formKey.currentState.validate()) {
                                      setState(() {
                                        loading = !loading;
                                      });
                                      addRating(
                                        answer: anwser,
                                        coment: coment,
                                        rate: rate,
                                        id: widget.consultant_id,
                                        lang: lang,
                                      );
                                    }
                                  },
                                  child: Center(
                                    child: Text(
                                      getTranslated(context, 'Rate'),
                                      style: AppTheme.heading.copyWith(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
          }
        },
      ),
    );
  }

  addRating(
      {double rate, String coment, String answer, int id, String lang}) async {
    print(apiLang());
    try {
      var response = await http.post(
        Uri.parse(Utils.RATE_URL),
        body: {
          'consultant_id': id.toString(),
          'rate': rate.toString(),
          'comment': coment.toString(),
          'answer': anwser.toString(),
        },
        headers: {
          'x-api-key': User.userToken,
          "lang": apiLang(),
        },
      );

      Map<String, dynamic> map = json.decode(response.body);

      if (map['success'] == true) {
        setState(() {
          loading = !loading;
        });
        // ignore: deprecated_member_use
        _scaffoldKey.currentState.showSnackBar(
          new SnackBar(
            content: new Text(getTranslated(context, 'RateThank')),
          ),
        );
      } else {
        print(response.statusCode.toString());
        setState(() {
          loading = !loading;
        });
        print(map['message']);
        // ignore: deprecated_member_use
        _scaffoldKey.currentState.showSnackBar(
          new SnackBar(
            content: new Text(map['message'].toString()),
          ),
        );
      }

      // Navigator.pop(context);
    } catch (e) {
      setState(() {
        loading = !loading;
      });
      print("errorrrrrrrrrrrrrrr");
      print(e.toString());
    }
  }
}
