import 'package:flight_booking/core/constants/airport_names.dart';
import 'package:flight_booking/core/constants/image_sources.dart';
import 'package:flight_booking/core/constants/network_state.dart';
import 'package:flight_booking/core/routes/route_names.dart';
import 'package:flight_booking/core/services/navigation_service.dart';
import 'package:flight_booking/core/services/service_locator.dart';
import 'package:flight_booking/screens/home/my_tickets/bloc/my_ticket_bloc.dart';
import 'package:flight_booking/screens/home/my_tickets/widgets/flight_details_bottom_sheet.dart';
import 'package:flight_booking/widgets/screen_padding.dart';
import 'package:flight_booking/widgets/ticketCard_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../widgets/departDestination_widget.dart';

class MyTicketsScreen extends StatefulWidget {
  const MyTicketsScreen({super.key});

  @override
  State<MyTicketsScreen> createState() => _MyTicketsScreenState();
}

class _MyTicketsScreenState extends State<MyTicketsScreen> {
  @override
  void initState() {
    locator<MyTicketBloc>().add(const FetchMyTicketEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenPadding(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 10.h,
          ),
          Text('My Bookings', style: TextStyle(fontSize: 20.sp)),
          SizedBox(
            height: 10.h,
          ),
          Expanded(
            child: BlocBuilder<MyTicketBloc, MyTicketState>(
              builder: (context, state) {
                if (state.networkState == NetworkState.loading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state.networkState == NetworkState.error) {
                  return const Center(child: Text('Something went wrong!'));
                } else {
                  if ((state.myTickets?.length ?? 0) == 0) {
                    return Center(
                        child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.warning,
                          color: Colors.red,
                          size: 50.sp,
                        ),
                        Text('No Bookings found!'),
                      ],
                    ));
                  } else {
                    return ListView.separated(
                      separatorBuilder: (context, index) => SizedBox(
                        height: 10.h,
                      ),
                      itemCount: state.myTickets?.length ?? 0,
                      itemBuilder: (context, index) {
                        return buildBookingCardWidget(context, onTap: () {
                          locator<NavigationService>().navigateTo(
                              Routes.bookingDetailsScreen,
                              arguments: state.myTickets?[index]);
                        }, model: state.myTickets?[index]);
                      },
                    );
                  }
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
