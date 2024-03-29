import 'package:flight_booking/core/constants/image_sources.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../core/constants/airport_names.dart';

Container departureDestinationWidget(
    {required BuildContext context,
    required String departCode,
    required String destinationCode,
    Color? color}) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 10.w),
    child: Row(
      children: [
        Expanded(
            child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  departCode,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20.sp,
                      color: color),
                ),
                Text(
                  AirportNames.getAirportName(airportCode: departCode),
                  style: TextStyle(color: color),
                )
              ],
            ),
            SizedBox(
              width: 10.w,
            ),
            Expanded(
                child: Divider(
              thickness: 2,
              color: color ??
                  (Theme.of(context).brightness == Brightness.light
                      ? Colors.black
                      : Colors.white),
            )),
            SizedBox(
              width: 10.w,
            ),
          ],
        )),
        SvgPicture.asset(AssetImageSource.linearPlane, color: color),
        Expanded(
            child: Row(
          children: [
            SizedBox(
              width: 10.w,
            ),
            Expanded(
                child: Divider(
              thickness: 2,
              color: color ??
                  (Theme.of(context).brightness == Brightness.light
                      ? Colors.black
                      : Colors.white),
            )),
            SizedBox(
              width: 10.w,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  destinationCode,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20.sp,
                      color: color),
                ),
                Text(
                  AirportNames.getAirportName(airportCode: destinationCode),
                  style: TextStyle(color: color),
                )
              ],
            )
          ],
        ))
      ],
    ),
  );
}
