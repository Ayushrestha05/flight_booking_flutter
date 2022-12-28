import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class CompanyModel {
  int? id;
  String? name;
  String? image;
  String? color;
  CompanyModel({
    this.id,
    this.name,
    this.image,
    this.color,
  });



  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'image': image,
      'color': color,
    };
  }

  factory CompanyModel.fromMap(Map<String, dynamic> map) {
    return CompanyModel(
      id: map['id'] != null ? map['id'] as int : null,
      name: map['name'] != null ? map['name'] as String : null,
      image: map['image'] != null ? map['image'] as String : null,
      color: map['color'] != null ? map['color'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory CompanyModel.fromJson(String source) => CompanyModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
