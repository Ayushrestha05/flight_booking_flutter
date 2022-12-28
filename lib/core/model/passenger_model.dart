import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class PassengerModel {
  int? id;
  String? name;
  String? gender;
  String? nationality;
  String? document_type;
  String? document_number;
  bool? is_child;
  PassengerModel({
    this.id,
    this.name,
    this.gender,
    this.nationality,
    this.document_type,
    this.document_number,
    this.is_child,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'gender': gender,
      'nationality': nationality,
      'document_type': document_type,
      'document_number': document_number,
      'is_child': is_child,
    };
  }

  factory PassengerModel.fromMap(Map<String, dynamic> map) {
    return PassengerModel(
      id: map['id'] != null ? map['id'] as int : null,
      name: map['name'] != null ? map['name'] as String : null,
      gender: map['gender'] != null ? map['gender'] as String : null,
      nationality:
          map['nationality'] != null ? map['nationality'] as String : null,
      document_type:
          map['document_type'] != null ? map['document_type'] as String : null,
      document_number: map['document_number'] != null
          ? map['document_number'] as String
          : null,
      is_child: map['is_child'] != null
          ? map['is_child'] == 0
              ? false
              : true
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory PassengerModel.fromJson(String source) =>
      PassengerModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
