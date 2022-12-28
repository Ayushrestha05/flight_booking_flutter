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

  const InitialSearchEvent({
    required this.from,
    required this.to,
    required this.departureDate,
    required this.numberOfAdults,
    required this.numberOfChildren,
  });
}

class FetchMoreSearchEvent extends ReturnSearchEvent {
  final String from;
  final String to;
  final String departureDate;
  final int numberOfAdults;
  final int numberOfChildren;
  final int page;

  const FetchMoreSearchEvent({
    required this.from,
    required this.to,
    required this.departureDate,
    required this.numberOfAdults,
    required this.numberOfChildren,
    required this.page,
  });
}
