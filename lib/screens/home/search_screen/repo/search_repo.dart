import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flight_booking/core/network/api_manager.dart';
import 'package:flight_booking/core/utils/decode_api.dart';
import 'package:flight_booking/screens/home/search_screen/model/search_model.dart';

class SearchRepository{
  static ApiManager _apiManager = ApiManager();

  static const String searchURL = "/search";

  static Future<Either<SearchModel, Failure>> getExploreData({required String from, required String to, required String date, required int seats}) async {
    Response response = await _apiManager.dio!.post(searchURL, data: {
      'from': from,
      'to': to,
      'date': date,
      'seats': seats,
    });
    return decodeJson(response).fold((value) {
      return Left(SearchModel.fromMap(value));
    }, (failure) {
      return Right(failure);
    });
  }
}