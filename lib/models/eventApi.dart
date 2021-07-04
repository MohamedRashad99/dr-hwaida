import 'package:DrHwaida/models/events.dart';
import 'package:DrHwaida/models/user.dart';
import 'package:DrHwaida/models/utils.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:DrHwaida/constants/constans.dart';

class EventsApi {
  static Future<List<CustomEvent>> fetchAllEvent() async {
    List<CustomEvent> listOfEvent = [];

    try {
      var response = await http.get(Uri.parse(Utils.EVENTS_URL), headers: {
        // 'Accept': 'application/json',
        'x-api-key': User.userToken,
        "Connection": "keep-alive",
        'lang': apiLang(),
      });
      var jsonData = json.decode(response.body);
      if (response.statusCode == 200) {
        for (var items in jsonData['data']) {
          CustomEvent event = CustomEvent(
            id: items['id'],
            start_date: items['start_date'],
            start_time: items['start_time'],
            end_date: items['end_date'],
            end_time: items['end_time'],
            video: items['video'],
            type: items['type'],
            price: items['price'],
            discount: items['discount'],
            features: items['features'],
            title: items['name'],
            contant: items['details'],
            imageUl: items['image_path'],
          );
          listOfEvent.add(event);
        }
      }
    } catch (e) {
      print(e);
    }
    return listOfEvent;
  }

  static Future<List<CustomEvent>> fetchMyEvent() async {
    List<CustomEvent> listOfEvent = [];

    try {
      var response = await http.get(Uri.parse(Utils.MYEVENTS_URL), headers: {
        'Accept': 'application/json',
        'x-api-key': User.userToken,
        "Connection": "keep-alive",
        'lang': User.apiLang,
      });
      var jsonData = json.decode(response.body);
      if (response.statusCode == 200) {
        for (var items in jsonData['data']) {
          CustomEvent event = CustomEvent(
            id: items['id'],
            start_date: items['start_date'],
            start_time: items['start_time'],
            end_date: items['end_date'],
            end_time: items['end_time'],
            video: items['video'],
            type: items['type'],
            price: items['price'],
            discount: items['discount'],
            features: items['features'],
            title: items['name'],
            contant: items['details'],
            imageUl: items['image_path'],
          );
          listOfEvent.add(event);
        }
      }
    } catch (e) {
      print(e);
    }
    return listOfEvent;
  }
}
