import 'package:flight_booking/core/constants/image_sources.dart';
import 'package:flight_booking/widgets/buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

showFlightDetailBottomSheet(BuildContext context) {
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
                CircleAvatar(
                  radius: 25.r,
                ),
                SizedBox(
                  width: 16.w,
                ),
                Text(
                  'Yeti Airlines',
                  style: TextStyle(fontSize: 16.sp),
                )
              ],
            ),
            SizedBox(
              height: 12.h,
            ),
            // Flight Route and Price
            _buildFlightDetails(),
            SizedBox(
              height: 15.h,
            ),
            _buildFareDetails(),
            SizedBox(
              height: 15.h,
            ),
            // Book Button
            DefaultButton("Book Flight", () {}),
            SizedBox(
              height: 15.h,
            ),
          ],
        ),
      );
    },
  );
}

Widget _buildFareDetails() {
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

Widget _buildFlightDetails() {
  return Column(
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            "Kathmandu",
            style: TextStyle(fontSize: 16.sp),
          ),
          Text(
            " to ",
            style: TextStyle(fontSize: 12.sp),
          ),
          Text(
            "Pokhara",
            style: TextStyle(fontSize: 16.sp),
          ),
          Spacer(),
          Text(
            "25 mins",
            style: TextStyle(fontSize: 16.sp),
          )
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "8 Nov 2022",
            style: TextStyle(fontSize: 16.sp),
          ),
          Text(
            "NPR 3000",
            style: TextStyle(fontSize: 16.sp),
          )
        ],
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
                      SvgPicture.asset(ImageSource.smallPlane),
                    ],
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Text(
                    "GUA663",
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
                      SvgPicture.asset(ImageSource.bagLimit),
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
                    "15 Kg",
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
