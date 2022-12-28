import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class PassengerTextFieldModel {
  String? title;
  String? firstName;
  String? middleName;
  String? lastName;

  String? gender;
  String? nationality;
  String? documentType;
  String? documentNumber;
  bool? isChild;

  PassengerTextFieldModel({
    this.title,
    this.firstName,
    this.middleName,
    this.lastName,
    this.gender,
    this.nationality,
    this.documentType,
    this.documentNumber,
    this.isChild,
  });
}
