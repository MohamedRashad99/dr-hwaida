import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:DrHwaida/models/user.dart';
import 'package:DrHwaida/models/utils.dart';

import '../sharedPreferences.dart';

class Auth {
  // ignore: close_sinks
  final StreamController<UserToken> controller =
      StreamController<UserToken>.broadcast(
    onCancel: () => print('cancel'),
    onListen: () => print('listen'),
  );

  registerWithPhoneAndPassword(
      {String phoneNummber,
      String password,
      String age,
      String name,
      String gender,
      String status}) async {
    try {
      var response = await http.post(
        Uri.parse(Utils.REGISTER_URL),
        body: {
          'name': name,
          'mobile': phoneNummber,
          'password': password,
          'password_confirmation': password,
          'age': age,
          'gender': gender,
          'status': status,
        },
      );

      Map<String, dynamic> data = json.decode(response.body);
      if (data['success'] == true) {
        User.userToken = data['data']['api_token'].toString();

        MySharedPreferences.saveUserSingIn(true);
        MySharedPreferences.saveUserSkipLogIn(false);
        MySharedPreferences.saveUserUserPassword(password);

        MySharedPreferences.saveUserUserName(
          data['data']['name'].toString(),
        );
        MySharedPreferences.saveUserUserPhoneNumber(
          data['data']['mobile'].toString(),
        );
        MySharedPreferences.saveUserUserGender(
          data['data']['gender'].toString(),
        );
        MySharedPreferences.saveUserUserAge(
          data['data']['age'].toString(),
        );
        MySharedPreferences.saveUserUserStutas(
          data['data']['status'].toString(),
        );
        MySharedPreferences.saveUserUserToken(
          data['data']['api_token'].toString(),
        );
      }
      controller.sink.add(_userFromDatabaseUser(data));
      return _userFromDatabaseUser(data);
    } catch (e) {
      print(e.toString());
    }
  }

  UserToken _userFromDatabaseUser(Map user) {
    print(user['data']['api_token'].toString());

    return user != null
        ? UserToken(userTohen: user['data']['api_token'])
        : null;
  }

  Stream<UserToken> get user {
    return controller.stream;
  }
}
