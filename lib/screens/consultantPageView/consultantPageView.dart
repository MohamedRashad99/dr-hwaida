import 'package:DrHwaida/constants/constans.dart';
import 'package:DrHwaida/constants/themes.dart';
import 'package:DrHwaida/localization/localization_constants.dart';
import 'package:DrHwaida/models/consultant.dart';
import 'package:DrHwaida/models/user.dart';
import 'package:DrHwaida/screens/Consultant/conponents/conSultantRating.dart';
import 'package:DrHwaida/screens/consultantPageView/counsultantRating.dart';
import 'package:DrHwaida/screens/scheduleAppo/scheduleAppo.dart';
import 'package:DrHwaida/services/network_sensitive.dart';
import 'package:flutter/material.dart';
import '../CustomBottomNavigationBar.dart';

class ConsultantPageView extends StatefulWidget {
  final Consultant consultant;
  final int consulId;
  const ConsultantPageView({
    Key key,
    this.consultant,
    this.consulId,
  }) : super(key: key);

  @override
  _ConsultantPageViewState createState() => _ConsultantPageViewState();
}

class _ConsultantPageViewState extends State<ConsultantPageView> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: customColor,
        toolbarHeight: 0,
      ),
      body: NetworkSensitive(
        child: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height - 100,
              child: ListView(
                shrinkWrap: true,
                primary: true,
                children: [
                  consultantData(context),
                  CounsultantRating(
                    id: widget.consultant.id,
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

  consultantData(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            height: 400,
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 20,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(15),
                bottomRight: Radius.circular(15),
              ),
              image: DecorationImage(
                image: NetworkImage(widget.consultant.image),
                fit: BoxFit.fitHeight,
              ),
            ),
            child: Align(
              alignment:
                  (apiLang() == "ar") ? Alignment.topRight : Alignment.topLeft,
              child: InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Icon(
                  Icons.arrow_back,
                  color: customColor,
                  size: 30,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 15,
            ),
            child: Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 20,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 1,
                          child: Text(
                            widget.consultant.name,
                            style: AppTheme.heading,
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            widget.consultant.experince +
                                getTranslated(context, "experience"),
                            style: AppTheme.heading,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 2,
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  RatingStar(
                                    isReadOnly: true,
                                    rating:
                                        double.parse(widget.consultant.rate),
                                  ),
                                  SizedBox(width: 10),
                                  Text(
                                    widget.consultant.rate,
                                    style: AppTheme.heading.copyWith(
                                      color: customColor,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10),
                              InkWell(
                                onTap: () {
                                  if (User.userSkipLogIn == false) {
                                    if (widget.consultant.mapLink != null) {
                                      launchInBrowser(
                                          widget.consultant.mapLink);
                                    } else {
                                      // ignore: deprecated_member_use
                                      _scaffoldKey.currentState.showSnackBar(
                                        new SnackBar(
                                          content: new Text(
                                            'This Consultant don\'t have map address',
                                          ),
                                        ),
                                      );
                                    }
                                  } else {
                                    showMyDialog(context: context);
                                  }
                                },
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.location_pin,
                                      color: Colors.black38,
                                      size: 20,
                                    ),
                                    SizedBox(width: 10),
                                    SizedBox(
                                      width: 150,
                                      child: Text(
                                        widget.consultant.address,
                                        style: AppTheme.heading.copyWith(
                                          decoration: TextDecoration.underline,
                                          fontSize: 10,
                                          color: customColor,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: CustomButtonWithchild(
                            color: customColor,
                            onPress: () {
                              if (User.userSkipLogIn != true) {
                                flitter(
                                  context: context,
                                  child: ConsultantRating(
                                    title: widget.consultant.name,
                                    consultant_id: widget.consultant.id,
                                  ),
                                );
                              } else {
                                showMyDialog(context: context);
                              }
                            },
                            child: Center(
                              child: Text(
                                getTranslated(context, "Review"),
                                style: AppTheme.heading.copyWith(
                                  fontSize: 10,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    // SizedBox(height: 10),

                    SizedBox(height: 10),
                    Text(
                      getTranslated(context, "About") +
                          ' ' +
                          widget.consultant.name,
                      style: AppTheme.heading,
                    ),
                    SizedBox(height: 10),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: Text(
                        parseHtmlString(widget.consultant.bio),
                        style: AppTheme.subHeading,
                      ),
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Row(
                              children: [
                                // Icon(
                                //   FontAwesomeIcons.poundSign,
                                //   color: Colors.black38,
                                //   size: 20,
                                // ),
                                SizedBox(width: 10),
                                Text(
                                  getTranslated(context, "Price"),
                                  style: AppTheme.heading
                                      .copyWith(
                                        fontSize: 15,
                                      )
                                      .copyWith(color: customColor),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            Row(
                              children: [
                                (widget.consultant.discount != '0')
                                    ? Text(
                                        widget.consultant.coust + ' EPG',
                                        style: AppTheme.subHeading.copyWith(
                                          color: customColorIcon,
                                          decoration:
                                              TextDecoration.lineThrough,
                                        ),
                                      )
                                    : Container(),
                                SizedBox(width: 10),
                                Text(
                                  widget.consultant.total_coust.toString() +
                                      ' EPG',
                                  style: AppTheme.heading.copyWith(),
                                ),
                              ],
                            ),
                          ],
                        ),
                        (widget.consultant.availableIn.isEmpty)
                            ? Container()
                            : Expanded(
                                flex: 2,
                                child: CustomButtonWithchild(
                                  onPress: () {
                                    if (User.userSkipLogIn == false) {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (_) => ScheduleAppo(
                                            consultant: widget.consultant,
                                          ),
                                        ),
                                      );
                                    } else {
                                      showMyDialog(context: context);
                                    }
                                  },
                                  child: Center(
                                    child: Text(
                                      getTranslated(
                                          context, "schedule_appoint"),
                                      textAlign: TextAlign.center,
                                      style: AppTheme.heading.copyWith(
                                        color: Colors.white,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                  color: customColor,
                                ),
                              ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
