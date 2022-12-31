import 'package:flight_booking/core/network/api_manager.dart';
import 'package:flight_booking/core/services/cubit/navigation_cubit.dart';
import 'package:flight_booking/core/services/cubit/theme_cubit.dart';
import 'package:flight_booking/core/services/navigation_service.dart';
import 'package:flight_booking/core/services/shared_pref_services.dart';
import 'package:flight_booking/screens/auth/bloc/auth_bloc.dart';
import 'package:flight_booking/screens/home/explore_screen/bloc/bloc/explore_bloc.dart';
import 'package:flight_booking/screens/home/my_tickets/bloc/my_ticket_bloc.dart';
import 'package:flight_booking/screens/home/search_screen/bloc/depart/search_bloc.dart';
import 'package:flight_booking/screens/home/search_screen/bloc/return/return_search_bloc.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;

Future<void> setupLocator() async {
  locator.registerSingleton<SharedPrefsServices>(SharedPrefsServices());
  locator.registerSingleton<NavigationService>(NavigationService());
  locator.registerSingleton<ApiManager>(ApiManager());

  //Blocs
  locator.registerSingleton<AuthBloc>(AuthBloc());
  locator.registerSingleton<ExploreBloc>(ExploreBloc());
  locator.registerLazySingleton<SearchBloc>(() => SearchBloc());
  locator.registerLazySingleton<ReturnSearchBloc>(() => ReturnSearchBloc());
  locator.registerLazySingleton<MyTicketBloc>(() => MyTicketBloc());
  locator.registerLazySingleton<NavigationCubit>(() => NavigationCubit());
  locator.registerLazySingleton<ThemeCubit>(() => ThemeCubit());
}
