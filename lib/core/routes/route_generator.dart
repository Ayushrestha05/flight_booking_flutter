import 'package:flight_booking/core/routes/export_routes.dart';
import 'package:flight_booking/core/routes/route_names.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  RouteGenerator._();

  static Route<dynamic>? generateRoute(RouteSettings settings) {
    Object? arguments = settings.arguments;
    switch (settings.name) {
      case Routes.homeScreen:
        return MaterialPageRoute(builder: (_) => BaseScreen());

      default:
        return MaterialPageRoute(
            settings: settings, builder: (_) => LoginScreen());
    }
  }
}
