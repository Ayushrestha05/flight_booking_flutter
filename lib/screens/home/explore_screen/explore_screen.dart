import 'package:cached_network_image/cached_network_image.dart';
import 'package:flight_booking/core/model/flight_model.dart';
import 'package:flight_booking/core/services/service_locator.dart';
import 'package:flight_booking/screens/auth/bloc/auth_bloc.dart';
import 'package:flight_booking/screens/home/explore_screen/bloc/bloc/explore_bloc.dart';
import 'package:flight_booking/screens/home/my_tickets/widgets/flight_details_bottom_sheet.dart';
import 'package:flight_booking/widgets/buttons.dart';
import 'package:flight_booking/widgets/departDestination_widget.dart';
import 'package:flight_booking/widgets/ticketCard_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          introWidget(),
          SizedBox(
            height: 15.h,
          ),
          BlocBuilder<ExploreBloc, ExploreState>(builder: (context, state) {
            return exploreContent(context, state);
          })
        ],
      ),
    );
  }

  Widget exploreContent(BuildContext context, ExploreState state) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Popular Routes",
            style: TextStyle(
                fontFamily: "SFPro",
                fontWeight: FontWeight.bold,
                fontSize: 20.sp),
          ),
          SizedBox(
            height: 15.h,
          ),
          Card(
            clipBehavior: Clip.antiAlias,
            child: Column(
              children: [
                Container(
                  height: 100.h,
                  child: Row(
                    children: [
                      Expanded(
                        child: CachedNetworkImage(
                            fit: BoxFit.cover,
                            imageUrl:
                                "https://images.unsplash.com/photo-1507743617593-0a422c9bb7f5?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=774&q=80"),
                      ),
                      Expanded(
                        child: CachedNetworkImage(
                            fit: BoxFit.cover,
                            imageUrl:
                                "https://images.unsplash.com/photo-1576948187290-457c015b3bff?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80"),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                departureDestinationWidget(
                    context: context,
                    departCode: "KTM",
                    destinationCode: "PKR"),
                SizedBox(
                  height: 10.h,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 15.h,
          ),
          Text(
            "Newly Added Flights",
            style: TextStyle(
                fontFamily: "SFPro",
                fontWeight: FontWeight.bold,
                fontSize: 20.sp),
          ),
          SizedBox(
            height: 15.h,
          ),
          ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: state.exploreModel?.newFlights?.length ?? 0,
              itemBuilder: (context, index) {
                FlightModel? model = state.exploreModel?.newFlights?[index];
                return buildTicketCard(context, flightModel: model, onTap: () {
                  showFlightDetailBottomSheet(context, model: model!);
                });
              })
        ],
      ),
    );
  }

  Container introWidget() {
    return Container(
      width: double.maxFinite,
      // height: 175.h,
      padding: EdgeInsets.all(15.sp),
      color: const Color(0xFF03314B),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Hey,",
            style: TextStyle(
                fontFamily: "SFPro", fontSize: 20.sp, color: Colors.white),
          ),
          Text(locator<AuthBloc>().state.profileModel!.name ?? 'User',
              style: TextStyle(
                  fontFamily: "SFPro",
                  fontWeight: FontWeight.bold,
                  fontSize: 24.sp,
                  color: Colors.white)),
          SizedBox(
            height: 20.h,
          ),
          Text(
            "Want to book a Flight?",
            style: TextStyle(
                fontFamily: "SFPro", fontSize: 20.sp, color: Colors.white),
          ),
          SizedBox(
            height: 10.h,
          ),
          DefaultButton("Search for Flights now!", () {}),
        ],
      ),
    );
  }
}
