class CustomEvent {
  final int id;
  final String title;
  final String imageUl;
  final String contant;
  // ignore: non_constant_identifier_names
  final String start_date;
  // ignore: non_constant_identifier_names
  final String start_time;
  // ignore: non_constant_identifier_names
  final String end_date;
  // ignore: non_constant_identifier_names
  final String end_time;
  final String video;
  final String type;
  final String price;
  final String discount;
  // ignore: non_constant_identifier_names
  final String discount_message;
  var features;

  CustomEvent({
    this.id,
    // ignore: non_constant_identifier_names
    this.start_date,
    // ignore: non_constant_identifier_names
    this.start_time,
    // ignore: non_constant_identifier_names
    this.end_date,
    // ignore: non_constant_identifier_names
    this.end_time,
    this.video,
    this.type,
    this.price,
    this.discount,
    // ignore: non_constant_identifier_names
    this.discount_message,
    this.title,
    this.imageUl,
    this.contant,
    this.features,
  });
}
