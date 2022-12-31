// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'search_bloc.dart';

abstract class SearchEvent {
  const SearchEvent();
}

class InitialSearchEvent extends SearchEvent {
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
    this.queryString,
  });
}

class FetchMoreSearchEvent extends SearchEvent {
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
    this.queryString,
  });
}
