import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class TopRouteModel {
  String? from_location;
  String? to_location;
  int? total;
  
  TopRouteModel({
    this.from_location,
    this.to_location,
    this.total,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'from_location': from_location,
      'to_location': to_location,
      'total': total,
    };
  }

  factory TopRouteModel.fromMap(Map<String, dynamic> map) {
    return TopRouteModel(
      from_location: map['from_location'] != null ? map['from_location'] as String : null,
      to_location: map['to_location'] != null ? map['to_location'] as String : null,
      total: map['total'] != null ? map['total'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory TopRouteModel.fromJson(String source) => TopRouteModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
