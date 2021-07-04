import 'package:DrHwaida/models/settinges.dart';
import 'package:DrHwaida/models/user.dart';
import 'package:DrHwaida/models/utils.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:DrHwaida/constants/constans.dart';

class CoutactUSApi {
  static Future<Settinges> gitContactUS() async {
    Settinges settinges;
    var response = await http.get(Uri.parse(Utils.SETTINGES_URL), headers: {
      'Accept': 'application/json',
      'x-api-key': User.userToken,
      'lang': apiLang(),
    });
    var jsonData = json.decode(response.body);
    try {
      if (response.statusCode == 200) {
        settinges = Settinges(
          rate_question: jsonData['data']['rate_question'],
          whatsappUrl: jsonData['data']['whatsapp'],
          facebookurl: jsonData['data']['facebook'],
          twitterurl: jsonData['data']['twitter'],
          contact_image: jsonData['data']['contact_image'],
        );
      }
    } catch (e) {
      print(e.toString());
    }
    return settinges;
  }
}
