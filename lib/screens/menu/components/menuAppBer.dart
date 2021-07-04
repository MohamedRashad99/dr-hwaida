import 'package:DrHwaida/constants/themes.dart';
import 'package:DrHwaida/models/user.dart';
import 'package:DrHwaida/models/utils.dart';
import 'package:DrHwaida/services/dataBase.dart';
import 'package:flutter/material.dart';

class MenuAppBer extends StatelessWidget {
  const MenuAppBer({
    Key key,
    @required this.width,
    @required this.userImageurl,
    @required this.userName,
  }) : super(key: key);

  final double width;
  final String userImageurl;
  final String userName;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Users>(
      stream: DatabaseServices(userToken: User.userToken, context: context)
          .userData,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          Users userData = snapshot.data;
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                children: [
                  Container(
                    height: 200,
                    // color: Colors.amber,
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment.topCenter,
                          child: Builder(
                            builder: (context) => Container(
                              height: 150,
                              child: Center(
                                child: Container(
                                  decoration: BoxDecoration(
                                    gradient: AppTheme.containerBackground,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 50,
                          right: (width * .4) - 65,
                          child: Stack(
                            children: [
                              Hero(
                                tag: 'userImg${userData.userImageUrl}',
                                child: Container(
                                  height: 150,
                                  width: 150,
                                  decoration: BoxDecoration(
                                    color: Colors.redAccent,
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        spreadRadius: 2,
                                        blurRadius: 10,
                                        color: Colors.black.withOpacity(0.1),
                                        offset: Offset(0, 10),
                                      ),
                                    ],
                                    border: Border.all(
                                      color: Colors.white,
                                      width: 2,
                                      style: BorderStyle.solid,
                                    ),
                                  ),
                                  child: CircleAvatar(
                                    radius: 55,
                                    backgroundColor: Colors.white,
                                    child: ClipOval(
                                      child: SizedBox(
                                        height: 150,
                                        width: 150,
                                        child: Image(
                                          image: (userData.userImageUrl != '')
                                              ? NetworkImage(
                                                  userData.userImageUrl,
                                                )
                                              : AssetImage(
                                                  Utils.userImageURL(
                                                    gender: userData.userGender,
                                                  ),
                                                ),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5),
              Hero(
                tag: 'UserName',
                child: Text(
                  userData.name,
                  style: AppTheme.heading,
                ),
              ),
            ],
          );
        } else {
          return Container(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}
