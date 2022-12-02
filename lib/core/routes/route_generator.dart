import 'package:flight_booking/core/routes/export_routes.dart';
import 'package:flight_booking/core/routes/route_names.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  RouteGenerator._();

  static Route<dynamic>? generateRoute(RouteSettings settings) {
    Object? arguments = settings.arguments;
    switch (settings.name) {
      case Routes.loginScreen:
        return MaterialPageRoute(builder: (_) => LoginScreen());

      case Routes.registerScreen:
        return MaterialPageRoute(builder: (_) => RegisterScreen());

      case Routes.homeScreen:
        return MaterialPageRoute(builder: (_) => BaseScreen());

      case Routes.flightListScreen:
        return MaterialPageRoute(builder: (_) => FlightListScreen());

      default:
        return MaterialPageRoute(
            settings: settings, builder: (_) => LoginScreen());
    }
  }
}
