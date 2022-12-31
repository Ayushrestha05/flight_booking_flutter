import 'package:flight_booking/core/services/service_locator.dart';
import 'package:flight_booking/core/services/shared_pref_services.dart';

getHeaders() {
  String? token = locator<SharedPrefsServices>().getString(key: 'auth_token');
  if (token != null) {
    return {'Authorization': 'Bearer $token', 'Accept': 'application/json'};
  } else {
    return {'Accept': 'application/json'};
  }
}
