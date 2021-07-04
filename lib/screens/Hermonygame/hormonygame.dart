import 'package:DrHwaida/constants/constans.dart';
import 'package:DrHwaida/constants/themes.dart';
import 'package:DrHwaida/models/visaCard.dart';
import 'package:DrHwaida/screens/CustomBottomNavigationBar.dart';
import 'package:DrHwaida/screens/Hermonygame/playWait.dart';
import 'package:DrHwaida/screens/wrapper/home/home.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class HormonyGame extends StatefulWidget {
  @override
  _HormonyGameState createState() => _HormonyGameState();
}

class _HormonyGameState extends State<HormonyGame> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        title: Text(
          'Hormony Game',
          style: AppTheme.heading.copyWith(
            color: Colors.white,
          ),
        ),
        leading: (IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            setState(() {
              Helper.tappedBottomShet = 0;
            });
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (_) => Home(),
              ),
            );
          },
        )),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(),
      body: ListView(
        shrinkWrap: true,
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    FontAwesomeIcons.gamepad,
                    color: customColor,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Start play with partner Online',
                    style: AppTheme.heading.copyWith(
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                child: Form(
                  child: IntlPhoneField(
                    initialCountryCode: 'EG',
                    decoration: InputDecoration(
                      labelText: 'Enter phone number your partner',
                      labelStyle: AppTheme.subHeading,
                    ),
                    onChanged: (phone) {
                      print(phone.completeNumber);
                    },
                  ),
                ),
              ),
              SizedBox(height: 30),
              CustomButtonWithchild(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      FontAwesomeIcons.whatsapp,
                      color: Colors.white,
                    ),
                    SizedBox(width: 10),
                    Text(
                      'share link Whattsapp',
                      style: AppTheme.heading.copyWith(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                color: Color(0xfff05cd51),
                onPress: () {},
              ),
              CustomButtonWithchild(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      FontAwesomeIcons.facebookMessenger,
                      color: Colors.white,
                    ),
                    SizedBox(width: 10),
                    Text(
                      'share link Messenger',
                      style: AppTheme.heading.copyWith(
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
                color: Color(0xfff4867aa),
                onPress: () {},
              ),
              SizedBox(height: 30),
              CustomButtonWithchild(
                child: Text(
                  'Ok',
                  style: AppTheme.heading.copyWith(
                    color: Colors.white,
                  ),
                ),
                color: customColor,
                onPress: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => PlayingWait(),
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
