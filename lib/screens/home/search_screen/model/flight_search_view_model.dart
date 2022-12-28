// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flight_booking/core/model/book_model.dart';

class FlightSearchViewModel {
  String from;
  String to;
  DateTime departureDate;
  DateTime? returnDate;
  int numberOfAdults;
  int? numberOfChildren;
  bool? isRoundTrip = false;
  BookingModel? bookingModel;

  FlightSearchViewModel({
    required this.from,
    required this.to,
    required this.departureDate,
    this.returnDate,
    required this.numberOfAdults,
    this.numberOfChildren,
    this.isRoundTrip,
    this.bookingModel
  });

  FlightSearchViewModel copyWith({
    String? from,
    String? to,
    DateTime? departureDate,
    DateTime? returnDate,
    int? numberOfAdults,
    int? numberOfChildren,
    bool? isRoundTrip,
    BookingModel? bookingModel,
  }) {
    return FlightSearchViewModel(
      from: from ?? this.from,
      to: to ?? this.to,
      departureDate: departureDate ?? this.departureDate,
      returnDate: returnDate ?? this.returnDate,
      numberOfAdults: numberOfAdults ?? this.numberOfAdults,
      numberOfChildren: numberOfChildren ?? this.numberOfChildren,
      isRoundTrip: isRoundTrip ?? this.isRoundTrip,
      bookingModel: bookingModel ?? this.bookingModel,
    );
  }
}
