import 'package:DrHwaida/models/consultant.dart';
import 'package:DrHwaida/models/user.dart';
import 'package:DrHwaida/models/utils.dart';
import 'package:DrHwaida/models/visits.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

class VisitsApi {
  static Future<List<Visits>> fetchAllVisit() async {
    List<Visits> listofVisits = [];

    var response = await http.get(Uri.parse(Utils.VISITS_URL), headers: {
      'x-api-key': User.userToken,
      'lang': User.apiLang,
    });
    var jsonData = json.decode(response.body);
    print(User.userToken);
    try {
      if (response.statusCode == 200) {
        for (var itmes in jsonData['data']) {
          Consultant consultant = Consultant(
            id: itmes['consultant']['id'],
            name: itmes['consultant']['name'],
            bio: itmes['consultant']['bio'],
            address: itmes['consultant']['address'],
            image: itmes['consultant']['image'],
            experince: itmes['consultant']['experince'],
            coust: itmes['consultant']['cost'],
            discount: itmes['consultant']['discount'],
            total_coust:
                double.parse(itmes['consultant']['total_cost'].toString()),
            rate: itmes['consultant']['rate'],
            availableIn: itmes['consultant']['days'],
            mapLink: itmes['consultant']['map_link'],
            badges: itmes['consultant']['badges'],
            question: itmes['consultant']['question'],
          );
          Visits visits = Visits(
            id: itmes['id'],
            status: itmes['status'],
            rate: itmes['consultant']['rate'],
            payment_method: itmes['payment_method'],
            date: itmes['visit_date'],
            time: itmes['available']['time'],
            day: itmes['available']['date'],
            consultantId: itmes['consultant']['id'],
            name: itmes['consultant']['name'],
            total_cost: itmes['consultant']['total_cost'],
            consultant: consultant,
          );
          listofVisits.add(visits);
        }
      } else {
        print('statusCode:' + response.statusCode.toString());
      }
    } catch (e) {
      print(e.toString());
    }
    return listofVisits;
  }
}
