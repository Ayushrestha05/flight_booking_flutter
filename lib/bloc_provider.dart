import 'package:flight_booking/core/services/service_locator.dart';
import 'package:flight_booking/main.dart';
import 'package:flight_booking/screens/auth/bloc/auth_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlocProviders {
  BlocProviders._();

  static injectedBlocMyApp() => MultiBlocProvider(providers: [
        BlocProvider.value(value: locator<AuthBloc>()),
      ], child: const MyApp());
}