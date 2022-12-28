import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class ClassModel {
  int? id;
  String? className;
  int? price;
  int? seats;

  ClassModel({
    this.id,
    this.className,
    this.price,
    this.seats,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'class': className,
      'price': price,
      'seats': seats,
    };
  }

  factory ClassModel.fromMap(Map<String, dynamic> map) {
    return ClassModel(
      id: map['id'],
      className: map['class'],
      price: map['price'] ,
      seats: map['seats'] ,
    );
  }

  String toJson() => json.encode(toMap());

  factory ClassModel.fromJson(String source) => ClassModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
