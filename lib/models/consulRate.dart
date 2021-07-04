class ConsulRate {
  final String comment;
  final String rate;
  // ignore: non_constant_identifier_names
  final String created_at;
  final List<RatingUser> users;

  // ignore: non_constant_identifier_names
  ConsulRate({this.created_at, this.rate, this.comment, this.users});
}

class RatingUser {
  final String name;
  final String image;
  final String gender;
  RatingUser({this.gender, this.name, this.image});
}

class ConsulRateing {
  final String comment;
  final String rate;
  final String name;
  final String image;
  final String gender;
  // ignore: non_constant_identifier_names
  final String created_at;

  ConsulRateing(
      {this.name,
      this.image,
      this.gender,
      // ignore: non_constant_identifier_names
      this.created_at,
      this.rate,
      this.comment});
}
