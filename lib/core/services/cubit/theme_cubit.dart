import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flight_booking/core/services/service_locator.dart';
import 'package:flight_booking/core/services/shared_pref_services.dart';

class ThemeCubit extends Cubit<bool> {
  ThemeCubit() : super(false);

  void toggleTheme() {
    locator<SharedPrefsServices>().setBool(key: "isDark", value: !state);
    emit(!state);
  }

  void setTheme(bool isDark) => emit(isDark);

  void checkTheme() {
    bool isDark =
        locator<SharedPrefsServices>().getBool(key: "isDark") ?? false;
    if (isDark) {
      emit(true);
    } else {
      emit(false);
    }
  }
}
