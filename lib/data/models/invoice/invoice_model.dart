import 'dart:convert';

class InvoiceModel {
  final int id;
  final String name;
  final String phone;
  final String value;
  final String type;
  InvoiceModel({
    required this.id,
    required this.name,
    required this.phone,
    required this.value,
    required this.type,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'phone': phone,
      'value': value,
      'type': type,
    };
  }

  factory InvoiceModel.fromMap(Map<String, dynamic> map) {
    return InvoiceModel(
      id: map['id']?.toInt() ?? 0,
      name: map['name'] ?? '',
      phone: map['phone'] ?? '',
      value: map['value'] ?? '',
      type: map['type'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory InvoiceModel.fromJson(String source) =>
      InvoiceModel.fromMap(json.decode(source));
}
