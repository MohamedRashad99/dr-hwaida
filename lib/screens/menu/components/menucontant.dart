import 'package:DrHwaida/constants/constans.dart';
import 'package:DrHwaida/constants/themes.dart';
import 'package:flutter/material.dart';

class MenuContent extends StatelessWidget {
  final String title;
  final IconData icon;
  final Function onTap;
  const MenuContent({
    Key key,
    @required this.title,
    @required this.icon,
    @required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(
                icon,
                color: customColorIcon,
                size: 20,
              ),
              SizedBox(width: 20),
              Text(
                title,
                style: AppTheme.heading.copyWith(
                  color: customColor,
                ),
              ),
            ],
          ),
          // Transform.rotate(
          //   angle: 180 * 3.14 / 180,
          //   child: Icon(
          //     Icons.arrow_back_ios,
          //     color: customColorIcon,
          //   ),
          // ),
        ],
      ),
    );
  }
}
