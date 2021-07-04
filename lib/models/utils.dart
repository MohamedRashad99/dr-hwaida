import 'package:flutter/material.dart';

class Utils {
  //Functions
  static void showSnackBar(BuildContext context, String message) =>
      Scaffold.of(context)
        // ignore: deprecated_member_use
        ..hideCurrentSnackBar()
        // ignore: deprecated_member_use
        ..showSnackBar(
          SnackBar(content: Text(message)),
        );
  //gitUserImge
  static userImageURL({String gender}) {
    String imgURl;
    switch (gender) {
      case 'Male':
        imgURl = 'lib/images/man.png';
        return imgURl;
        break;
      case 'ذكر':
        imgURl = 'lib/images/man.png';
        return imgURl;
        break;
      case 'أنثى':
        imgURl = 'lib/images/female.png';
        return imgURl;
        break;
      case 'Female':
        imgURl = 'lib/images/female.png';
        return imgURl;
        break;
      case 'male':
        imgURl = 'lib/images/man.png';
        return imgURl;
        break;

      case 'female':
        imgURl = 'lib/images/female.png';
        return imgURl;
        break;
      default:
        imgURl = 'lib/images/man.png';
        return imgURl;
    }
  }

  // ignore: non_constant_identifier_names
  static final BASE_URL = "http://shaybhaleb.com/public/api";
  // ignore: non_constant_identifier_names
  static final Consultant_URL = BASE_URL + "/consultants";
  // ignore: non_constant_identifier_names
  static final Update_fcm_URL = BASE_URL + "/clients/update_fcm?fcm_token=";
  // ignore: non_constant_identifier_names
  static final EVENTS_URL = BASE_URL + "/events";
  // ignore: non_constant_identifier_names
  static final COURSES_URL = BASE_URL + "/courses";
  // ignore: non_constant_identifier_names
  static final CATEGORIES_URL = BASE_URL + "/categories";
  // ignore: non_constant_identifier_names
  static final RATE_URL = BASE_URL + "/rates/consultant";
  // ignore: non_constant_identifier_names
  static final COURSESRATE_URL = BASE_URL + "/rates/course";
  // ignore: non_constant_identifier_names
  static final REGISTER_URL = BASE_URL + "/clients/register";

  // ignore: non_constant_identifier_names
  static final REGISTERASCONSUL_URL = BASE_URL + "/requests";
  // ignore: non_constant_identifier_names
  static final LOGIN_URL = BASE_URL + "/clients/login";
  // ignore: non_constant_identifier_names
  static final GITUSERDATA_URL = BASE_URL + "/clients/profile";
  // ignore: non_constant_identifier_names
  static final UPDATEUSERDATA_URL = BASE_URL + "/clients/update";
  // ignore: non_constant_identifier_names
  static final CHANGEPASSWORD_URL = BASE_URL + "/clients/change_password";
  // ignore: non_constant_identifier_names
  static final CHECKOUT_URL = BASE_URL + "/make_order";
  // ignore: non_constant_identifier_names
  static final VISITS_URL = BASE_URL + "/visits";
  // ignore: non_constant_identifier_names
  static final MYCOURSRS_URL = BASE_URL + "/mycourses";
  // ignore: non_constant_identifier_names
  static final MYEVENTS_URL = BASE_URL + "/myevents";
  // ignore: non_constant_identifier_names
  static final SEARCHBYNAME_URL = BASE_URL + "/search?search=";
  // ignore: non_constant_identifier_names
  static final COURSESSEARCHBYNAME_URL = BASE_URL + "/courses_search?search=";
  // ignore: non_constant_identifier_names
  static final CONSULTFILLTER_URL = BASE_URL + "/filter";
  // ignore: non_constant_identifier_names
  static final FACEBOOK_URL = BASE_URL + "/social/facebook";
  // ignore: non_constant_identifier_names
  static final GOOGLE_URL = BASE_URL + "/social/google";
  // ignore: non_constant_identifier_names
  static final CoursesFILLTER_URL = BASE_URL + "/courses_filter";
  // ignore: non_constant_identifier_names
  static final CONTACTUS_URL = BASE_URL + "/send_message";
  // ignore: non_constant_identifier_names
  static final Featured_courses_URL = BASE_URL + "/featured_courses";
  // ignore: non_constant_identifier_names
  static final SETTINGES_URL = BASE_URL + "/settings";
  // ignore: non_constant_identifier_names
  static final AboutUS_URL = BASE_URL + "/about";
}
