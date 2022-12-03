import 'package:flight_booking/core/constants/image_sources.dart';
import 'package:flight_booking/widgets/screen_padding.dart';
import 'package:flight_booking/widgets/ticketCard_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BookConfirmationScreen extends StatelessWidget {
  const BookConfirmationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Booking Information')),
      body: SafeArea(
          child: SingleChildScrollView(
        child: ScreenPadding(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 15.h,
            ),
            Text(
              'Passenger Information',
              style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10.h,
            ),
            buildTicketCard(context),
            SizedBox(
              height: 10.h,
            ),
            Text(
              'Contact Information',
              style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10.h,
            ),
            Card(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 14.h, vertical: 12.h),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Icon(Icons.account_circle_outlined),
                        SizedBox(
                          width: 10.w,
                        ),
                        Expanded(child: Text('Sanskriti Pokharel'))
                      ],
                    ),
                    SizedBox(
                      height: 6.h,
                    ),
                    Row(
                      children: [
                        Icon(Icons.perm_phone_msg_outlined),
                        SizedBox(
                          width: 10.w,
                        ),
                        Expanded(child: Text('98XX-XXXXXX'))
                      ],
                    ),
                    SizedBox(
                      height: 6.h,
                    ),
                    Row(
                      children: [
                        Icon(Icons.alternate_email),
                        SizedBox(
                          width: 10.w,
                        ),
                        Expanded(child: Text('sanskriti@gmail.com'))
                      ],
                    ),
                    SizedBox(
                      height: 6.h,
                    ),
                    Row(
                      children: [
                        Icon(Icons.flag_outlined),
                        SizedBox(
                          width: 10.w,
                        ),
                        Expanded(child: Text('Nepal'))
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Text(
              'Passengers',
              style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10.h,
            ),
            Card(
                child: ExpansionTile(
              title: Text("Adult 1"),
              expandedAlignment: Alignment.centerLeft,
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(16.sp, 0, 16.sp, 16.sp),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [Text('Sanskriti Pokharel'), Text('Nepal')],
                  ),
                )
              ],
            )),
            SizedBox(
              height: 10.h,
            ),
            Text(
              'Payment Methods',
              style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 15.h,
            ),
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(10.r)),
                  child: Image.asset(
                    ImageSource.esewaIMG,
                    height: 60.h,
                    width: 100.w,
                  ),
                ),
                SizedBox(
                  width: 10.w,
                ),
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(10.r)),
                  child: Image.asset(
                    ImageSource.khaltiIMG,
                    height: 60.h,
                    width: 100.w,
                  ),
                ),
              ],
            )
          ],
        )),
      )),
    );
  }
}
