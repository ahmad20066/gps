import 'dart:convert';

class SalesModel {
  final int id;
  final ContactModel contact;
  final String final_total;
  final String type;
  SalesModel({
    required this.id,
    required this.contact,
    required this.final_total,
    required this.type,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'contact': contact.toMap(),
      'final_total': final_total,
    };
  }

  factory SalesModel.fromMap(Map<String, dynamic> map) {
    return SalesModel(
        id: map['id']?.toInt() ?? 0,
        contact: ContactModel.fromMap(map['contact']),
        final_total: map['final_total'] ?? '',
        type: "VIP");
  }
}

class ContactModel {
  final int id;
  final String name;
  final String mobile;
  ContactModel({
    required this.id,
    required this.name,
    required this.mobile,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'mobile': mobile,
    };
  }

  factory ContactModel.fromMap(Map<String, dynamic> map) {
    return ContactModel(
      id: map['id']?.toInt() ?? 0,
      name: map['name'] ?? '',
      mobile: map['mobile'] ?? '',
    );
  }
}
