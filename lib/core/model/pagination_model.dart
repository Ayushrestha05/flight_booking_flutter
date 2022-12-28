import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class PaginationModel {
  int? total;
  int? perPage;
  int? currentPage;
  int? lastPage;
  int? from;
  int? to;

  PaginationModel({
    this.total,
    this.perPage,
    this.currentPage,
    this.lastPage,
    this.from,
    this.to,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'total': total,
      'perPage': perPage,
      'currentPage': currentPage,
      'lastPage': lastPage,
      'from': from,
      'to': to,
    };
  }

  factory PaginationModel.fromMap(Map<String, dynamic> map) {
    return PaginationModel(
      total: map['total'],
      perPage: map['perPage'],
      currentPage: map['currentPage'],
      lastPage: map['lastPage'],
      from: map['from'],
      to: map['to'],
    );
  }

  String toJson() => json.encode(toMap());

  factory PaginationModel.fromJson(String source) =>
      PaginationModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
