import 'package:DrHwaida/constants/constans.dart';
import 'package:DrHwaida/models/consultant.dart';
import 'package:DrHwaida/models/user.dart';
import 'package:DrHwaida/models/utils.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'consulRate.dart';

class ConsultantApi {
  static Future<List<Consultant>> fetchAllConsultant() async {
    List<Consultant> listOfConsultant = [];
    List<AvailableTimes> listOfTime = [];
    List<ConsulAvailable> listOfConsulAvailable = [];

    try {
      var response = await http.get(Uri.parse(Utils.Consultant_URL), headers: {
        'Accept': 'application/json',
        'x-api-key': User.userToken,
        "Connection": "keep-alive",
        'lang': apiLang(),
      });
      var jsonData = json.decode(response.body);
      if (response.statusCode == 200) {
        for (var itmes in jsonData['data']) {
          listOfConsulAvailable = [];
          listOfTime = [];
          if (itmes['days'] != null) {
            for (var item in itmes['days']) {
              for (var i in item['times']) {
                AvailableTimes times = AvailableTimes(
                  id: i['id'],
                  date: i['date'],
                  time: i['time'],
                );
                listOfTime.add(times);
              }
              ConsulAvailable consulAvailable = ConsulAvailable(
                  availableTimes: listOfTime, date: item['date']);
              listOfConsulAvailable.add(consulAvailable);
            }
            // print('this times is: ${listOfConsulAvailable}');
          }

          Consultant consultant = Consultant(
            id: itmes['id'],
            name: itmes['name'],
            bio: itmes['bio'],
            address: itmes['address'],
            image: itmes['image'],
            experince: itmes['experince'],
            coust: itmes['cost'],
            discount: itmes['discount'],
            total_coust: double.parse(itmes['total_cost'].toString()),
            rate: itmes['rate'],
            available_in: listOfConsulAvailable,
            availableIn: itmes['days'],
            mapLink: itmes['map_link'],
            badges: itmes['badges'],
            question: itmes['question'],
          );

          listOfConsultant.add(consultant);
        }
      } else {
        print('StatusCodeeRRROE:' + response.statusCode.toString());
      }
    } catch (e) {
      print(e.toString());
      print('eroooooooooooor');
    }
    return listOfConsultant;
  }

  static Future<Consultant> fetchConsultantById(int id) async {
    List<Consultant> listOfConsultant = [];
    List<AvailableTimes> listOfTime = [];
    List<ConsulAvailable> listOfConsulAvailable = [];
    Consultant consultant;

    try {
      var response =
          await http.get(Uri.parse(Utils.Consultant_URL + "/$id"), headers: {
        'Accept': 'application/json',
        "Connection": "keep-alive",
        'lang': apiLang(),
      });
      Map<String, dynamic> jsonData = json.decode(response.body);
      if (response.statusCode == 200) {
        print('done');

        listOfConsulAvailable = [];
        listOfTime = [];
        if (jsonData['data']['available_in'] != null) {
          for (var item in jsonData['data']['available_in']) {
            for (var i in item['times']) {
              AvailableTimes times = AvailableTimes(
                id: i['id'],
                date: i['date'],
                time: i['time'],
              );
              listOfTime.add(times);
            }
            ConsulAvailable consulAvailable =
                ConsulAvailable(availableTimes: listOfTime, date: item['date']);
            listOfConsulAvailable.add(consulAvailable);
          }
        }

        consultant = Consultant(
          id: jsonData['data']['id'],
          name: jsonData['data']['name'],
          bio: jsonData['data']['bio'],
          address: jsonData['data']['address'],
          image: jsonData['data']['image'],
          experince: jsonData['data']['experince'],
          coust: jsonData['data']['cost'],
          discount: jsonData['data']['discount'],
          total_coust: double.parse(jsonData['data']['total_cost'].toString()),
          rate: jsonData['data']['rate'],
          available_in: listOfConsulAvailable,
          availableIn: jsonData['data']['days'],
          mapLink: jsonData['data']['map_link'],
          badges: jsonData['data']['badges'],
          question: jsonData['data']['question'],
        );

        listOfConsultant.add(consultant);
      }
    } catch (e) {
      print('catch Error:' + e.toString());
    }
    return consultant;
  }

