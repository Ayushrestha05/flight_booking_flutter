import 'package:flight_booking/core/constants/image_sources.dart';
import 'package:flight_booking/widgets/departDestination_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

Card ticketCard(BuildContext context) {
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
  }