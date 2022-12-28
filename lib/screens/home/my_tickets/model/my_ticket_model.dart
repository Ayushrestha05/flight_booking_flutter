// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flight_booking/core/model/flight_model.dart';
import 'package:flight_booking/core/model/passenger_model.dart';

class MyTicketModel {
  int? id;
  String? name;
  String? email;
  String? phone;
  MyTicketFlightClassModel? arrival_flight;
  MyTicketFlightClassModel? departure_flight;
  List<PassengerModel>? passengers;

  MyTicketModel({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.arrival_flight,
    this.departure_flight,
    this.passengers,
  });

  factory MyTicketModel.fromMap(Map<String, dynamic> map) {
    return MyTicketModel(
      id: map['id'],
      name: map['name'],
      email: map['email'],
      phone: map['phone'],
      arrival_flight: map['arrival_flight'] != null
          ? MyTicketFlightClassModel.fromMap(
              map['arrival_flight'] as Map<String, dynamic>)
          : null,
      departure_flight: map['departure_flight'] != null
          ? MyTicketFlightClassModel.fromMap(
              map['departure_flight'] as Map<String, dynamic>)
          : null,
      passengers: map['passengers'] != null
          ? List<PassengerModel>.from((map['passengers'] as List<dynamic>)
              .map((x) => PassengerModel.fromMap(x as Map<String, dynamic>)))
          : null,
    );
  }

  factory MyTicketModel.fromJson(String source) =>
      MyTicketModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

class MyTicketFlightClassModel {
  int? id;
  String? className;
  int? price;
  FlightModel? flight;

  MyTicketFlightClassModel({
    this.id,
    this.className,
    this.price,
    this.flight,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'className': className,
      'price': price,
      'flight': flight?.toMap(),
    };
  }

  factory MyTicketFlightClassModel.fromMap(Map<String, dynamic> map) {
    return MyTicketFlightClassModel(
        id: map['id'] != null ? map['id'] as int : null,
        className: map['className'] != null ? map['className'] as String : null,
        price: map['price'] != null ? map['price'] as int : null,
        flight: map['flight'] != null
            ? map['flight'] is String?
                ? FlightModel.fromJson(map['flight'] as String)
                : FlightModel.fromMap(map['flight'] as Map<String, dynamic>)
            : null);
  }

  String toJson() => json.encode(toMap());

  factory MyTicketFlightClassModel.fromJson(String source) =>
      MyTicketFlightClassModel.fromMap(
          json.decode(source) as Map<String, dynamic>);
}
