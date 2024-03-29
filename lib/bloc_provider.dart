import 'package:flight_booking/core/services/cubit/navigation_cubit.dart';
import 'package:flight_booking/core/services/service_locator.dart';
import 'package:flight_booking/main.dart';
import 'package:flight_booking/screens/auth/bloc/auth_bloc.dart';
import 'package:flight_booking/screens/home/weather/bloc/weather_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/services/cubit/theme_cubit.dart';

class BlocProviders {
  BlocProviders._();

  static injectedBlocMyApp() => MultiBlocProvider(providers: [
        BlocProvider.value(value: locator<AuthBloc>()..add(CheckAuthEvent())),
        BlocProvider.value(value: locator<NavigationCubit>()),
        BlocProvider.value(value: locator<ThemeCubit>()),
        BlocProvider.value(
            value: locator<WeatherBloc>()..add(GetCurrentWeatherEvent()))
      ], child: const MyApp());
}
