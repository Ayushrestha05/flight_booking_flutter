import 'package:flight_booking/core/constants/airport_names.dart';
import 'package:flight_booking/core/constants/image_sources.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MyTicketsScreen extends StatelessWidget {
  const MyTicketsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.w),
      child: ListView.builder(
        itemCount: 1,
        itemBuilder: (context, index) {
          return Card(
            clipBehavior: Clip.antiAlias,
            child: Column(
              children: [
                SizedBox(
                  height: 10.h,
                ),
                //Flight Details Widget
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10.w),
                  child: IntrinsicHeight(
                    child: Row(
                      children: [
                        Card(
                          shape: CircleBorder(),
                          child: CircleAvatar(
                            radius: 25.r,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 10.w),
                          child: VerticalDivider(
                            color: Colors.black, //color of divider
                            width: 10, //width space of divider
                            thickness: 2, //thickness of divier line
                            //Spacing at the bottom of divider.
                          ),
                        ),
                        Expanded(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Yeti Airlines",
                                  style: TextStyle(
                                      fontFamily: "SFPro", fontSize: 14.sp),
                                ),
                                Text(
                                  "8 Nov 2022",
                                  style: TextStyle(
                                      fontFamily: "SFPro",
                                      fontSize: 14.sp,
                                      color: Color(0xFF65676B)),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 5.h,
                            ),
                            Row(
                              children: [
                                SvgPicture.asset(ImageSource.smallPlane),
                                SizedBox(
                                  width: 5.w,
                                ),
                                Text(
                                  "GUA0002",
                                ),
                                SizedBox(
                                  width: 10.w,
                                ),
                                SvgPicture.asset(ImageSource.bagLimit),
                                SizedBox(
                                  width: 5.w,
                                ),
                                Text("15 KG")
                              ],
                            ),
                          ],
                        ))
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                // Departure and Destination Location Widget
                departureDestinationWidget(
                    context: context,
                    departCode: "KTM",
                    destinationCode: "ILM"),
                SizedBox(
                  height: 10.h,
                ),
                //Price and View Detail Container
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                  color: Colors.green[700],
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "NPR 3000",
                        style: TextStyle(
                            fontFamily: "SFPro",
                            fontWeight: FontWeight.bold,
                            fontSize: 16.sp,
                            color: Colors.white),
                      ),
                      Text(
                        "View Details >",
                        style: TextStyle(
                            fontFamily: "SFPro",
                            color: Colors.white,
                            fontSize: 14.sp),
                      )
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }

  Container departureDestinationWidget(
      {required BuildContext context,
      required String departCode,
      required String destinationCode}) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.w),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                departCode,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.sp),
              ),
              Text(AirportNames.getAirportName(airportCode: departCode))
            ],
          ),
          SizedBox(
            width: 10.w,
          ),
          Expanded(
              child: Divider(
            thickness: 2,
            color: Theme.of(context).brightness == Brightness.light
                ? Colors.black
                : Colors.white,
          )),
          SizedBox(
            width: 10.w,
          ),
          SvgPicture.asset(ImageSource.linearPlane),
          SizedBox(
            width: 10.w,
          ),
          Expanded(
              child: Divider(
            thickness: 2,
            color: Theme.of(context).brightness == Brightness.light
                ? Colors.black
                : Colors.white,
          )),
          SizedBox(
            width: 10.w,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                destinationCode,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.sp),
              ),
              Text(AirportNames.getAirportName(airportCode: destinationCode))
            ],
          )
        ],
      ),
    );
  }
}