  static Future<List<Consultant>> consulSreachByName(String name) async {
    List<Consultant> listOfConsultant = [];
    List<AvailableTimes> listOfTime = [];
    List<ConsulAvailable> listOfConsulAvailable = [];

    try {
      var response =
          await http.get(Uri.parse(Utils.SEARCHBYNAME_URL + "$name"), headers: {
        'Accept': 'application/json',
        'x-api-key': User.userToken,
        "Connection": "keep-alive",
        'lang': apiLang(),
      });
      var jsonData = json.decode(response.body);
      if (response.statusCode == 200) {
        for (var itmes in jsonData['data']) {
          listOfConsulAvailable = [];
          listOfTime = [];
          if (itmes['available_in'] != null) {
            for (var item in itmes['available_in']) {
              for (var i in item['times']) {
                AvailableTimes times = AvailableTimes(
                  id: i['id'],
                  date: i['date'],
                  time: i['time'],
                );
                listOfTime.add(times);
              }
              ConsulAvailable consulAvailable = ConsulAvailable(
                  availableTimes: listOfTime, date: item['date']);
              listOfConsulAvailable.add(consulAvailable);
            }
          }

          Consultant consultant = Consultant(
            id: itmes['id'],
            name: itmes['name'],
            bio: itmes['bio'],
            address: itmes['address'],
            image: itmes['image'],
            experince: itmes['experince'],
            coust: itmes['cost'],
            discount: itmes['discount'],
            total_coust: double.parse(itmes['total_cost'].toString()),
            rate: itmes['rate'],
            available_in: listOfConsulAvailable,
            availableIn: itmes['days'],
            mapLink: itmes['map_link'],
            badges: itmes['badges'],
            question: itmes['question'],
          );

          listOfConsultant.add(consultant);
        }
      }
    } catch (e) {
      print(e.toString());
    }
    return listOfConsultant;
  }
}

class ConsultantRateApi {
  static Future<List<ConsulRateing>> fetchAllConsultantRate(int id) async {
    List<ConsulRateing> listOfConsultantRating = [];
    // List<RatingUser> listOfUsers = [];

    try {
      var response = await http
          .get(Uri.parse(Utils.Consultant_URL + "/$id/rates"), headers: {
        'Accept': 'application/json',
        "Connection": "keep-alive",
        'lang': apiLang(),
      });
      var jsonData = json.decode(response.body);
      if (response.statusCode == 200) {
        for (var itmes in jsonData['data']) {
          ConsulRateing consulRateing = ConsulRateing(
            comment: itmes['comment'],
            rate: itmes['rate'],
            name: itmes['user']['name'],
            gender: itmes['user']['gender'],
            image: itmes['user']['image'],
            created_at: itmes['created_at'],
          );
          listOfConsultantRating.add(consulRateing);
        }
      } else {
        print('Rating SutausCode:' + response.statusCode.toString());
      }
    } catch (e) {
      print(e.toString());
    }
    return listOfConsultantRating;
  }
}

class FiltterConsultantApi {
  static Future<List<Consultant>> fetchAllConsultant(
      {String type, String lat, String lng}) async {
    List<Consultant> listOfConsultant = [];
    List<AvailableTimes> listOfTime = [];
    List<ConsulAvailable> listOfConsulAvailable = [];
    final uri = Uri.parse(Utils.CONSULTFILLTER_URL)
        .replace(queryParameters: <String, String>{
      "type": "$type",
      "lat": "$lat",
      "lng": "$lng",
    });

    try {
      var response = await http.get(uri, headers: {
        'Accept': 'application/json',
        'x-api-key': User.userToken,
        "Connection": "keep-alive",
        'lang': apiLang(),
      });
      var jsonData = json.decode(response.body);
      if (response.statusCode == 200) {
        for (var itmes in jsonData['data']) {
          listOfConsulAvailable = [];
          listOfTime = [];
          if (itmes['days'] != null) {
            for (var item in itmes['days']) {
              for (var i in item['times']) {
                AvailableTimes times = AvailableTimes(
                  id: i['id'],
                  date: i['date'],
                  time: i['time'],
                );
                listOfTime.add(times);
              }
              ConsulAvailable consulAvailable = ConsulAvailable(
                  availableTimes: listOfTime, date: item['date']);
              listOfConsulAvailable.add(consulAvailable);
            }
          }

          Consultant consultant = Consultant(
            id: itmes['id'],
            name: itmes['name'],
            bio: itmes['bio'],
            address: itmes['address'],
            image: itmes['image'],
            experince: itmes['experince'],
            coust: itmes['cost'],
            discount: itmes['discount'],
            total_coust: double.parse(itmes['total_cost'].toString()),
            rate: itmes['rate'],
            available_in: listOfConsulAvailable,
            availableIn: itmes['days'],
            mapLink: itmes['map_link'],
            badges: itmes['badges'],
            question: itmes['question'],
          );

          listOfConsultant.add(consultant);
        }
      }
    } catch (e) {
      print(e.toString());
    }
    return listOfConsultant;
  }
}
