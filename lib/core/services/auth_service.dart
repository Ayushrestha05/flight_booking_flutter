import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flight_booking/core/network/api_manager.dart';
import 'package:flight_booking/core/services/service_locator.dart';
import 'package:flight_booking/core/utils/decode_api.dart';
import 'package:flight_booking/screens/auth/model/profile_model.dart';

class AuthService {
  static ApiManager _apiManager = locator<ApiManager>();

  // Auth URLs
  static const String loginURL = "/login";
  static const String registerURL = "/register";

  static Future<Either<ProfileModel, Failure>> login(
      {required String email, required String password}) async {
    Response response = await _apiManager.dio!.post(loginURL, data: {
      'email': email,
      'password': password,
    });

    return decodeJson(response).fold((value) {
      return Left(ProfileModel.fromMap(value));
    }, (failure) {
      return Right(failure);
    });
  }

  static Future<Either<ProfileModel, Failure>> register(
      {required String fullName,
      required String email,
      required String password}) async {
    Response response = await _apiManager.dio!.post(registerURL, data: {
      'name': fullName,
      'email': email,
      'password': password,
    });

    return decodeJson(response).fold((value) {
      return Left(ProfileModel.fromMap(value));
    }, (failure) {
      return Right(failure);
    });
  }
}
