// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flight_booking/core/model/flight_model.dart';
import 'package:flight_booking/core/model/pagination_model.dart';

class SearchModel {
  List<FlightModel>? flights;
  PaginationModel? pagination;

  SearchModel({
    this.flights,
    this.pagination,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'flights': flights!.map((x) => x.toMap()).toList(),
      'pagination': pagination?.toMap(),
    };
  }

  factory SearchModel.fromMap(Map<String, dynamic> map) {
    return SearchModel(
      flights: map['flights'] != null
          ? List<FlightModel>.from(
              (map['flights'] as List).map<FlightModel?>(
                (x) => FlightModel.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
      pagination: map['pagination'] != null
          ? PaginationModel.fromMap(map['pagination'] as Map<String, dynamic>)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory SearchModel.fromJson(String source) =>
      SearchModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
