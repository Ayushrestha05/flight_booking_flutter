import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

showFlightSortBottomSheet(BuildContext context) {
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
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 20.h,
            ),
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
            Text(
              'Lowest Price',
              style: TextStyle(fontSize: 14.sp),
            ),
            SizedBox(
              height: 10.h,
            ),
            Text(
              'Highest Price',
              style: TextStyle(fontSize: 14.sp),
            ),
            SizedBox(
              height: 10.h,
            ),
            Text(
              'Shortest Duration',
              style: TextStyle(fontSize: 14.sp),
            ),
            SizedBox(
              height: 10.h,
            ),
            Text(
              'Ascending Order',
              style: TextStyle(fontSize: 14.sp),
            ),
            SizedBox(
              height: 10.h,
            ),
            Text(
              'Descending Order',
              style: TextStyle(fontSize: 14.sp),
            ),
            SizedBox(
              height: 20.h,
            ),
          ],
        ),
      );
    },
  );
}
