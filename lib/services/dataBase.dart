import 'dart:async';
import 'dart:convert';
import 'package:DrHwaida/constants/constans.dart';
import 'package:DrHwaida/constants/themes.dart';
import 'package:DrHwaida/localization/localization_constants.dart';
import 'package:DrHwaida/screens/userProfile/userprofile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:DrHwaida/models/user.dart';
import 'package:DrHwaida/models/utils.dart';
import 'dart:io';
import 'package:dio/dio.dart';

class DatabaseServices {
  final String userToken;
  final BuildContext context;
  final controller = StreamController<Users>();
  DatabaseServices({@required this.context, this.userToken});
  Map<String, dynamic> map;
  gituserData() async {
    try {
      var response = await http.get(
        Uri.parse(Utils.GITUSERDATA_URL),
        headers: {
          'x-api-key': userToken,
          'lang': apiLang(),
        },
      );
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        print(response.statusCode.toString());
        final user = _userFromDatabaseUser(data, context);
        controller.add(user);
      } else if (response.statusCode == 201) {
        final data = json.decode(response.body);

        final user = _userFromDatabaseUser(data, context);
        controller.add(user);
      } else {
        print(response.statusCode.toString());
      }
    } catch (e) {
      print(e.toString());
    }
  }

  upDateUserData({
    String phoneNummber,
    String age,
    String name,
    String gender,
    String status,
    File userImage,
    String userEmail,
    BuildContext context,
  }) async {
    try {
      var data;
      if (userImage != null) {
        String image = userImage.path.split('/').last;
        data = FormData.fromMap({
          "image": await MultipartFile.fromFile(
            userImage.path,
            filename: image,
          ),
          'name': "$name",
          'age': "$age",
          'gender': "$gender",
          'status': "$status",
          'mobile': "$phoneNummber",
          'email': "$userEmail",
        });
      } else {
        data = FormData.fromMap({
          "image": null,
          'name': "$name",
          'age': "$age",
          'gender': "$gender",
          'status': "$status",
          'mobile': "$phoneNummber",
          'email': "$userEmail",
        });
      }
      print("User.userToken:${User.userToken}");
      Dio dio = new Dio();
      dio.options.headers['x-api-key'] = User.userToken;

      Response response = await dio.post(Utils.UPDATEUSERDATA_URL, data: data);
      print(response.statusCode.toString());
      if (response.statusCode == 200) {
        if (response.data['success'] != false) {
          UserProfile.loading = !UserProfile.loading;
          showMyDialog(
              context: context,
              message: getTranslated(context, "savaProChange"));
        } else {
          showMyDialog(context: context, message: response.data['message']);
        }
      } else if (response.statusCode == 429) {
        UserProfile.loading = !UserProfile.loading;

        showCatchDialog(
          context: context,
          message: getTranslated(context, 'trylater'),
        );
      } else if (response.statusCode == 500) {
        UserProfile.loading = !UserProfile.loading;

        showCatchDialog(
          context: context,
          message: getTranslated(context, 'catchError'),
        );
      } else {
        UserProfile.loading = !UserProfile.loading;

        showCatchDialog(
          context: context,
          message: getTranslated(context, 'catchError'),
        );
      }
    } catch (e) {
      print('Update Ussser Data');
      print(e.toString());

      UserProfile.loading = !UserProfile.loading;

      showCatchDialog(
        context: context,
        message: getTranslated(context, 'catchError'),
      );
    }
  }

  Users _userFromDatabaseUser(Map user, BuildContext context) {
    return user != null
        ? Users(
            name: user['data']['name'].toString(),
            userBrDate: user['data']['dob'].toString(),
            phoneNumber: (user['data']['mobile'] != null)
                ? user['data']['mobile'].toString()
                : getTranslated(context, 'addPhone'),
            userGender: user['data']['gender'].toString(),
            userAge: user['data']['age'].toString(),
            userStutes: user['data']['status'].toString(),
            userImageUrl: user['data']['image'],
            email: (user['data']['email'] != null)
                ? user['data']['email'].toString()
                : getTranslated(context, 'addEmail'),
          )
        : null;
  }

  Stream<Users> get userData {
    gituserData();
    return controller.stream;
  }
}

Future<void> showMyDialog({BuildContext context, var message}) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text(
                message,
                style: AppTheme.heading.copyWith(
                  color: customColor,
                ),
              ),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: Text(
              getTranslated(context, 'Cancel'),
              style: AppTheme.heading.copyWith(
                color: customColor,
              ),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
