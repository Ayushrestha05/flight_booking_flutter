import 'package:flight_booking/core/constants/airport_names.dart';
import 'package:flight_booking/core/constants/image_sources.dart';
import 'package:flight_booking/screens/home/my_tickets/widgets/flight_details_bottom_sheet.dart';
import 'package:flight_booking/widgets/ticketCard_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../widgets/departDestination_widget.dart';

class MyTicketsScreen extends StatelessWidget {
  const MyTicketsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.w),
      child: ListView.builder(
        itemCount: 1,
        itemBuilder: (context, index) {
          return buildTicketCard(context, onTap: () {
            showFlightDetailBottomSheet(context);
          });
        },
      ),
    );
  }
}
