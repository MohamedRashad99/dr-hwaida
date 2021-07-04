class User {
  static String userToken;
  static String userName;
  static String userPhoneNum;
  static String userAge;
  static String userStutes;
  static String userGender;
  static String userPassword;
  static var appLang;
  static var apiLang;
  static String userlat;
  static String userlong;
  static String prefs;
  static bool userLogIn;
  static bool userSkipLogIn;
}

class UserToken {
  final String userTohen;

  UserToken({this.userTohen});
}

class Users {
  final String userToken;
  final String phoneNumber;
  final String name;
  final String email;
  final String userImageUrl;
  final String userAge;
  final String userBrDate;
  final String userStutes;
  final String userGender;

  Users({
    this.userAge,
    this.userBrDate,
    this.userStutes,
    this.userGender,
    this.name,
    this.email,
    this.phoneNumber,
    this.userImageUrl,
    this.userToken,
  });
}
