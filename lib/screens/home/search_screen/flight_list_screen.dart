import 'dart:developer';
import 'package:flight_booking/screens/home/my_tickets/widgets/flight_sort_bottom_sheet.dart';
import 'package:flight_booking/widgets/departDestination_widget.dart';
import 'package:flight_booking/widgets/ticketCard_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../my_tickets/widgets/flight_details_bottom_sheet.dart';

class FlightListScreen extends StatelessWidget {
  const FlightListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // SliverAppBar(
            //   title: Text("KTM _ POK"),
            //   actions: [IconButton(onPressed: () {}, icon: Icon(Icons.sort))],

            //   // forceElevated: true,
            // ),
            SliverAppBar(
                actions: [
                  IconButton(
                      onPressed: () {
                        showFlightSortBottomSheet(context);
                      },
                      icon: Icon(Icons.sort))
                ],
                backgroundColor: const Color(0xFF03314B),
                floating: true,
                snap: true,
                expandedHeight: 180.0,
                flexibleSpace: FlexibleSpaceBar(
                  background: Container(
                    margin: EdgeInsets.only(top: kToolbarHeight + 8.h),
                    child: Column(
                      children: <Widget>[
                        departureDestinationWidget(
                            context: context,
                            departCode: "KTM",
                            destinationCode: "ILM",
                            color: Colors.white),
                        Text(
                          'One Way',
                          style:
                              TextStyle(fontSize: 14.sp, color: Colors.white),
                        ),
                        Text(
                          "Nov 8, 2022",
                          style:
                              TextStyle(fontSize: 20.sp, color: Colors.white),
                        )
                      ],
                    ),
                  ),
                )),
            SliverList(
                delegate: SliverChildBuilderDelegate(
                    (context, index) => buildTicketCard(context, onTap: () {
                          showFlightDetailBottomSheet(context);
                        }),
                    childCount: 6))
          ],
        ),
      ),
    );
  }
}
