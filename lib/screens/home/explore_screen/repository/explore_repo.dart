import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flight_booking/core/model/explore_model.dart';
import 'package:flight_booking/core/network/api_manager.dart';
import 'package:flight_booking/core/services/service_locator.dart';
import 'package:flight_booking/core/utils/decode_api.dart';

class ExploreRepoistory {
  static ApiManager _apiManager = locator<ApiManager>();

  // Explore URLs
  static const String exploreURL = "/home";

  static Future<Either<ExploreModel, Failure>> getExploreData() async {
    Response response = await _apiManager.dio!.get(exploreURL);
    return decodeJson(response).fold((value) {
      return Left(ExploreModel.fromMap(value));
    }, (failure) {
      return Right(failure);
    });
  }
}
