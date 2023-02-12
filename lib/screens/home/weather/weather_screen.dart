import 'dart:math';

import 'package:flight_booking/core/services/service_locator.dart';
import 'package:flight_booking/screens/home/weather/bloc/weather_bloc.dart';
import 'package:flight_booking/screens/home/weather/widgets/weather_code.dart';
import 'package:flight_booking/widgets/screen_padding.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  TextStyle style = TextStyle(fontFamily: 'SFPro', color: Colors.white);
  @override
  void initState() {
    super.initState();
    locator<WeatherBloc>().add(GetCurrentWeatherEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeatherBloc, WeatherState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Color(0xFF669CCB),
          body: SafeArea(
            child: ScreenPadding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                  "${state.weatherModel?.currentWeather?.temperature ?? 'N/A'}°",
                                  style: TextStyle(
                                      fontFamily: 'SFPro',
                                      fontSize: 50.sp,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold)),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(Icons.place, color: Colors.white),
                                  SizedBox(
                                    width: 5.w,
                                  ),
                                  Text(
                                      (state.locationAddress?.subLocality ?? '')
                                              .isNotEmpty
                                          ? state.locationAddress
                                                  ?.subLocality ??
                                              ''
                                          : (state.locationAddress?.locality ??
                                                      '')
                                                  .isNotEmpty
                                              ? state.locationAddress
                                                      ?.locality ??
                                                  ''
                                              : (state.locationAddress
                                                              ?.administrativeArea ??
                                                          '')
                                                      .isNotEmpty
                                                  ? state.locationAddress
                                                          ?.administrativeArea ??
                                                      ''
                                                  : 'N/A',
                                      style: TextStyle(
                                          fontFamily: 'SFPro',
                                          fontSize: 20.sp,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold)),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Icon(
                          getWeatherIcon(
                              weatherCode: state.weatherModel?.currentWeather
                                      ?.weathercode ??
                                  0),
                          size: 50.sp,
                          color: Colors.white,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.air,
                          color: Colors.white,
                          size: 30.sp,
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        Text(
                          "${state.weatherModel?.currentWeather?.windspeed ?? 'N/A'} Km/h",
                          style: style.copyWith(fontWeight: FontWeight.bold),
                        ),
                        Spacer(),
                        Text(
                          "${state.weatherModel?.currentWeather?.winddirection ?? 'N/A'}°",
                          style: style.copyWith(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        Transform.rotate(
                            angle: (state.weatherModel?.currentWeather
                                        ?.winddirection ??
                                    0) *
                                pi /
                                180,
                            child: Icon(
                              Icons.navigation,
                              color: Colors.white,
                              size: 30.sp,
                            )),
                      ],
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Divider(
                      color: Colors.white,
                      thickness: 2.sp,
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Container(
                        color: Color(0xFF377CBA),
                        padding: EdgeInsets.symmetric(
                            horizontal: 10.w, vertical: 5.h),
                        child: Column(
                          children: [
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Date',
                                    style: style.copyWith(
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Spacer(),
                                  Text(
                                    'Max Temp.',
                                    style: style.copyWith(
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    width: 20.w,
                                  ),
                                  Text(
                                    'Min Temp.',
                                    style: style.copyWith(
                                        fontWeight: FontWeight.bold),
                                  )
                                ]),
                            ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount:
                                  state.weatherModel?.daily?.time?.length ?? 0,
                              itemBuilder: (context, index) => Container(
                                color: Color(0xFF377CBA),
                                padding: EdgeInsets.symmetric(vertical: 5.h),
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        state.weatherModel!.daily!.time![index],
                                        style: style,
                                      ),
                                      Icon(
                                        getWeatherIcon(
                                            weatherCode: state.weatherModel!
                                                .daily!.weathercode![index]),
                                        color: Colors.white,
                                      ),
                                      Text(
                                        "${state.weatherModel!.daily!.apparentTemperatureMax![index]}°C",
                                        style: style,
                                      ),
                                      Text(
                                        "${state.weatherModel!.daily!.apparentTemperatureMin![index]}°C",
                                        style: style,
                                      ),
                                    ]),
                              ),
                            ),
                          ],
                        )),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
