import 'dart:convert';

import 'package:bot_toast/bot_toast.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flight_booking/bloc_provider.dart';
import 'package:flight_booking/core/routes/route_names.dart';
import 'package:flight_booking/screens/auth/bloc/auth_bloc.dart';
import 'package:flight_booking/screens/home/explore_screen/bloc/bloc/explore_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'core/routes/export_routes.dart';
import 'core/routes/route_generator.dart';
import 'core/services/navigation_service.dart';
import 'core/services/service_locator.dart';
import 'core/services/shared_pref_services.dart';

late String token;
FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');

const InitializationSettings initializationSettings =
    InitializationSettings(android: initializationSettingsAndroid);

//Recieve message when app is in background
Future<void> backgroundHandler(RemoteMessage message) async {
  //print(message.data.toString());
}

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  FirebaseMessaging.onBackgroundMessage(backgroundHandler);
  FirebaseMessaging.instance.subscribeToTopic("all");
  token = (await FirebaseMessaging.instance.getToken())!;
  print("Token: $token");
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

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
    );

    FirebaseMessaging.instance.getInitialMessage().then((message) {
      print("Get Initial Message");
      if (message != null) {}
    });

    //Foreground
    FirebaseMessaging.onMessage.listen((message) {
      flutterLocalNotificationsPlugin.show(
        message.notification.hashCode,
        message.notification!.title,
        message.notification!.body,
        const NotificationDetails(
          android: AndroidNotificationDetails(
              'high_importance_channel', 'High Importance Notifications',
              importance: Importance.max,
              priority: Priority.high,
              playSound: true,
              color: Colors.blue,
              icon: '@mipmap/ic_launcher'),
        ),
        payload: jsonEncode(message.data),
      );
    });

    //Background but not terminated
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      print("On Message Opened");
      print(message.data.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(360, 640),
        builder: (context, child) {
          return MaterialApp(
            title: 'Flight Booking',
            debugShowCheckedModeBanner: false,
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