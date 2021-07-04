String contant =
    'We make it easy, fast and affordable to send SMS marketing We make it easy, fast and affordable to send SMS marketing';
String title = 'Dr/ Ahmed Ibrahim';
String date = '12 May 2021';
String oldPrice = '300';
String newPrice = '255';
String courseImageUrl = 'lib/images/aboutus.jpg';
double rating = 4;

class Courses {
  final int id;
  final String courseImageUrl;
  final String courseVideoUrl;
  final String contant;
  final String title;
  final String couslNmae;
  final String date;
  final String type;
  // ignore: non_constant_identifier_names
  final int videos_count;
  final String discount;
  // ignore: non_constant_identifier_names
  final String start_date;
  // ignore: non_constant_identifier_names
  final String total_time;
  // ignore: non_constant_identifier_names
  final String end_date;
  // ignore: non_constant_identifier_names
  final String end_time;
  // ignore: non_constant_identifier_names
  final String start_time;
  var lessons;
  var features;
  final String rating;
  final String newPrice;

  Courses({
    // ignore: non_constant_identifier_names
    this.start_date,
    // ignore: non_constant_identifier_names
    this.end_date,
    // ignore: non_constant_identifier_names
    this.end_time,
    // ignore: non_constant_identifier_names
    this.start_time,
    this.couslNmae,
    this.id,
    this.courseVideoUrl,
    this.type,
    this.discount,
    // ignore: non_constant_identifier_names
    this.total_time,
    this.lessons,
    this.features,
    this.courseImageUrl,
    this.contant,
    this.title,
    this.date,
    // ignore: non_constant_identifier_names
    this.videos_count,
    this.newPrice,
    this.rating,
  });
}

List<Courses> listCourses = [];
