import 'package:DrHwaida/constants/constans.dart';
import 'package:DrHwaida/constants/themes.dart';
import 'package:DrHwaida/models/visaCard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class AddFileBottomSheet extends StatefulWidget {
  @override
  _AddFileBottomSheetState createState() => _AddFileBottomSheetState();
}

class _AddFileBottomSheetState extends State<AddFileBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 20,
        ),
        children: [
          Center(
            child: Text(
              'Payment Method',
              style: AppTheme.heading.copyWith(
                color: customColor,
              ),
            ),
          ),
          Form(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 40),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: conectedTextFormStyle(lableText: 'Card Number'),
                ),
                SizedBox(height: 25),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: conectedTextFormStyle(lableText: 'CVV'),
                ),
                SizedBox(height: 25),
                InkWell(
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
                          Helper.chossenDate = "${date.month}/${date.year}";
                        });
                      },
                      currentTime: DateTime.now(),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 10,
                    ),
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(35),
                      border: Border.all(color: customColor),
                    ),
                    child: Text(
                      (Helper.chossenDate == '')
                          ? 'Expiry Date'
                          : Helper.chossenDate,
                      style: AppTheme.heading.copyWith(
                        color: customColor,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Set asprimary payment',
                      style: AppTheme.heading,
                    ),
                    Switch(
                      activeColor: customColor,
                      value: Helper.status,
                      onChanged: (value) {
                        print("VALUE : $value");
                        setState(() {
                          Helper.status = value;
                        });
                      },
                    ),
                  ],
                ),
                SizedBox(height: 25),
                CustomButtonWithchild(
                  color: customColor,
                  onPress: () {
                    setState(() {
                      Helper.cardConut = Helper.cardConut + 1;
                    });
                    print('CardConut:${Helper.cardConut}');
                    Helper.visaCardList.add(
                      VisaCard(
                        cardNumber: '333333333333333',
                        exDate: '02/2021',
                        cVV: '2121',
                        index: Helper.cardConut,
                      ),
                    );
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'Save',
                    style: AppTheme.heading.copyWith(color: Colors.white),
                  ),
                ),
                SizedBox(height: 25),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
