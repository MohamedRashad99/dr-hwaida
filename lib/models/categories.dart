import 'package:DrHwaida/models/user.dart';
import 'package:DrHwaida/models/utils.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Categories {
  final int id;
  final String name;
  // ignore: non_constant_identifier_names
  final String image_path;

  Categories({
    this.id,
    this.name,
    // ignore: non_constant_identifier_names
    this.image_path,
  });
}

class CategoriesApi {
  static Future<List<Categories>> fetchAllCategories() async {
    List<Categories> listOfCategories = [];
    var response = await http.get(Uri.parse(Utils.CATEGORIES_URL),
        headers: {'Accept': 'application/json', 'x-api-key': User.userToken});
    var jsonData = json.decode(response.body);
    try {
      if (response.statusCode == 200) {
        for (var items in jsonData['data']) {
          Categories categories = Categories(
            id: items['id'],
            name: items['name'],
            image_path: items['image_path'],
          );
          listOfCategories.add(categories);
        }
      }
    } catch (e) {
      print(e);
    }
    return listOfCategories;
  }
}
