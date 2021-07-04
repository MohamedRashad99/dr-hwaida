import 'package:DrHwaida/constants/constans.dart';
import 'package:DrHwaida/constants/themes.dart';
import 'package:DrHwaida/localization/localization_constants.dart';
import 'package:DrHwaida/models/prodact.dart';

import 'package:DrHwaida/screens/checkOut/checkOut.dart';
import 'package:DrHwaida/services/dbhelper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../CustomBottomNavigationBar.dart';

class Cart extends StatefulWidget {
  static List<ConsultantProdect> consultProdect = [];

  static SharedPreferences sharedPreferences;

  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  double totalPrice = 0.0;
  DbHehper helper;

  @override
  void initState() {
    helper = DbHehper();

    super.initState();
  }

  culcTotalPrice(double price) {
    totalPrice = totalPrice + price;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        toolbarHeight: 80,
        title: (Text(
          getTranslated(context, "Cart"),
          style: AppTheme.heading.copyWith(
            color: Colors.white,
          ),
        )),
      ),
      body: FutureBuilder(
        future: helper.allProduct(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return Stack(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height - 200,
                  child: ListView(
                    shrinkWrap: true,
                    primary: true,
                    children: [
                      SizedBox(height: 20),
                      ListView.builder(
                        shrinkWrap: true,
                        primary: false,
                        itemCount: snapshot.data.length,
                        padding:
                            EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                        itemBuilder: (context, index) {
                          culcTotalPrice(
                            snapshot.data[index]['price'],
                          );
                          return Column(
                            children: [
                              Card(
                                elevation: 3,
                                child: Column(
                                  children: [
                                    ListTile(
                                      title: Row(
                                        children: [
                                          Text(
                                            getTranslated(context, "title") +
                                                ' : ',
                                            style: AppTheme.heading.copyWith(
                                              color: customColor,
                                            ),
                                          ),
                                          Text(
                                            snapshot.data[index]['title'],
                                            style: AppTheme.subHeading.copyWith(
                                              fontSize: 12,
                                            ),
                                          ),
                                        ],
                                      ),
                                      subtitle: Row(
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                getTranslated(
                                                        context, "Price") +
                                                    ' : ',
                                                style:
                                                    AppTheme.heading.copyWith(
                                                  color: customColor,
                                                ),
                                              ),
                                              Text(
                                                snapshot.data[index]['price']
                                                    .toString(),
                                                style: AppTheme.subHeading
                                                    .copyWith(
                                                  fontSize: 12,
                                                ),
                                              ),
                                              Icon(
                                                FontAwesomeIcons.poundSign,
                                                color: Colors.black,
                                                size: 10,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      trailing: IconButton(
                                        icon: Icon(
                                          Icons.delete,
                                          size: 30,
                                          color: Colors.red,
                                        ),
                                        onPressed: () async {
                                          setState(() {
                                            totalPrice = totalPrice -
                                                snapshot.data[index]['price'];
                                          });

                                          await helper.deleteProduct(
                                              snapshot.data[index]['id']);
                                        },
                                      ),
                                      leading: CircleAvatar(
                                        maxRadius: 30,
                                        backgroundImage: NetworkImage(
                                          snapshot.data[index]["proImageUrl"],
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 20),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          (snapshot.data[index]['date'] == null)
                                              ? Container()
                                              : Row(
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Text(
                                                          getTranslated(context,
                                                                  "Date") +
                                                              ' : ',
                                                          style: AppTheme
                                                              .heading
                                                              .copyWith(
                                                            color: customColor,
                                                          ),
                                                        ),
                                                        Text(
                                                          snapshot.data[index]
                                                              ['date'],
                                                          style: AppTheme
                                                              .subHeading
                                                              .copyWith(
                                                            fontSize: 12,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                          (snapshot.data[index]['time'] == null)
                                              ? Container()
                                              : Row(
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Text(
                                                          getTranslated(context,
                                                                  "Time") +
                                                              ' : ',
                                                          style: AppTheme
                                                              .heading
                                                              .copyWith(
                                                            color: customColor,
                                                          ),
                                                        ),
                                                        Text(
                                                          snapshot.data[index]
                                                              ['time'],
                                                          style: AppTheme
                                                              .subHeading
                                                              .copyWith(
                                                            fontSize: 12,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              (index == snapshot.data.length - 1)
                                  ? totalPrieCard(
                                      context: context,
                                      consualtId: snapshot.data[index]
                                          ['consultantId'],
                                      availableId: snapshot.data[index]
                                          ['dateId'],
                                      prodectId: snapshot.data[index]['id'],
                                      availableDate: snapshot.data[index]
                                          ['date'],
                                      snapshot: snapshot,
                                    )
                                  : Container(),
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: CustomBottomNavigationBar(),
                ),
              ],
            );
          }
        },
      ),
    );
  }

  totalPrieCard({
    BuildContext context,
    int consualtId,
    int availableId,
    int prodectId,
    String availableDate,
    AsyncSnapshot snapshot,
  }) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
              side: BorderSide(color: customColor),
            ),
            elevation: 3,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        getTranslated(context, "Total_Price") + ' : ',
                        style: AppTheme.heading.copyWith(color: customColor),
                      ),
                      Text(
                        totalPrice.toString(),
                        style: AppTheme.heading,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        CustomButtonWithchild(
          color: customColor,
          onPress: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => CheckOut(
                  totalPrice: totalPrice.toString(),
                  consultantid: consualtId,
                  avilableId: availableId,
                  productId: prodectId,
                  avilableDate: availableDate,
                  data: snapshot,
                ),
              ),
            );
          },
          child: Text(
            getTranslated(context, "CheckOut"),
            style: AppTheme.heading.copyWith(
              fontSize: 16,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
