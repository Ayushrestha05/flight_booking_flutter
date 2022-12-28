import 'package:bot_toast/bot_toast.dart';
import 'package:flight_booking/bloc_provider.dart';
import 'package:flight_booking/core/routes/route_names.dart';
import 'package:flight_booking/screens/auth/bloc/auth_bloc.dart';
import 'package:flight_booking/screens/home/explore_screen/bloc/bloc/explore_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'core/routes/export_routes.dart';
import 'core/routes/route_generator.dart';
import 'core/services/navigation_service.dart';
import 'core/services/service_locator.dart';
import 'core/services/shared_pref_services.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  await Future.wait(
    [
      setupLocator().then(
        (value) async => {
          await locator<SharedPrefsServices>().init(),
        },
      ),
    ],
  );
  runApp(BlocProviders.injectedBlocMyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(360, 640),
        builder: (context, child) {
          return MaterialApp(
            title: 'Flight Booking',
            theme: ThemeData(primaryColor: const Color(0xFF03314B)),
            home: const AuthSwitchScreen(),
            builder: BotToastInit(), //1. call BotToastInit
            navigatorObservers: [BotToastNavigatorObserver()],
            onGenerateRoute: RouteGenerator.generateRoute,
            navigatorKey: NavigationService.navigatorKey,
            routes: {
              Routes.authSwitchScreen: (context) => const AuthSwitchScreen(),
              Routes.baseScreen: (context) => BlocProvider.value(
                    value: locator<ExploreBloc>()
                      ..add(const FetchExploreEvent()),
                    child: BaseScreen(),
                  ),
            },
          );
        });
  }
}

class AuthSwitchScreen extends StatelessWidget {
  const AuthSwitchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state.profileModel != null) {
          // locator<ExploreBloc>().add(const FetchExploreEvent());
          return BlocProvider.value(
            value: locator<ExploreBloc>()..add(const FetchExploreEvent()),
            child: BaseScreen(),
          );
        }
        return LoginScreen();
      },
    );
  }
}


//TODO Add Bot Toasts and Add Loading Indicators in Network Calls 