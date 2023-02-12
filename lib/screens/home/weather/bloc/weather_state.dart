part of 'weather_bloc.dart';

class WeatherState {
  WeatherModel? weatherModel;
  Placemark? locationAddress;
  WeatherState({this.weatherModel, this.locationAddress});
}

enum WeatherStatus { initial, loading, success, failure }
