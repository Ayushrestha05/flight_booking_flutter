import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flight_booking/core/network/api_manager.dart';
import 'package:flight_booking/core/utils/decode_api.dart';

class MyTicketRepo{
  static final ApiManager _apiManager = ApiManager();
  static final bookingURL = '/get-bookings';

  static Future<Either> getBookings() async {
    Response response = await _apiManager.dio!.get(bookingURL);
    return decodeJson(response);
  }
}