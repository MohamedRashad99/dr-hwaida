import 'package:DrHwaida/constants/themes.dart';
// import 'package:DrHwaida/screens/Consultant/conponents/consultantsearch.dart';
import 'package:DrHwaida/screens/cart/cart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomHomeAppBer extends StatelessWidget {
  const CustomHomeAppBer({
    Key key,
    @required this.scaffoldKey,
  }) : super(key: key);

  final GlobalKey<ScaffoldState> scaffoldKey;

  @override
  Widget build(BuildContext context) {
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
                onPressed: () => scaffoldKey.currentState.openDrawer(),
                icon: Icon(Icons.menu),
              ),
              // IconButton(
              //   onPressed: () {
              //     showSearch(
              //       context: context,
              //       delegate: ConusltantSearch(),
              //     );
              //   },
              //   icon: Icon(Icons.search),
              // ),
            ],
          ),
          IconButton(
            icon: Icon(
              FontAwesomeIcons.cartPlus,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => Cart(),
                ),
              );
            },
          ),

          // GestureDetector(
          //   onTap: () {
          //     Navigator.of(context).push(
          //       MaterialPageRoute(
          //         builder: (_) => Notificatios(),
          //       ),
          //     );
          //   },
          //   child: Stack(
          //     children: [
          //       Icon(
          //         Icons.notifications,
          //         size: 25,
          //       ),
          //       Positioned(
          //         top: 0,
          //         right: 0,
          //         child: Container(
          //           height: 15,
          //           width: 15,
          //           // margin: EdgeInsets.all(5),
          //           decoration: BoxDecoration(
          //             shape: BoxShape.circle,
          //             color: Colors.red,
          //           ),
          //           child: Center(
          //             child: Text(
          //               '3',
          //               style: AppTheme.subHeading.copyWith(
          //                 color: Colors.white,
          //                 fontSize: 10,
          //               ),
          //             ),
          //           ),
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }
}
