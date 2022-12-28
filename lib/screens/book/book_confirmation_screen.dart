import 'package:bot_toast/bot_toast.dart';
import 'package:dartz/dartz.dart';
import 'package:flight_booking/core/constants/image_sources.dart';
import 'package:flight_booking/core/model/book_model.dart';
import 'package:flight_booking/core/routes/route_names.dart';
import 'package:flight_booking/core/services/navigation_service.dart';
import 'package:flight_booking/core/services/service_locator.dart';
import 'package:flight_booking/core/utils/show_toast.dart';
import 'package:flight_booking/screens/book/repository/booking_repo.dart';
import 'package:flight_booking/widgets/buttons.dart';
import 'package:flight_booking/widgets/screen_padding.dart';
import 'package:flight_booking/widgets/ticketCard_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BookConfirmationScreen extends StatelessWidget {
  final BookingModel bookingModel;
  const BookConfirmationScreen({super.key, required this.bookingModel});

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
            Text(
              'Going Flight',
              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
            ),
            buildTicketCard(context, flightModel: bookingModel.arrival_flight),
            if (bookingModel.departure_flight != null)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 10.h,
                  ),
                  Text(
                    'Returning Flight',
                    style:
                        TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
                  ),
                  buildTicketCard(context,
                      flightModel: bookingModel.departure_flight),
                ],
              ),
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
                        Expanded(child: Text(bookingModel.name ?? ''))
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
                        Expanded(child: Text(bookingModel.phone ?? ''))
                      ],
                    ),
                    SizedBox(
                      height: 6.h,
                    ),
                    (bookingModel.email ?? '').isNotEmpty
                        ? Row(
                            children: [
                              Icon(Icons.email_outlined),
                              SizedBox(
                                width: 10.w,
                              ),
                              Expanded(child: Text(bookingModel.email ?? ''))
                            ],
                          )
                        : SizedBox(),
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
            ListView.builder(
              shrinkWrap: true,
              itemCount: bookingModel.passengersTxtFieldModel?.length ?? 0,
              itemBuilder: (context, index) => Card(
                  child: ExpansionTile(
                title: Text(
                  (bookingModel.passengersTxtFieldModel?[index].isChild ??
                          false)
                      ? 'Child ${index - (bookingModel.totalAdults ?? 1) + 1}'
                      : 'Adult ${index + 1}',
                ),
                expandedAlignment: Alignment.centerLeft,
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(16.sp, 0, 16.sp, 16.sp),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(getFullName(
                            bookingModel.passengersTxtFieldModel?[index].title,
                            bookingModel
                                .passengersTxtFieldModel?[index].firstName,
                            bookingModel
                                .passengersTxtFieldModel?[index].middleName,
                            bookingModel
                                .passengersTxtFieldModel?[index].lastName)),
                        Text(bookingModel
                                .passengersTxtFieldModel?[index].nationality ??
                            ''),
                        Text(getDocumentType(bookingModel
                                .passengersTxtFieldModel?[index].documentType ??
                            '')),
                        if ((bookingModel.passengersTxtFieldModel?[index]
                                    .documentNumber ??
                                'no-document') !=
                            'no-document')
                          Text(bookingModel.passengersTxtFieldModel?[index]
                                  .documentNumber ??
                              '')
                      ],
                    ),
                  )
                ],
              )),
            ),
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
            ),
            SizedBox(
              height: 15.h,
            ),
            DefaultButton('Book Now!', () async {
              var cancel = BotToast.showLoading();

              Either response =
                  await BookingRepo.bookFlight(model: bookingModel);
              response.fold((value) {
                cancel();
                locator<NavigationService>().popUntil('/');
                showToast('Flight booked successfully',
                    toastType: ToastType.success);
              }, (failure) {
                cancel();
                showToast(failure.message, toastType: ToastType.error);
              });
            })
          ],
        )),
      )),
    );
  }

  String getFullName(
      String? title, String? firstName, String? middleName, String? lastName) {
    String fullName = '';
    if (title != null) {
      fullName += title;
    }
    if (firstName != null) {
      fullName += ' $firstName';
    }
    if (middleName != null) {
      fullName += ' $middleName';
    }
    if (lastName != null) {
      fullName += ' $lastName';
    }
    return fullName.trim();
  }

  String getDocumentType(String? slug) {
    switch (slug) {
      case 'no-document':
        return 'No Document';

      case 'passport':
        return 'Passport';

      case 'citizenship':
        return 'Citizenship';

      case 'id-card':
        return 'ID Card';

      default:
        return 'No Document';
    }
  }
}
