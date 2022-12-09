import 'package:dio/dio.dart';
import 'package:flight_booking/core/services/shared_pref_services.dart';
import '../services/service_locator.dart';


class ApiInterceptor extends Interceptor {
  static const int statusCodeUnauthorized = 401;

  final Function? refreshSession;
  final Function? getValidAccessToken;

  final Dio? dioInstance;

  ApiInterceptor({
    required this.dioInstance,
    this.refreshSession,
    this.getValidAccessToken,
  });

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    String? accessToken;
    bool hasToken = locator<SharedPrefsServices>()
        .sharedPreferences!
        .containsKey("auth_token");
    if (hasToken) {
      accessToken = locator<SharedPrefsServices>().getString(
        key: "auth_token",
      );
    }
    if (accessToken != null && accessToken.isNotEmpty) {
      options.headers.putIfAbsent('Authorization', () => 'Bearer $accessToken');
    }
    return super.onRequest(options, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    super.onError(err, handler);
  }
}