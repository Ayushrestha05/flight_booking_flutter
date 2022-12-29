import 'package:cached_network_image/cached_network_image.dart';
import 'package:flight_booking/core/constants/image_sources.dart';
import 'package:flight_booking/core/model/flight_model.dart';
import 'package:flight_booking/screens/home/my_tickets/model/my_ticket_model.dart';
import 'package:flight_booking/widgets/departDestination_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flight_booking/core/utils/date_convert_extension.dart';
import 'package:intl/intl.dart';

/// Build a Ticket Card Widget
Widget buildTicketCard(BuildContext context,
    {Function()? onTap, FlightModel? flightModel}) {
  return Card(
    clipBehavior: Clip.antiAlias,
    child: InkWell(
      onTap: onTap,
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
                    child: CachedNetworkImage(
                      imageUrl: flightModel?.company?.image ?? '',
                      placeholder: (context, url) => CircleAvatar(
                        radius: 25.r,
                        backgroundImage:
                            AssetImage(AssetImageSource.imagePlaceholder),
                      ),
                      errorWidget: (context, url, error) => CircleAvatar(
                        radius: 25.r,
                        backgroundImage:
                            AssetImage(AssetImageSource.imagePlaceholder),
                      ),
                      imageBuilder: (context, imageProvider) => CircleAvatar(
                        radius: 25.r,
                        backgroundImage: imageProvider,
                      ),
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
                            flightModel?.company?.name ?? "",
                            style:
                                TextStyle(fontFamily: "SFPro", fontSize: 14.sp),
                          ),
                          Text(
                            flightModel?.departureDate
                                    ?.convertToDateTimeString() ??
                                "Departure Date",
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
                          SvgPicture.asset(AssetImageSource.smallPlane),
                          SizedBox(
                            width: 5.w,
                          ),
                          Text(
                            flightModel?.flightNumber ?? '',
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          SvgPicture.asset(AssetImageSource.bagLimit),
                          SizedBox(
                            width: 5.w,
                          ),
                          Text("${flightModel?.baggageLimit ?? 20} KG"),
                          Spacer(),
                          Text(
                            "${DateFormat("hh:mm a").format(flightModel?.departureDate ?? DateTime.now())}",
                            style: TextStyle(
                                fontFamily: "SFPro",
                                fontSize: 14.sp,
                                color: Color(0xFF65676B)),
                          )
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
              departCode: flightModel?.fromLocation ?? "KTM",
              destinationCode: flightModel?.toLocation ?? "ILM"),
          SizedBox(
            height: 10.h,
          ),
          //Price and View Detail Container
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
            color: Colors.green[700],
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(),
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
    ),
  );
}

/// Build a Booking Card Widget
Widget buildBookingCardWidget(BuildContext context,
    {Function()? onTap, MyTicketModel? model}) {
  return Card(
    clipBehavior: Clip.antiAlias,
    child: InkWell(
      onTap: onTap,
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
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            model?.departure_flight != null
                                ? 'Two-Way'
                                : 'One-Way',
                            style:
                                TextStyle(fontFamily: "SFPro", fontSize: 14.sp),
                          ),
                          Text(
                            model?.arrival_flight?.flight?.departureDate
                                    ?.convertToDateTimeString() ??
                                "Departure Date",
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
                          Text(
                              "${model?.passengers?.where((element) => (element.is_child ?? false) == false).length.toString() ?? "1"} Adult"),
                          SizedBox(
                            width: 10.w,
                          ),
                          if (model?.passengers
                                  ?.where((element) =>
                                      (element.is_child ?? false) == true)
                                  .length !=
                              0)
                            Text(
                                "${model?.passengers?.where((element) => (element.is_child ?? false) == true).length.toString() ?? "1"} Child"),
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
              departCode: model?.arrival_flight?.flight?.fromLocation ?? "KTM",
              destinationCode:
                  model?.arrival_flight?.flight?.toLocation ?? "ILM"),
          SizedBox(
            height: 10.h,
          ),
          //Price and View Detail Container
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
            color: Colors.green[700],
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(),
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
    ),
  );
}
