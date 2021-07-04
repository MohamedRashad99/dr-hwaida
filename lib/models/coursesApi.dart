import 'package:DrHwaida/models/courses.dart';
import 'package:DrHwaida/models/user.dart';
import 'package:DrHwaida/models/utils.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:DrHwaida/constants/constans.dart';

class CoursesApi {
  static Future<List<Courses>> fetchAllCourses() async {
    List<Courses> listOfCourses = [];

    try {
      var response = await http.get(Uri.parse(Utils.COURSES_URL), headers: {
        'Accept': 'application/json',
        'x-api-key': User.userToken,
        "Connection": "keep-alive",
        'lang': apiLang(),
      });
      var jsonData = json.decode(response.body);
      if (response.statusCode == 200) {
        for (var items in jsonData['data']) {
          Courses courses = Courses(
            id: items['id'],
            title: items['name'],
            contant: items['description'],
            couslNmae: items['instructor']['name'],
            courseImageUrl: items['image_path'],
            type: items['type'],
            rating: items['rate'],
            total_time: items['total_time'],
            newPrice: items['price'],
            discount: items['discount'],
            features: items['features'],
            courseVideoUrl: items['video'],
            lessons: items['lessons'],
            videos_count: items['videos_count'],
            start_date: items['start_date'],
            start_time: items['start_time'],
            end_date: items['end_date'],
            end_time: items['end_time'],
          );
          listOfCourses.add(courses);
        }
      }
    } catch (e) {
      print(e);
    }
    return listOfCourses;
  }

  static Future<List<Courses>> fetchAllFeaturedCourses() async {
    List<Courses> listOfCourses = [];

    try {
      var response =
          await http.get(Uri.parse(Utils.Featured_courses_URL), headers: {
        'Accept': 'application/json',
        'x-api-key': User.userToken,
        "Connection": "keep-alive",
        'lang': User.apiLang,
      });
      var jsonData = json.decode(response.body);
      if (response.statusCode == 200) {
        for (var items in jsonData['data']) {
          Courses courses = Courses(
            id: items['id'],
            title: items['name'],
            contant: items['description'],
            couslNmae: items['instructor']['name'],
            courseImageUrl: items['image_path'],
            type: items['type'],
            rating: items['rate'],
            total_time: items['total_time'],
            newPrice: items['price'],
            discount: items['discount'],
            features: items['features'],
            courseVideoUrl: items['video'],
            lessons: items['lessons'],
            videos_count: items['videos_count'],
            start_date: items['start_date'],
            start_time: items['start_time'],
            end_date: items['end_date'],
            end_time: items['end_time'],
          );
          listOfCourses.add(courses);
        }
      }
    } catch (e) {
      print(e);
    }
    return listOfCourses;
  }

  static Future<List<Courses>> cursesSearch(String name) async {
    List<Courses> listOfCourses = [];

    try {
      var response = await http
          .get(Uri.parse(Utils.COURSESSEARCHBYNAME_URL + "$name"), headers: {
        'Accept': 'application/json',
        'x-api-key': User.userToken,
        "Connection": "keep-alive",
        'lang': apiLang(),
      });
      var jsonData = json.decode(response.body);
      if (response.statusCode == 200) {
        for (var items in jsonData['data']) {
          Courses courses = Courses(
            id: items['id'],
            title: items['name'],
            contant: items['description'],
            couslNmae: items['instructor']['name'],
            courseImageUrl: items['image_path'],
            type: items['type'],
            rating: items['rate'],
            total_time: items['total_time'],
            newPrice: items['price'],
            discount: items['discount'],
            features: items['features'],
            courseVideoUrl: items['video'],
            lessons: items['lessons'],
            videos_count: items['videos_count'],
            start_date: items['start_date'],
            start_time: items['start_time'],
            end_date: items['end_date'],
            end_time: items['end_time'],
          );
          listOfCourses.add(courses);
        }
      }
    } catch (e) {
      print(e);
    }
    return listOfCourses;
  }

  static Future<List<Courses>> fetchMYCourses() async {
    List<Courses> listOfCourses = [];

    try {
      var response = await http.get(Uri.parse(Utils.COURSES_URL), headers: {
        'Accept': 'application/json',
        'x-api-key': User.userToken,
        "Connection": "keep-alive",
        'lang': apiLang(),
      });
      var jsonData = json.decode(response.body);
      if (response.statusCode == 200) {
        for (var items in jsonData['data']) {
          Courses courses = Courses(
            id: items['id'],
            title: items['name'],
            contant: items['description'],
            couslNmae: items['instructor']['name'],
            courseImageUrl: items['image_path'],
            type: items['type'],
            rating: items['rate'],
            total_time: items['total_time'],
            newPrice: items['price'],
            discount: items['discount'],
            features: items['features'],
            courseVideoUrl: items['video'],
            lessons: items['lessons'],
            videos_count: items['videos_count'],
            start_date: items['start_date'],
            start_time: items['start_time'],
            end_date: items['end_date'],
            end_time: items['end_time'],
          );
          listOfCourses.add(courses);
        }
      }
    } catch (e) {
      print(e);
    }
    return listOfCourses;
  }

  static Future<List<Courses>> fetchAllCategoriesCourses(int id) async {
    List<Courses> listOfCourses = [];

    try {
      var response =
          await http.get(Uri.parse(Utils.CATEGORIES_URL + '/$id'), headers: {
        'Accept': 'application/json',
        'x-api-key': User.userToken,
        "Connection": "keep-alive",
        'lang': apiLang(),
      });
      var jsonData = json.decode(response.body);
      if (response.statusCode == 200) {
        for (var items in jsonData['data']['courses']) {
          Courses courses = Courses(
            id: items['id'],
            title: items['name'],
            contant: items['description'],
            couslNmae: items['instructor']['name'],
            courseImageUrl: items['image_path'],
            type: items['type'],
            rating: items['rate'],
            total_time: items['total_time'],
            newPrice: items['price'],
            discount: items['discount'],
            features: items['features'],
            courseVideoUrl: items['video'],
            lessons: items['lessons'],
            videos_count: items['videos_count'],
            start_date: items['start_date'],
            start_time: items['start_time'],
            end_date: items['end_date'],
            end_time: items['end_time'],
          );
          listOfCourses.add(courses);
        }
      }
    } catch (e) {
      print(e);
    }
    return listOfCourses;
  }
}

class FiltterCoursesApi {
  static Future<List<Courses>> fetchAllCourses({String type}) async {
    List<Courses> listOfCourses = [];

    final uri = Uri.parse(Utils.CoursesFILLTER_URL)
        .replace(queryParameters: <String, String>{
      "type": "$type",
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
          Courses courses = Courses(
            id: itmes['id'],
            title: itmes['name'],
            contant: itmes['description'],
            couslNmae: itmes['instructor']['name'],
            courseImageUrl: itmes['image_path'],
            type: itmes['type'],
            rating: itmes['rate'],
            total_time: itmes['total_time'],
            newPrice: itmes['price'],
            discount: itmes['discount'],
            features: itmes['features'],
            courseVideoUrl: itmes['video'],
            lessons: itmes['lessons'],
            videos_count: itmes['videos_count'],
            start_date: itmes['start_date'],
            start_time: itmes['start_time'],
            end_date: itmes['end_date'],
            end_time: itmes['end_time'],
          );

          listOfCourses.add(courses);
        }
      }
    } catch (e) {
      print(e.toString());
    }
    return listOfCourses;
  }
}
