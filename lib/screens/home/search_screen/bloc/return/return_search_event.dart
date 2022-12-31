// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'return_search_bloc.dart';

abstract class ReturnSearchEvent {
  const ReturnSearchEvent();
}

class InitialSearchEvent extends ReturnSearchEvent {
  final String from;
  final String to;
  final String departureDate;
  final int numberOfAdults;
  final int numberOfChildren;  
  final String? queryString;

  const InitialSearchEvent({
    required this.from,
    required this.to,
    required this.departureDate,
    required this.numberOfAdults,
    required this.numberOfChildren,
    this.queryString
  });
}

class FetchMoreSearchEvent extends ReturnSearchEvent {
  final String from;
  final String to;
  final String departureDate;
  final int numberOfAdults;
  final int numberOfChildren;
  final int page;
  final String? queryString;

  const FetchMoreSearchEvent({
    required this.from,
    required this.to,
    required this.departureDate,
    required this.numberOfAdults,
    required this.numberOfChildren,
    required this.page,
    this.queryString
  });
}
