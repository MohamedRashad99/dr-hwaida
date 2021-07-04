class ProductCourses {
  final title;
  final price;
  final proImageUrl;

  ProductCourses({this.proImageUrl, this.title, this.price});
}

class ProductConsualt {
  final title;
  final price;
  final proImageUrl;
  final date;
  final time;
  final consulId;
  final dateId;

  ProductConsualt({
    this.date,
    this.time,
    this.proImageUrl,
    this.title,
    this.price,
    this.consulId,
    this.dateId,
  });
}

class ConsultantProdect {
  String title;
  String type;
  double price;
  String proImageUrl;
  String date;
  String time;
  int _id;
  int dateId;
  int consultantId;

  ConsultantProdect(dynamic obj) {
    _id = obj['id'];
    type = obj['type'];
    consultantId = obj['consultantId'];
    dateId = obj['dateId'];
    title = obj['title'];
    price = obj['price'];
    proImageUrl = obj['proImageUrl'];
    date = obj['date'];
    time = obj['time'];
  }
  ConsultantProdect.formMap(Map<String, dynamic> data) {
    _id = data['id'];
    type = data['type'];

    consultantId = data['consultantId'];
    dateId = data['dateId'];
    title = data['title'];
    price = data['price'];
    proImageUrl = data['proImageUrl'];
    date = data['date'];
    time = data['time'];
  }
  Map<String, dynamic> toMap() => {
        'id': _id,
        'consultantId': consultantId,
        'dateId': dateId,
        'title': title,
        'price': price,
        'proImageUrl': proImageUrl,
        'date': date,
        'type': type,
        'time': time,
      };
}

List<ProductConsualt> productConsualtList = [];
