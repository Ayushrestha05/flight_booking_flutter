// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flight_booking/core/model/flight_model.dart';

class ExploreModel {
  List<FlightModel>? newFlights;

  ExploreModel({
    this.newFlights,
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
    );
  }

  String toJson() => json.encode(toMap());

  factory ExploreModel.fromJson(String source) =>
      ExploreModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
