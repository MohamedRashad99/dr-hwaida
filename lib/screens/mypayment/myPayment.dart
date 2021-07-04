import 'package:DrHwaida/constants/constans.dart';
import 'package:DrHwaida/constants/themes.dart';
import 'package:DrHwaida/models/utils.dart';
import 'package:DrHwaida/models/visaCard.dart';
import 'package:DrHwaida/screens/checkOut/components/creatVisaCard.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MyPayment extends StatefulWidget {
  @override
  _MyPaymentState createState() => _MyPaymentState();
}

class _MyPaymentState extends State<MyPayment> {
  @override
  Widget build(BuildContext context) {
    if (Helper.visaCardList.isEmpty) {
      return Scaffold(
        appBar: customAppBar(title: 'My Payment'),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            // ignore: deprecated_member_use
            child: FlatButton.icon(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
                side: BorderSide(
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => AddFileBottomSheet(),
                  ),
                );
              },
              color: customColor,
              icon: Icon(
                FontAwesomeIcons.moneyCheckAlt,
                color: Colors.white,
                size: 20,
              ),
              label: Text(
                'Add Card',
                style: AppTheme.subHeading.copyWith(
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      );
    }
    return Scaffold(
      appBar: customAppBar(title: 'My Payment'),
      body: ListView.separated(
        itemCount: Helper.visaCardList.length,
        scrollDirection: Axis.vertical,
        separatorBuilder: (context, index) => Divider(),
        itemBuilder: (context, index) {
          final item = Helper.visaCardList[index];

          return DismissibleWidget(
            item: item,
            child: Card(
              elevation: 3,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          FontAwesomeIcons.ccVisa,
                          color: Colors.blue,
                        ),
                        SizedBox(width: 10),
                        Column(
                          children: [
                            Text(
                              "Card Number",
                              style: AppTheme.subHeading,
                            ),
                            SizedBox(height: 10),
                            Text("Expriy Date"),
                          ],
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          "${item.cardNumber.substring(0, 3)}*********",
                          style: AppTheme.subHeading,
                        ),
                        SizedBox(height: 10),
                        Text(
                          "${item.exDate}",
                          style: AppTheme.subHeading,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            onDismissed: (direction) => dismissItem(context, index, direction),
          );
        },
      ),
    );
  }

  void dismissItem(
      BuildContext context, int index, DismissDirection direction) {
    setState(() {
      Helper.visaCardList.removeAt(index);
    });

    switch (direction) {
      case DismissDirection.endToStart:
        Utils.showSnackBar(context, "deleting_done");
        break;
      default:
        break;
    }
  }
}
