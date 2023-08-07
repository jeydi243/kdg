import 'package:cloud_firestore/cloud_firestore.dart';

import 'house.dart';

class Location {
  Timestamp startDate;
  late Timestamp endDate;
  House location;
  Location(this.startDate, this.location);
}
