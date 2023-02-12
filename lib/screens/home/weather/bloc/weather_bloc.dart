import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flight_booking/core/network/api_manager.dart';
import 'package:flight_booking/screens/home/weather/model/weather_model.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherBloc() : super(WeatherState()) {
    on<GetCurrentWeatherEvent>((event, emit) async {
      LocationPermission permission = await Geolocator.checkPermission();
      Position? position;
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever ||
          permission == LocationPermission.unableToDetermine) {
        permission = await Geolocator.requestPermission();
      } else if (permission == LocationPermission.always ||
          permission == LocationPermission.whileInUse) {
        position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.medium);
      }

      if (position != null) {
        List<Placemark> placemarks = await placemarkFromCoordinates(
            position.latitude, position.longitude);

        Response response = await ApiManager().dio!.get(
            'https://api.open-meteo.com/v1/forecast?latitude=${position.latitude}&longitude=${position.longitude}&current_weather=true&daily=weathercode,apparent_temperature_max,apparent_temperature_min&timezone=auto');
        WeatherModel weatherModel = WeatherModel.fromMap(response.data);
        emit(WeatherState(
            weatherModel: weatherModel, locationAddress: placemarks[0]));
      } else {
        List<Placemark> placemarks =
            await placemarkFromCoordinates(27.69, 85.34);
        Response response = await ApiManager().dio!.get(
            'https://api.open-meteo.com/v1/forecast?latitude=27.69&longitude=85.34&current_weather=true&daily=weathercode,apparent_temperature_max,apparent_temperature_min&timezone=auto');
        WeatherModel weatherModel = WeatherModel.fromMap(response.data);
        emit(WeatherState(
            weatherModel: weatherModel, locationAddress: placemarks[0]));
      }
    });
  }
}
