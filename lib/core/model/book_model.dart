import 'dart:convert';

import 'package:flight_booking/core/model/flight_model.dart';
import 'package:flight_booking/core/model/passenger_txt_field_model.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class BookingModel {
  String? name;
  String? email;
  String? phone;
  int? totalAdults;
  int? totalChildren;
  int? arrival_class_id;
  int? departure_class_id;
  FlightModel? arrival_flight;
  FlightModel? departure_flight;
  List<PassengerTextFieldModel>? passengersTxtFieldModel;

  BookingModel({
    this.name,
    this.email,
    this.phone,
    this.arrival_flight,
    this.departure_flight,
    this.arrival_class_id,
    this.departure_class_id,
    // this.passengers,
    this.totalAdults,
    this.totalChildren,
    this.passengersTxtFieldModel,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'email': email,
      'phone': phone,
      'arrival_flight': arrival_class_id,
      'departure_flight': departure_class_id,
      // 'passengers': passengers!.map((x) => x.toMap()).toList(),
    };
  }

  String toJson() => json.encode(toMap());

  BookingModel copyWith({
    String? name,
    String? email,
    String? phone,
    int? arrival_class_id,
    int? departure_class_id,
    FlightModel? arrival_flight,
    FlightModel? departure_flight,
    // List<PassengerModel>? passengers,
    List<PassengerTextFieldModel>? passengersTxtFieldModel,
    int? totalAdults,
    int? totalChildren,
  }) {
    return BookingModel(
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      arrival_class_id: arrival_class_id ?? this.arrival_class_id,
      departure_class_id: departure_class_id ?? this.departure_class_id,
      passengersTxtFieldModel:
          passengersTxtFieldModel ?? this.passengersTxtFieldModel,
      arrival_flight: arrival_flight ?? this.arrival_flight,
      departure_flight: departure_flight ?? this.departure_flight,
      // passengers: passengers ?? this.passengers,
      totalAdults: totalAdults ?? this.totalAdults,
      totalChildren: totalChildren ?? this.totalChildren,
    );
  }
}
