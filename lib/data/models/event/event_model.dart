import 'dart:convert';

import 'package:gps_module/data/enums/event_type.dart';

class EventModel {
  final EventType type;
  final double longitude;
  final double latitude;
  EventModel({
    required this.type,
    required this.longitude,
    required this.latitude,
  });

  Map<String, dynamic> toMap() {
    return {
      'type': type.toMap(),
      'longitude': longitude,
      'latitude': latitude,
    };
  }
}
