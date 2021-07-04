import 'dart:convert';
import 'package:DrHwaida/localization/localization_constants.dart';
import 'package:DrHwaida/models/sttingesApi.dart';
import 'package:DrHwaida/screens/wrapper/home/home.dart';
import 'package:http/http.dart' as http;
import 'package:DrHwaida/constants/constans.dart';
import 'package:DrHwaida/constants/themes.dart';
import 'package:DrHwaida/models/user.dart';
import 'package:DrHwaida/models/utils.dart';
import 'package:DrHwaida/screens/CustomBottomNavigationBar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ContatactUs extends StatefulWidget {
  @override
  _ContatactUsState createState() => _ContatactUsState();
}

class _ContatactUsState extends State<ContatactUs> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();

  String email;
  String name;
  String messges;
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: customAppBar(title: getTranslated(context, "contact_support")),
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
                : Stack(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height - 160,
                        child: ListView(
                          shrinkWrap: true,
                          primary: true,
                          children: [
                            Container(
                              height: 150,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image:
                                      NetworkImage(snapshot.data.contact_image),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Form(
                              key: _formKey,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    TextFormField(
                                      validator: (val) => val.isEmpty
                                          ? getTranslated(context, "valid_name")
                                          : null,
                                      onChanged: (val) {
                                        setState(() {
                                          name = val;
                                        });
                                      },
                                      decoration: conectedTextFormStyle(
                                          lableText:
                                              getTranslated(context, "name")),
                                    ),
                                    SizedBox(height: 12),
                                    TextFormField(
                                      validator: (val) => val.isEmpty
                                          ? getTranslated(
                                              context, "valid_email")
                                          : null,
                                      onChanged: (val) {
                                        setState(() {
                                          email = val;
                                        });
                                      },
                                      decoration: conectedTextFormStyle(
                                          lableText:
                                              getTranslated(context, "email")),
                                    ),
                                    SizedBox(height: 12),
                                    TextFormField(
                                      validator: (val) => val.isEmpty
                                          ? getTranslated(
                                              context, "valid_massege")
                                          : null,
                                      maxLines: null,
                                      onChanged: (val) {
                                        setState(() {
                                          messges = val;
                                        });
                                      },
                                      decoration: conectedTextFormStyle(
                                          lableText: getTranslated(
                                              context, "Massage")),
                                    ),
                                    SizedBox(height: 15),
                                    Text(
                                      getTranslated(context, "contact_support"),
                                      style: AppTheme.heading.copyWith(
                                        color: customColor,
                                        fontSize: 16,
                                      ),
                                    ),
                                    SizedBox(height: 20),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 50),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          customSocialMdiaBottom(
                                            onTap: () {
                                              launchInBrowser(
                                                  snapshot.data.facebookurl);
                                            },
                                            icon: FontAwesomeIcons.facebook,
                                            color: Colors.blue,
                                          ),
                                          customSocialMdiaBottom(
                                            onTap: () {
                                              launchInBrowser(
                                                  snapshot.data.whatsappUrl);
                                            },
                                            icon: FontAwesomeIcons.whatsapp,
                                            color: Colors.greenAccent,
                                          ),
                                          customSocialMdiaBottom(
                                            onTap: () {
                                              launchInBrowser(
                                                  snapshot.data.twitterurl);
                                            },
                                            icon: FontAwesomeIcons.twitter,
                                            color: Colors.lightBlueAccent,
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 25),
                                    CustomButtonWithchild(
                                      color: customColor,
                                      child: Text(
                                        getTranslated(context, "Submit"),
                                        style: AppTheme.heading.copyWith(
                                          color: Colors.white,
                                          fontSize: 14,
                                        ),
                                      ),
                                      onPress: () {
                                        if (_formKey.currentState.validate()) {
                                          setState(() {
                                            loading = !loading;
                                          });
                                          sentContactusDate(
                                              email: email,
                                              name: name,
                                              message: messges);
                                        }
                                      },
                                    ),
                                    SizedBox(height: 15),
                                    Center(
                                      child: Text(
                                        getTranslated(context, "thank_you"),
                                        style: AppTheme.heading.copyWith(
                                          color: Colors.black38,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                  ],
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

  sentContactusDate({String name, String email, String message}) async {
    try {
      var respes = await http.post(
        Uri.parse(Utils.CONTACTUS_URL),
        headers: {'x-api-key': User.userToken},
        body: {
          'name': name,
          'email': email,
          'message': message,
        },
      );
      print(respes.statusCode.toString());
      final data = json.decode(respes.body);
      if (data['success'] != true) {
        setState(() {
          loading = !loading;
        });
        // ignore: deprecated_member_use
        _scaffoldKey.currentState.showSnackBar(
          new SnackBar(
            content: new Text(
                'failed,(We have a server error${data['message']}), Please try again later'),
          ),
        );
      } else {
        setState(() {
          loading = !loading;
        });
        showmyDialog(context: context);
      }
    } catch (e) {
      setState(() {
        loading = !loading;
      });
      // ignore: deprecated_member_use
      _scaffoldKey.currentState.showSnackBar(
        new SnackBar(
          content: new Text(
              'failed(We have a server error ${e.toString()}), Please try again  later '),
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
                  'Your submission was successful. Thank you!',
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
}
