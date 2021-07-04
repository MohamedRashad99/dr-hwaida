import 'package:DrHwaida/constants/constans.dart';
import 'package:DrHwaida/constants/themes.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class VisaCard extends StatelessWidget {
  const VisaCard({
    Key key,
    @required this.visaName,
    @required this.visaNumber,
    @required this.date,
    @required this.price,
    @required this.userName,
  }) : super(key: key);

  final String visaName;
  final String visaNumber;
  final String date;
  final String price;
  final String userName;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
              color: Colors.grey[300],
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(
                    FontAwesomeIcons.ccVisa,
                    color: customColor,
                    size: 40,
                  ),
                  Text(
                    visaName,
                    style: AppTheme.heading,
                  ),
                  Text(
                    visaNumber.substring(0, 3) + '*************',
                    style: AppTheme.heading,
                  ),
                ],
              ),
              SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    date,
                    style: AppTheme.heading,
                  ),
                  Text(
                    '\$' + price,
                    style: AppTheme.heading,
                  ),
                ],
              ),
              SizedBox(height: 15),
              Text(
                userName,
                style: AppTheme.heading.copyWith(
                  color: customColor,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 20),
      ],
    );
  }
}
