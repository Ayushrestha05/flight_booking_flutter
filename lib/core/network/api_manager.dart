import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:flight_booking/core/constants/network_state.dart';
import 'package:flight_booking/core/network/api_interceptor.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../services/service_locator.dart';
import '../services/shared_pref_services.dart';

class ApiManager {
  final int _connectTimeout = 1000000;
  final int _receiveTimeout = 1500000;

  Dio? dio;
  DioCacheManager _dioCacheManager = DioCacheManager(CacheConfig());

  ApiManager() {
    String? accessToken;
    bool hasToken = locator<SharedPrefsServices>().getString(
        key: "auth_token",
      ) != null;
    if (hasToken) {
      accessToken = locator<SharedPrefsServices>().getString(
        key: "auth_token",
      );
    }

    BaseOptions options = BaseOptions(
      baseUrl: baseNetworkUrl,
      validateStatus: (status) {
        return status! < 500;
      },
      connectTimeout: _connectTimeout,
      receiveTimeout: _receiveTimeout,
      contentType: Headers.jsonContentType,
      headers: {
        "Accept": "application/json",
        if (hasToken) "Authorization": "Bearer $accessToken",
      },
    );

    dio = Dio(options);
    dio!.interceptors.add(
      ApiInterceptor(
        dioInstance: dio,
      ),
    );

    dio!.interceptors.add(_dioCacheManager.interceptor);

    /// to handle SSL handsake error.
    (dio?.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      // if (EnvironmentConfig.envIsProd) {
      //   // ByteData data = await rootBundle.load(NetworkSource.sslCertificate);
      //   SecurityContext sc = new SecurityContext(withTrustedRoots: true);
      //   sc.setTrustedCertificatesBytes(data.buffer.asUint8List());
      //   HttpClient httpClient = new HttpClient(context: sc);
      //   return httpClient;
      // } else {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
      // }
    };

    // if any error occurred, display error with response
    dio!.interceptors.add(
      PrettyDioLogger(
        requestHeader: false,
        responseBody: false,
        requestBody: false,
        responseHeader: false,
        compact: false,
      ),
    );
  }
}
