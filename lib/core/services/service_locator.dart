import 'package:flight_booking/core/network/api_manager.dart';
import 'package:flight_booking/core/services/navigation_service.dart';
import 'package:flight_booking/core/services/shared_pref_services.dart';
import 'package:flight_booking/screens/auth/bloc/auth_bloc.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;

Future<void> setupLocator() async {
  locator.registerSingleton<SharedPrefsServices>(SharedPrefsServices());
  locator.registerSingleton<NavigationService>(NavigationService());
  locator.registerSingleton<ApiManager>(ApiManager());

  //Blocs
  locator.registerSingleton<AuthBloc>(AuthBloc());
}
