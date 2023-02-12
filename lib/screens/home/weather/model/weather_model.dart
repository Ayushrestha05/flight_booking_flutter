// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class WeatherModel {
  double? latitude;
  double? longitude;
  double? generationtimeMs;
  int? utcOffsetSeconds;
  String? timezone;
  String? timezoneAbbreviation;
  double? elevation;
  CurrentWeather? currentWeather;
  DailyUnits? dailyUnits;
  Daily? daily;

  WeatherModel(
      {this.latitude,
      this.longitude,
      this.generationtimeMs,
      this.utcOffsetSeconds,
      this.timezone,
      this.timezoneAbbreviation,
      this.elevation,
      this.currentWeather,
      this.dailyUnits,
      this.daily});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'latitude': latitude,
      'longitude': longitude,
      'generationtimeMs': generationtimeMs,
      'utcOffsetSeconds': utcOffsetSeconds,
      'timezone': timezone,
      'timezoneAbbreviation': timezoneAbbreviation,
      'elevation': elevation,
      'currentWeather': currentWeather?.toMap(),
      'dailyUnits': dailyUnits?.toMap(),
      'daily': daily?.toMap(),
    };
  }

  factory WeatherModel.fromMap(Map<String, dynamic> map) {
    return WeatherModel(
      latitude: map['latitude'] != null ? map['latitude'] as double : null,
      longitude: map['longitude'] != null ? map['longitude'] as double : null,
      generationtimeMs: map['generationtimeMs'] != null
          ? map['generationtimeMs'] as double
          : null,
      utcOffsetSeconds: map['utcOffsetSeconds'] != null
          ? map['utcOffsetSeconds'] as int
          : null,
      timezone: map['timezone'] != null ? map['timezone'] as String : null,
      timezoneAbbreviation: map['timezoneAbbreviation'] != null
          ? map['timezoneAbbreviation'] as String
          : null,
      elevation: map['elevation'],
      currentWeather: map['current_weather'] != null
          ? CurrentWeather.fromMap(
              map['current_weather'] as Map<String, dynamic>)
          : null,
      dailyUnits: map['dailyUnits'] != null
          ? DailyUnits.fromMap(map['dailyUnits'] as Map<String, dynamic>)
          : null,
      daily: map['daily'] != null
          ? Daily.fromMap(map['daily'] as Map<String, dynamic>)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory WeatherModel.fromJson(String source) =>
      WeatherModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

class CurrentWeather {
  double? temperature;
  double? windspeed;
  double? winddirection;
  int? weathercode;
  String? time;

  CurrentWeather(
      {this.temperature,
      this.windspeed,
      this.winddirection,
      this.weathercode,
      this.time});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'temperature': temperature,
      'windspeed': windspeed,
      'winddirection': winddirection,
      'weathercode': weathercode,
      'time': time,
    };
  }

  factory CurrentWeather.fromMap(Map<String, dynamic> map) {
    return CurrentWeather(
      temperature: map['temperature'],
      windspeed: map['windspeed'],
      winddirection: map['winddirection'],
      weathercode: map['weathercode'],
      time: map['time'],
    );
  }

  String toJson() => json.encode(toMap());

  factory CurrentWeather.fromJson(String source) =>
      CurrentWeather.fromMap(json.decode(source) as Map<String, dynamic>);
}

class DailyUnits {
  String? time;
  String? weathercode;
  String? apparentTemperatureMax;
  String? apparentTemperatureMin;

  DailyUnits(
      {this.time,
      this.weathercode,
      this.apparentTemperatureMax,
      this.apparentTemperatureMin});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'time': time,
      'weathercode': weathercode,
      'apparentTemperatureMax': apparentTemperatureMax,
      'apparentTemperatureMin': apparentTemperatureMin,
    };
  }

  factory DailyUnits.fromMap(Map<String, dynamic> map) {
    return DailyUnits(
      time: map['time'] != null ? map['time'] as String : null,
      weathercode:
          map['weathercode'] != null ? map['weathercode'] as String : null,
      apparentTemperatureMax: map['apparent_temperature_max'] != null
          ? map['apparent_temperature_max'] as String
          : null,
      apparentTemperatureMin: map['apparent_temperature_min'] != null
          ? map['apparent_temperature_min'] as String
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory DailyUnits.fromJson(String source) =>
      DailyUnits.fromMap(json.decode(source) as Map<String, dynamic>);
}

class Daily {
  List? time;
  List? weathercode;
  List? apparentTemperatureMax;
  List? apparentTemperatureMin;

  Daily(
      {this.time,
      this.weathercode,
      this.apparentTemperatureMax,
      this.apparentTemperatureMin});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'time': time,
      'weathercode': weathercode,
      'apparent_temperature_max': apparentTemperatureMax,
      'apparent_temperature_min': apparentTemperatureMin,
    };
  }

  factory Daily.fromMap(Map<String, dynamic> map) {
    return Daily(
      time: map['time'],
      weathercode: map['weathercode'],
      apparentTemperatureMax: map['apparent_temperature_max'],
      apparentTemperatureMin: map['apparent_temperature_min'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Daily.fromJson(String source) =>
      Daily.fromMap(json.decode(source) as Map<String, dynamic>);
}
