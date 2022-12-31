import 'dart:convert';
import 'dart:io';

import 'package:bot_toast/bot_toast.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flight_booking/core/services/auth_service.dart';
import 'package:flight_booking/core/services/navigation_service.dart';
import 'package:flight_booking/core/services/service_locator.dart';
import 'package:flight_booking/core/services/shared_pref_services.dart';
import 'package:flight_booking/core/utils/decode_api.dart';
import 'package:flight_booking/core/utils/show_toast.dart';
import 'package:flight_booking/screens/auth/model/profile_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthState()) {
    on<AuthEvent>((event, emit) {});

    on<CheckAuthEvent>((event, emit) async {
      String? token =
          locator<SharedPrefsServices>().getString(key: 'auth_token');
      String? userData =
          locator<SharedPrefsServices>().getString(key: 'user_data');

      Either<ProfileModel, Failure> data = await AuthService.getProfile();

      data.fold((value) {
        locator<SharedPrefsServices>()
            .setString(key: 'auth_token', value: value.token!);
        locator<SharedPrefsServices>()
            .setString(key: 'user_data', value: jsonEncode(value));
        emit(AuthState(profileModel: value));
      }, (r) {
        if (token != null && userData != null) {
          emit(AuthState(profileModel: ProfileModel.fromSharedPrefs(userData)));
        } else {
          emit(AuthState());
        }
      });
    });

    on<LoginEvent>((event, emit) async {
      var cancel = BotToast.showLoading();
      Either<ProfileModel, Failure> data =
          await AuthService.login(email: event.email, password: event.password);

      data.fold((value) {
        cancel();
        locator<SharedPrefsServices>()
            .setString(key: 'auth_token', value: value.token!);
        locator<SharedPrefsServices>()
            .setString(key: 'user_data', value: jsonEncode(value));
        emit(AuthState(profileModel: value));
      }, (failure) {
        cancel();
        showToast(failure.message, toastType: ToastType.error);
        emit(AuthState(failure: failure));
      });
    });

    on<RegisterEvent>((event, emit) async {
      var cancel = BotToast.showLoading();
      Either<ProfileModel, Failure> data = await AuthService.register(
          fullName: event.fullName,
          email: event.email,
          password: event.password);

      data.fold((value) {
        cancel();
        locator<SharedPrefsServices>()
            .setString(key: 'auth_token', value: value.token!);
        locator<SharedPrefsServices>()
            .setString(key: 'user_data', value: jsonEncode(value));
        emit(AuthState(profileModel: value));
        locator<NavigationService>().pop();
      }, (failure) {
        cancel();
        showToast(failure.message, toastType: ToastType.error);
        emit(AuthState(failure: failure));
      });
    });

    on<LogoutEvent>((event, emit) async {
      Either<bool, Failure> data = await AuthService.logout();
      data.fold((value) {
        showToast("Logged Out Successfully", toastType: ToastType.success);
        locator<SharedPrefsServices>().remove(key: 'auth_token');
        locator<SharedPrefsServices>().remove(key: 'user_data');
        emit(AuthState());
      }, (failure) {
        locator<SharedPrefsServices>().remove(key: 'auth_token');
        locator<SharedPrefsServices>().remove(key: 'user_data');
        emit(AuthState());
      });
    });

    on<UpdateProfileEvent>((event, emit) async {
      var cancel = BotToast.showLoading();
      Either<ProfileModel, Failure> data = await AuthService.updateProfile(
          fullName: event.fullName,
          password: event.password,
          image: event.image);

      data.fold((value) {
        cancel();
        locator<SharedPrefsServices>()
            .setString(key: 'user_data', value: jsonEncode(value));
        emit(state.copyWith(profileModel: value));
        locator<NavigationService>().pop();
      }, (failure) {
        cancel();
        showToast(failure.message, toastType: ToastType.error);
      });
    });
  }
}
