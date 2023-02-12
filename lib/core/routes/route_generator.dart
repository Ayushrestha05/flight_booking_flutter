import 'package:flight_booking/core/model/book_model.dart';
import 'package:flight_booking/core/routes/export_routes.dart';
import 'package:flight_booking/core/routes/route_names.dart';
import 'package:flight_booking/core/services/service_locator.dart';
import 'package:flight_booking/main.dart';
import 'package:flight_booking/screens/auth/bloc/auth_bloc.dart';
import 'package:flight_booking/screens/auth/model/profile_model.dart';
import 'package:flight_booking/screens/home/explore_screen/bloc/bloc/explore_bloc.dart';
import 'package:flight_booking/screens/home/my_tickets/model/my_ticket_model.dart';
import 'package:flight_booking/screens/home/profile_screen/edit_profile/edit_profile_screen.dart';
import 'package:flight_booking/screens/home/profile_screen/review_screen/review_screen.dart';
import 'package:flight_booking/screens/home/search_screen/bloc/depart/search_bloc.dart';
import 'package:flight_booking/screens/home/search_screen/bloc/return/return_search_bloc.dart';
import 'package:flight_booking/screens/home/search_screen/model/flight_search_view_model.dart';
import 'package:flight_booking/screens/home/search_screen/return_flight_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../screens/home/booking_details/booking_details_screen.dart';
import '../../screens/home/weather/weather_screen.dart';

class RouteGenerator {
  RouteGenerator._();

  static Route<dynamic>? generateRoute(RouteSettings settings) {
    Object? arguments = settings.arguments;

    switch (settings.name) {
      case Routes.authSwitchScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) => AuthSwitchScreen());

      case Routes.baseScreen:
        return MaterialPageRoute(
            settings: settings,
            builder: (_) => BlocProvider.value(
                  value: locator<ExploreBloc>()..add(const FetchExploreEvent()),
                  child: BaseScreen(),
                ));

      case Routes.loginScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) => LoginScreen());

      case Routes.registerScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) => RegisterScreen());

      case Routes.homeScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) => BaseScreen());

      case Routes.flightListScreen:
        return MaterialPageRoute(
            settings: settings,
            builder: (_) => BlocProvider.value(
                  value: locator<SearchBloc>(),
                  child: FlightListScreen(
                    flightSearchViewModel: arguments as FlightSearchViewModel,
                  ),
                ));

      case Routes.returnFlightListScreen:
        return MaterialPageRoute(
            settings: settings,
            builder: (_) => BlocProvider.value(
                  value: locator<ReturnSearchBloc>(),
                  child: ReturnFlightListScreen(
                    flightSearchViewModel: arguments as FlightSearchViewModel,
                  ),
                ));

      case Routes.bookContactScreen:
        return MaterialPageRoute(
            settings: settings,
            builder: (_) => BookContactScreen(
                  bookingModel: arguments as BookingModel,
                ));

      case Routes.bookPassengerScreen:
        return MaterialPageRoute(
            settings: settings,
            builder: (_) => BookPassengerScreen(
                  bookingModel: arguments as BookingModel,
                ));

      case Routes.bookConfirmationScreen:
        return MaterialPageRoute(
            settings: settings,
            builder: (_) => BookConfirmationScreen(
                  bookingModel: arguments as BookingModel,
                ));

      case Routes.bookingDetailsScreen:
        return MaterialPageRoute(
            settings: settings,
            builder: (_) => BookingDetailsScreen(
                  model: arguments as MyTicketModel,
                ));

      case Routes.editProfileScreen:
        return MaterialPageRoute(
            settings: settings,
            builder: (_) => BlocProvider.value(
                  value: locator<AuthBloc>(),
                  child: EditProfileScreen(
                    profileModel: arguments as ProfileModel?,
                  ),
                ));

      case Routes.weatherScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) => WeatherScreen());

      case Routes.reviewScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) => ReviewScreen());

      default:
        return MaterialPageRoute(
            settings: settings, builder: (_) => LoginScreen());
    }
  }
}
