import 'package:DrHwaida/constants/constans.dart';
import 'package:DrHwaida/constants/themes.dart';
import 'package:DrHwaida/localization/localization_constants.dart';
import 'package:DrHwaida/models/user.dart';
import 'package:DrHwaida/screens/Consultant/conponents/consultantfillter.dart';
import 'package:DrHwaida/screens/onboarding/slider.dart';
import 'package:DrHwaida/screens/wrapper/authenticate/authenticate.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:DrHwaida/screens/Consultant/consultant.dart';

import '../../sharedPreferences.dart';

class OnBoard extends StatefulWidget {
  @override
  _OnBoardState createState() => _OnBoardState();
}

class _OnBoardState extends State<OnBoard> {
  gitCurrentLocations() async {
    try {
      final geoposition = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      setState(() {
        MySharedPreferences.saveUserlong('${geoposition.longitude}');
        MySharedPreferences.saveUserlat('${geoposition.latitude}');
      });
    } catch (e) {
      print('geoposition Erorr:' + e.toString());
    }
  }

  saveFillterIndex() async {
    User.userlat = await MySharedPreferences.getUserLat();
    User.userlong = await MySharedPreferences.getUserlong();
    // User.apiLang = await MySharedPreferences.getApiLang();
    if (User.userlat != null && User.userlong != null) {
      MySharedPreferences.saveFilltterIndex(0);
      MySharedPreferences.saveFilltterType('location');
    } else {
      MySharedPreferences.saveFilltterIndex(1);
      MySharedPreferences.saveFilltterType('recent');
    }
  }

  gitFillterIndex() async {
    ConsultantFillter.filtterTapped =
        await MySharedPreferences.getFiltterIndex();
    ConsultantPage.fillter = await MySharedPreferences.getFiltterType();
  }

  @override
  void initState() {
    gitCurrentLocations();
    saveFillterIndex();
    gitFillterIndex();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (User.userLogIn == true) {
      return Authenticate();
    } else {
      return OnBoarding();
    }
  }
}

class OnBoarding extends StatefulWidget {
  @override
  _OnBoardingState createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  int _currentPage = 0;
  PageController _controller = PageController();

  _onChanged(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _pages = [
      CustomSlider(
        // title: 'Title',
        contant: getTranslated(context, 'onBord1'),
        image: 'lib/images/img3.png',
        backImage: 'lib/images/back2.png',
      ),
      CustomSlider(
        // title: 'Title',
        contant: getTranslated(context, 'onBord2'),
        image: 'lib/images/img1.png',
        backImage: 'lib/images/back3.png',
      ),
      CustomSlider(
        // title: 'Title',
        contant: getTranslated(context, 'onBord3'),
        image: 'lib/images/img2.png',
        backImage: 'lib/images/back2.png',
      ),
    ];
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                PageView.builder(
                  scrollDirection: Axis.horizontal,
                  controller: _controller,
                  itemCount: _pages.length,
                  onPageChanged: _onChanged,
                  itemBuilder: (context, int index) {
                    return _pages[index];
                  },
                ),
                CustomAppBar(
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 100,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('lib/images/logo.png'),
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SliderContoler(
            pages: _pages,
            currentPage: _currentPage,
          ),
        ],
      ),
    );
  }
}

class SliderContoler extends StatelessWidget {
  const SliderContoler({
    Key key,
    @required List<Widget> pages,
    @required int currentPage,
  })  : _pages = pages,
        _currentPage = currentPage,
        super(key: key);

  final List<Widget> _pages;
  final int _currentPage;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List<Widget>.generate(
            _pages.length,
            (int index) {
              return AnimatedContainer(
                duration: Duration(milliseconds: 300),
                height: 10,
                width: (index == _currentPage) ? 30 : 10,
                margin: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: (index == _currentPage)
                      ? customColor
                      : customColor.withOpacity(0.5),
                ),
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              InkWell(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => Authenticate(),
                    ),
                  );
                },
                child: Row(
                  children: [
                    Text(
                      getTranslated(context, "skip"),
                      style: AppTheme.heading.copyWith(color: customColor),
                    ),
                    Transform.rotate(
                      angle: 180 * 3.14 / 180,
                      child: Icon(
                        Icons.arrow_back,
                        color: customColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
