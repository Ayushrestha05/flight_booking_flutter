import 'package:flight_booking/screens/home/my_tickets/model/my_ticket_model.dart';
import 'package:flight_booking/widgets/screen_padding.dart';
import 'package:flight_booking/widgets/ticketCard_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BookingDetailsScreen extends StatelessWidget {
  final MyTicketModel model;
  const BookingDetailsScreen({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Booking Details'),
      ),
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
                'Flight Information',
                style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10.h,
              ),
              Text(
                'Going Flight',
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
              ),
              buildTicketCard(context,
                  flightModel: model.arrival_flight?.flight),
              if (model.departure_flight != null)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 10.h,
                    ),
                    Text(
                      'Returning Flight',
                      style: TextStyle(
                          fontSize: 16.sp, fontWeight: FontWeight.bold),
                    ),
                    buildTicketCard(context,
                        flightModel: model.departure_flight?.flight),
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
                  padding:
                      EdgeInsets.symmetric(horizontal: 14.h, vertical: 12.h),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Icon(Icons.account_circle_outlined),
                          SizedBox(
                            width: 10.w,
                          ),
                          Expanded(child: Text(model.name ?? ''))
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
                          Expanded(child: Text(model.phone ?? ''))
                        ],
                      ),
                      SizedBox(
                        height: 6.h,
                      ),
                      (model.email ?? '').isNotEmpty
                          ? Row(
                              children: [
                                Icon(Icons.email_outlined),
                                SizedBox(
                                  width: 10.w,
                                ),
                                Expanded(child: Text(model.email ?? ''))
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
                itemCount: model.passengers?.length ?? 0,
                itemBuilder: (context, index) => Card(
                    child: ExpansionTile(
                  title: Text(
                    'Passenger ${index + 1}',
                  ),
                  expandedAlignment: Alignment.centerLeft,
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(16.sp, 0, 16.sp, 16.sp),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                  child: Text(
                                      model.passengers?[index].name ?? '')),
                              Text(model.passengers?[index].is_child ?? false
                                  ? 'Child'
                                  : 'Adult')
                            ],
                          ),
                          Text(model.passengers?[index].nationality ?? ''),
                          Text(getDocumentType(
                              model.passengers?[index].document_type ?? '')),
                          if ((model.passengers?[index].document_number ??
                                  'no-document') !=
                              'no-document')
                            Text(model.passengers?[index].document_number ?? '')
                        ],
                      ),
                    )
                  ],
                )),
              ),
              SizedBox(
                height: 10.h,
              ),
            ],
          ),
        ),
      )),
    );
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
