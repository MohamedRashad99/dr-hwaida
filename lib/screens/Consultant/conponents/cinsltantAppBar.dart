import 'package:DrHwaida/constants/constans.dart';
import 'package:DrHwaida/constants/themes.dart';
import 'package:DrHwaida/localization/localization_constants.dart';
import 'package:DrHwaida/screens/Consultant/conponents/consultantsearch.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'consultantfillter.dart';

Container consultantAppBer(BuildContext context) {
  return Container(
    width: MediaQuery.of(context).size.width,
    height: 60,
    padding: EdgeInsets.symmetric(horizontal: 10),
    decoration: BoxDecoration(
      gradient: AppTheme.containerBackground,
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(Icons.arrow_back),
            ),
            IconButton(
              onPressed: () {
                showSearch(
                  context: context,
                  delegate: ConusltantSearch(),
                );
              },
              icon: Icon(Icons.search),
            ),
          ],
        ),
        Text(
          getTranslated(context, "consultants"),
          style: AppTheme.heading.copyWith(
            color: Colors.white,
          ),
        ),
        IconButton(
          onPressed: () {
            flitter(
              context: context,
              child: ConsultantFillter(),
            );
          },
          icon: Transform.rotate(
            angle: 180 * 3.14 / 365,
            child: SvgPicture.asset(
              "assets/icons/filter.svg",
              color: Colors.white,
              height: 25,
            ),
          ),
        ),
      ],
    ),
  );
}
