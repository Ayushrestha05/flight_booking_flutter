import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flight_booking/core/network/api_manager.dart';
import 'package:flight_booking/core/utils/decode_api.dart';

class ReviewRepo {
  final ApiManager _apiManager = ApiManager();

  static const String reviewURL = "/save-review";

  Future<Either> saveReview({
    required String firstName,
    required String lastName,
    required String email,
    required String phone,
    required String message,
  }) async {
    Response response = await _apiManager.dio!.post(reviewURL, data: {
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'phone': phone,
      'message': message,
    });

    return decodeJson(response);
  }
}
