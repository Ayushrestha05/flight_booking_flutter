import 'package:cached_network_image/cached_network_image.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flight_booking/core/constants/image_sources.dart';
import 'package:flight_booking/core/model/flight_model.dart';
import 'package:flight_booking/core/model/top_route_model.dart';
import 'package:flight_booking/core/services/cubit/navigation_cubit.dart';
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
import 'package:image_picker/image_picker.dart';

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
            "Most Flight Routes",
            style: TextStyle(
                fontFamily: "SFPro",
                fontWeight: FontWeight.bold,
                fontSize: 20.sp),
          ),
          SizedBox(
            height: 15.h,
          ),
          Container(
            height: 90.h,
            child: Swiper(
              itemCount: state.exploreModel?.topRoutes?.length ?? 0,
              loop: false,
              itemBuilder: (context, index) {
                TopRouteModel? model = state.exploreModel?.topRoutes?[index];
                return topRouteCard(context, model);
              },
              viewportFraction: 1,
              scale: 1,
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

  Card topRouteCard(BuildContext context, TopRouteModel? model) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          // Container(
          //   height: 100.h,
          //   child: Row(
          //     children: [
          //       Expanded(
          //         child: Image.asset(
          //           "assets/locations/${model?.from_location ?? 'KTM'}.jpg",
          //           fit: BoxFit.cover,
          //         ),
          //       ),
          //       Expanded(
          //         child: CachedNetworkImage(
          //           fit: BoxFit.cover,
          //           imageUrl:
          //               "assets/locations/${model?.to_location ?? 'PKR'}.jpg",
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
          SizedBox(
            height: 10.h,
          ),
          departureDestinationWidget(
              context: context,
              departCode: "${model?.from_location ?? 'KTM'}",
              destinationCode: "${model?.to_location ?? 'PKR'}"),
          SizedBox(
            height: 5.h,
          ),
          Divider(),
          // SizedBox(
          //   height: 5.h,
          // ),
          Text(
            'Total Flights: ${model?.total ?? 0}',
            style: TextStyle(fontFamily: 'SFPro', fontSize: 16.sp),
          )
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
          DefaultButton("Search for Flights now!", () {
            locator<NavigationCubit>().state.jumpToPage(1);
          }),
        ],
      ),
    );
  }
}
