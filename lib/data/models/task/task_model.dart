import 'dart:convert';

import 'package:get/get.dart';

class TaskModel {
  final int id;
  final String customer_name;
  final String customer_number;
  final String location_text;
  final String location;
  final String debt;
  final String tag;
  final double longitude;
  final double latitude;
  RxBool? loading = false.obs;
  TaskModel(
      {required this.id,
      required this.customer_name,
      required this.customer_number,
      required this.location_text,
      required this.location,
      required this.debt,
      required this.tag,
      required this.longitude,
      required this.latitude,
      this.loading}) {
    loading = false.obs;
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'customer_name': customer_name,
      'customer_number': customer_number,
      'location_text': location_text,
      'location': location,
      'debt': debt,
      'tag': tag,
      'longitude': longitude,
      'latitude': latitude,
    };
  }

  factory TaskModel.fromMap(Map<String, dynamic> map) {
    return TaskModel(
      id: map['id']?.toInt() ?? 0,
      customer_name: map['customer_name'] ?? '',
      customer_number: map['customer_number'] ?? '',
      location_text: map['location_text'] ?? '',
      location: map['location'] ?? '',
      debt: map['debt']?.toString() ?? '',
      tag: map['tag'] ?? '',
      longitude: map['longitude']?.toDouble() ?? 0.0,
      latitude: map['latitude']?.toDouble() ?? 0.0,
    );
  }
}
