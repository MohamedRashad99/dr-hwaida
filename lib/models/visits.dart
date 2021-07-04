import 'package:DrHwaida/models/consultant.dart';

class Visits {
  final int id;
  final int consultantId;
  final String date;
  final String status;
  final String day;
  final String time;
  final String name;
  final String rate;
  final Consultant consultant;
  // ignore: non_constant_identifier_names
  final String payment_method;
  // ignore: non_constant_identifier_names
  final int total_cost;

  Visits({
    this.status,
    this.rate,
    this.consultant,
    // ignore: non_constant_identifier_names
    this.payment_method,
    // ignore: non_constant_identifier_names
    this.total_cost,
    this.id,
    this.consultantId,
    this.date,
    this.day,
    this.time,
    this.name,
  });
}
