import 'dart:convert';

import 'package:flight_booking/core/model/class_model.dart';
import 'package:flight_booking/core/model/company_model.dart';
import 'package:intl/intl.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class FlightModel {
  int? id;
  String? fromLocation;
  String? toLocation;
  DateTime? departureDate;
  int? duration;
  CompanyModel? company;
  String? flightNumber;
  int? baggageLimit;
  List<ClassModel>? classes;

  FlightModel({
    this.id,
    this.fromLocation,
    this.toLocation,
    this.departureDate,
    this.duration,
    this.company,
    this.flightNumber,
    this.baggageLimit,
    this.classes,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'fromLocation': fromLocation,
      'toLocation': toLocation,
      'departureDate': departureDate?.millisecondsSinceEpoch,
      'duration': duration,
      'company': company,
      'flightNumber': flightNumber,
      'baggageLimit': baggageLimit,
      'classes': classes?.map((x) => x.toMap()).toList(),
    };
  }

  factory FlightModel.fromMap(Map<String, dynamic> map) {
    return FlightModel(
      id: map['id'],
      fromLocation: map['from_location'],
      toLocation: map['to_location'],
      departureDate: DateFormat("yyyy-MM-dd hh:mm:ss").parse(map['departure']),
      duration: map['duration'],
      company: map['company'] != null
          ? CompanyModel.fromMap(map['company'] as Map<String, dynamic>)
          : null,
      flightNumber: map['flight_number'],
      baggageLimit: map['baggage_limit'],
      classes: map['details'] != null
          ? map['details']
              .map<ClassModel>((x) => ClassModel.fromMap(x))
              .toList()
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory FlightModel.fromJson(String source) =>
      FlightModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
