import 'dart:convert';

class StatsModel {
  final int total_success;
  final int total_failed;
  final int total_incomplete;
  final double sells_sum;
  final double collect_sum;
  StatsModel({
    required this.total_success,
    required this.total_failed,
    required this.total_incomplete,
    required this.sells_sum,
    required this.collect_sum,
  });

  Map<String, dynamic> toMap() {
    return {
      'total_success': total_success,
      'total_failed': total_failed,
      'total_incomplete': total_incomplete,
      'sells_sum': sells_sum,
      'collect_sum': collect_sum,
    };
  }

  factory StatsModel.fromMap(Map<String, dynamic> map) {
    return StatsModel(
      total_success: map['total_success']?.toInt() ?? 0,
      total_failed: map['total_failed']?.toInt() ?? 0,
      total_incomplete: map['total_incomplete']?.toInt() ?? 0,
      sells_sum: map['sells_sum']?.toDouble() ?? 0.0,
      collect_sum: map['collect_sum']?.toDouble() ?? 0.0,
    );
  }

  String toJson() => json.encode(toMap());

  factory StatsModel.fromJson(String source) =>
      StatsModel.fromMap(json.decode(source));
}
