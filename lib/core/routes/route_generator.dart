import 'package:flight_booking/core/routes/export_routes.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  RouteGenerator._();

  static Route<dynamic>? generateRoute(RouteSettings settings) {
    Object? arguments = settings.arguments;
    switch (settings.name) {

      default:
        return MaterialPageRoute(
            settings: settings, builder: (_) => LoginScreen());
    }
  }
}
