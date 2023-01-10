import 'package:cached_network_image/cached_network_image.dart';
import 'package:flight_booking/core/constants/airport_names.dart';
import 'package:flight_booking/core/constants/image_sources.dart';
import 'package:flight_booking/core/model/class_model.dart';
import 'package:flight_booking/core/model/flight_model.dart';
import 'package:flight_booking/core/routes/route_names.dart';
import 'package:flight_booking/core/services/navigation_service.dart';
import 'package:flight_booking/core/services/service_locator.dart';
import 'package:flight_booking/core/utils/date_convert_extension.dart';
import 'package:flight_booking/widgets/buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

showFlightDetailBottomSheet(BuildContext context,
    {bool? isBooked,
    FlightModel? model,
    bool? selectTicket,
    Function()? onBookTap}) {
  ValueNotifier<int?> _selectedClass = ValueNotifier(null);
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.r), topRight: Radius.circular(20.r))),
    builder: (context) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.sp),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 19.h,
            ),
            // Heading
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Flight Details',
                  style: TextStyle(fontSize: 20.sp),
                ),
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.close))
              ],
            ),
            SizedBox(
              height: 12.h,
            ),
            // Flight Company and Logo
            Row(
              children: [
                CachedNetworkImage(
                  imageUrl: model?.company?.image ?? '',
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
                SizedBox(
                  width: 16.w,
                ),
                Text(
                  model?.company?.name ?? '',
                  style: TextStyle(fontSize: 16.sp),
                )
              ],
            ),
            SizedBox(
              height: 12.h,
            ),
            // Flight Route and Price
            buildFlightDetails(
              model: model!,
            ),
            SizedBox(
              height: 15.h,
            ),
            ValueListenableBuilder(
                valueListenable: _selectedClass,
                builder: (context, value, child) {
                  return GridView.builder(
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        childAspectRatio: 2.sp,
                        crossAxisSpacing: 10),
                    itemBuilder: (context, index) {
                      ClassModel currentClass = model.classes![index];
                      return InkWell(
                        onTap: () {
                          if (value == currentClass.id) {
                            _selectedClass.value = null;
                          } else {
                            _selectedClass.value = currentClass.id;
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.grey,
                                  width: value == currentClass.id ? 2 : 1),
                              borderRadius: BorderRadius.circular(10.r)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(currentClass.className ?? ''),
                              Text(
                                "NRs ${currentClass.price}",
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    itemCount: model.classes?.length ?? 0,
                  );
                }),
            SizedBox(
              height: 15.h,
            ),
            // Book Button
            // DefaultButton("Book Flight", onBookTap ?? () {}),
            // SizedBox(
            //   height: 15.h,
            // ),
          ],
        ),
      );
    },
  );
}

Widget buildFareDetails() {
  return Column(
    children: [
      Divider(
        color: Colors.black,
        thickness: 2,
      ),
      SizedBox(
        height: 5.h,
      ),
      // Adults and Child Price
      Row(
        children: [
          Expanded(flex: 3, child: SizedBox()),
          Text("QTY"),
          Expanded(
              flex: 2,
              child:
                  Align(alignment: Alignment.centerRight, child: Text('NPR')))
        ],
      ),
      SizedBox(
        height: 5.h,
      ),
      Row(
        children: [
          Expanded(flex: 3, child: Text('Adult Fare')),
          Text("1"),
          Expanded(
              flex: 2,
              child:
                  Align(alignment: Alignment.centerRight, child: Text('3000')))
        ],
      ),
      SizedBox(
        height: 5.h,
      ),
      Row(
        children: [
          Expanded(flex: 3, child: Text('Child Fare')),
          Text("1"),
          Expanded(
              flex: 2,
              child:
                  Align(alignment: Alignment.centerRight, child: Text('3000')))
        ],
      ),
      SizedBox(
        height: 10.h,
      ),
      Divider(
        color: Colors.black,
        thickness: 2,
      ),
      Row(
        children: [
          Expanded(flex: 3, child: Text('Total')),
          Text(""),
          Expanded(
              flex: 2,
              child:
                  Align(alignment: Alignment.centerRight, child: Text('6000')))
        ],
      ),
    ],
  );
}

Widget buildFlightDetails({
  required FlightModel model,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            AirportNames.getAirportName(airportCode: model.fromLocation!),
            style: TextStyle(fontSize: 16.sp),
          ),
          Text(
            " to ",
            style: TextStyle(fontSize: 12.sp),
          ),
          Text(
            AirportNames.getAirportName(airportCode: model.toLocation!),
            style: TextStyle(fontSize: 16.sp),
          ),
          Spacer(),
          Text(
            "${model.duration!} mins",
            style: TextStyle(fontSize: 16.sp),
          )
        ],
      ),
      Text(
        model.departureDate!.convertToDateTimeString(),
        style: TextStyle(fontSize: 16.sp),
      ),
      SizedBox(
        height: 10.h,
      ),
      // Flight Details
      IntrinsicHeight(
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        'Flight No',
                        style: TextStyle(fontSize: 14.sp),
                      ),
                      SvgPicture.asset(AssetImageSource.smallPlane),
                    ],
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Text(
                    model.flightNumber ?? '',
                    style: TextStyle(fontSize: 12.sp),
                  )
                ],
              ),
            ),
            VerticalDivider(
              color: Colors.black,
              thickness: 2,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SvgPicture.asset(AssetImageSource.bagLimit),
                      Text(
                        'Baggage Limit',
                        style: TextStyle(fontSize: 14.sp),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Text(
                    "${model.baggageLimit} Kg",
                    style: TextStyle(fontSize: 12.sp),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    ],
  );
}
