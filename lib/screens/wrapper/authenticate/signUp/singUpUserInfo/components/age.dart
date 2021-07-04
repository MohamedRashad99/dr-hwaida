import 'package:DrHwaida/constants/constans.dart';
import 'package:DrHwaida/constants/themes.dart';
import 'package:DrHwaida/localization/localization_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class Age extends StatefulWidget {
  final age;
  static String resAge;
  const Age({
    Key key,
    this.age,
  }) : super(key: key);

  @override
  _AgeState createState() => _AgeState();
}

class _AgeState extends State<Age> {
  String _chossenDate;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        DatePicker.showDatePicker(
          context,
          showTitleActions: true,
          minTime: new DateTime(1900),
          onChanged: (date) {
            print('change $date in time zone ' +
                date.timeZoneOffset.inHours.toString());
          },
          onConfirm: (date) {
            setState(() {
              _chossenDate = "${date.year}-${date.month}-${date.day}";
              Age.resAge = _chossenDate;
            });
            print('confirm $date');
          },
          currentTime: DateTime.now(),
        );
      },
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
                    Icons.person,
                    color: Colors.grey[500],
                    size: 15,
                  ),
                  SizedBox(width: 5),
                  Text(
                    (_chossenDate != null)
                        ? _chossenDate
                        : (widget.age != null && widget.age != "null")
                            ? widget.age
                            : getTranslated(context, "age"),
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
