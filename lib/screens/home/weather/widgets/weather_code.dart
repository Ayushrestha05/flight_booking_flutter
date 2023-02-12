import 'package:flutter/material.dart';

IconData getWeatherIcon({required int weatherCode}) {

  if (weatherCode == 0) {
    return Icons.sunny;
  } else if ([1, 2, 3].contains(weatherCode)) {
    return Icons.cloud;
  } else if ([45, 48].contains(weatherCode)) {
    return Icons.foggy;
  } else if ([51, 53, 55, 56, 57, 80, 81, 82, 85, 86].contains(weatherCode)) {
    return Icons.cloudy_snowing;
  } else if ([61, 63, 65, 66, 67].contains(weatherCode)) {
    return Icons.sunny;
  } else if ([71, 73, 75, 77].contains(weatherCode)) {
    return Icons.ac_unit;
  } else if ([95, 96, 99].contains(weatherCode)) {
    return Icons.thunderstorm;
  } else {
    return Icons.sunny;
  }
}
