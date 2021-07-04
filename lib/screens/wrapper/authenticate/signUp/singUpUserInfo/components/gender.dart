import 'package:DrHwaida/constants/constans.dart';
import 'package:DrHwaida/constants/themes.dart';
import 'package:DrHwaida/localization/localization_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Gender extends StatefulWidget {
  final gender;
  static String resGender;
  const Gender({
    Key key,
    this.gender,
  }) : super(key: key);

  @override
  _GenderState createState() => _GenderState();
}

class _GenderState extends State<Gender> {
  String _gender;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => showSettingsPanel(
        context: context,
        child: Stack(
          children: [
            CustomAppBar(
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  getTranslated(context, "gender"),
                  style: AppTheme.heading.copyWith(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        InkWell(
                          onTap: () {
                            setState(() {
                              _gender = getTranslated(context, "male");
                              Gender.resGender = 'male';
                            });
                            Navigator.of(context).pop();
                          },
                          child: Container(
                            height: 100,
                            width: 100,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(
                                  'lib/images/man.png',
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          getTranslated(context, "male"),
                          style: AppTheme.heading.copyWith(),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        InkWell(
                          onTap: () {
                            setState(() {
                              _gender = getTranslated(context, "female");
                              Gender.resGender = 'female';
                            });
                            Navigator.of(context).pop();
                          },
                          child: Container(
                            height: 100,
                            width: 100,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage('lib/images/female.png'),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          getTranslated(context, "female"),
                          style: AppTheme.heading.copyWith(),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
      child: Card(
        elevation: 2.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
          side: BorderSide(color: customColor),
        ),
        child: Container(
          height: 40,
          padding: EdgeInsets.all(8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    FontAwesomeIcons.venusMars,
                    color: Colors.grey[500],
                    size: 15,
                  ),
                  SizedBox(width: 5),
                  Text(
                    (_gender != null)
                        ? _gender
                        : (widget.gender != null && widget.gender != "null")
                            ? widget.gender
                            : getTranslated(context, "gender"),
                    style: AppTheme.heading.copyWith(
                      color: customColor,
                    ),
                  ),
                ],
              ),
              Icon(
                Icons.arrow_drop_down_circle_outlined,
                color: customColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
