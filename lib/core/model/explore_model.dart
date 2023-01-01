// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flight_booking/core/model/flight_model.dart';
import 'package:flight_booking/core/model/top_route_model.dart';

class ExploreModel {
  List<FlightModel>? newFlights;
  List<TopRouteModel>? topRoutes;

  ExploreModel({
    this.newFlights,
    this.topRoutes,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'newFlights': newFlights ?? [].map((x) => x?.toMap()).toList(),
    };
  }

  factory ExploreModel.fromMap(Map<String, dynamic> map) {
    return ExploreModel(
      newFlights: map['new_flights'] != null
          ? map['new_flights']
              .map<FlightModel>((x) => FlightModel.fromMap(x))
              .toList()
          : null,
      topRoutes: map['top_routes'] != null
          ? map['top_routes']
              .map<TopRouteModel>((x) => TopRouteModel.fromMap(x))
              .toList()
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ExploreModel.fromJson(String source) =>
      ExploreModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
