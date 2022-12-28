// ignore_for_file: public_member_api_docs, sort_constructors_first
class FlightSearchViewModel {
  String from;
  String to;
  DateTime departureDate;
  DateTime? returnDate;
  int numberOfAdults;
  int? numberOfChildren;
  bool? isRoundTrip = false;

  FlightSearchViewModel({
    required this.from,
    required this.to,
    required this.departureDate,
    this.returnDate,
    required this.numberOfAdults,
    this.numberOfChildren,
    this.isRoundTrip,
  });
}
