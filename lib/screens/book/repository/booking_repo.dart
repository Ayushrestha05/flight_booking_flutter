import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flight_booking/core/model/book_model.dart';
import 'package:flight_booking/core/model/passenger_txt_field_model.dart';
import 'package:flight_booking/core/network/api_manager.dart';
import 'package:flight_booking/core/services/navigation_service.dart';
import 'package:flight_booking/core/services/service_locator.dart';
import 'package:flight_booking/core/utils/decode_api.dart';
import 'package:flight_booking/core/utils/show_toast.dart';
import 'package:flight_booking/screens/home/my_tickets/model/my_ticket_model.dart';

class BookingRepo {
  static final ApiManager _apiManager = ApiManager();
  static final bookingURL = '/book-flight';
  static final getBookingsURL = '/get-bookings';

  static Future<Either> bookFlight({required BookingModel model}) async {
    List<Map> passengers = [];
    for (var element in model.passengersTxtFieldModel!) {
      passengers.add({
        'name': getFullName(element),
        'gender': element.gender,
        'nationality': element.nationality,
        'document_type': element.documentType,
        'document_number': element.documentNumber,
        'is_child': (element.isChild ?? false) ? '1' : '0',
      });
    }
    Response response = await _apiManager.dio!.post(bookingURL, data: {
      'name': model.name,
      'phone': model.phone,
      'email': model.email,
      'arrival_flight': model.arrival_class_id,
      'departure_flight': model.departure_class_id,
      'passengers': passengers,
    });
    return decodeJson(response);
  }

  static Future<Either<List<MyTicketModel>, Failure>> getBookings() async {
    Response response = await _apiManager.dio!.get(getBookingsURL);
    return decodeJson(response).fold((l) {
      return Left(
          l.map<MyTicketModel>((e) => MyTicketModel.fromMap(e)).toList());
    }, (r) => Right(r));
  }

  static getFullName(PassengerTextFieldModel model) {
    String fullName = '';
    if (model.title != null) {
      fullName += model.title!;
    }
    if (model.firstName != null) {
      fullName += ' ${model.firstName}';
    }
    if (model.middleName != null) {
      fullName += ' ${model.middleName}';
    }
    if (model.lastName != null) {
      fullName += ' ${model.lastName}';
    }
    return fullName.trim();
  }
}
