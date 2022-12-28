// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flight_booking/core/utils/date_convert_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

import 'package:flight_booking/core/constants/image_sources.dart';
import 'package:flight_booking/core/model/flight_model.dart';
import 'package:flight_booking/screens/home/my_tickets/widgets/flight_sort_bottom_sheet.dart';
import 'package:flight_booking/screens/home/search_screen/model/flight_search_view_model.dart';
import 'package:flight_booking/widgets/booking_bottom_sheet.dart';
import 'package:flight_booking/widgets/departDestination_widget.dart';
import 'package:flight_booking/widgets/pagination_widget.dart';
import 'package:flight_booking/widgets/ticketCard_widget.dart';

import '../../../core/services/service_locator.dart';
import 'bloc/return/return_search_bloc.dart';

class ReturnFlightListScreen extends StatefulWidget {
  final FlightSearchViewModel flightSearchViewModel;
  const ReturnFlightListScreen({
    Key? key,
    required this.flightSearchViewModel,
  }) : super(key: key);

  @override
  State<ReturnFlightListScreen> createState() => _ReturnFlightListScreenState();
}

class _ReturnFlightListScreenState extends State<ReturnFlightListScreen> {
  @override
  void initState() {
    locator<ReturnSearchBloc>().add(
      InitialSearchEvent(
          from: widget.flightSearchViewModel.to,
          to: widget.flightSearchViewModel.from,
          departureDate: DateFormat('yyyy-MM-dd').format(
              widget.flightSearchViewModel.returnDate ?? DateTime.now()),
          numberOfAdults: widget.flightSearchViewModel.numberOfAdults,
          numberOfChildren: widget.flightSearchViewModel.numberOfChildren ?? 0),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return <Widget>[
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
                              departCode: widget.flightSearchViewModel.to,
                              destinationCode:
                                  widget.flightSearchViewModel.from,
                              color: Colors.white),
                          Text(
                            'One Way',
                            style:
                                TextStyle(fontSize: 14.sp, color: Colors.white),
                          ),
                          Text(
                            widget.flightSearchViewModel.returnDate!
                                .convertToDateTimeString(),
                            style:
                                TextStyle(fontSize: 20.sp, color: Colors.white),
                          ),
                          Text(
                              '${widget.flightSearchViewModel.numberOfAdults} Adult ${((widget.flightSearchViewModel.numberOfChildren ?? 0) > 0) ? ', ${widget.flightSearchViewModel.numberOfChildren} Children' : ''}',
                              style: TextStyle(
                                  fontSize: 14.sp, color: Colors.white)),
                        ],
                      ),
                    ),
                  )),
            ];
          },
          body: BlocBuilder<ReturnSearchBloc, ReturnSearchState>(
            builder: (context, state) {
              if (state.status == ReturnSearchStatus.loading) {
                return Center(child: CircularProgressIndicator());
              } else if (state.status == ReturnSearchStatus.success) {
                if (state.searchModel!.flights?.length == 0) {
                  return Center(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        ImageSource.noFlightSVG,
                        height: 100.h,
                        width: 100.w,
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Text(
                        'No flights found!',
                        style: TextStyle(fontSize: 14.sp),
                      ),
                    ],
                  ));
                } else {
                  return SmartListViewWithPagination(
                      onLoading: () {
                        locator<ReturnSearchBloc>().add(FetchMoreSearchEvent(
                            from: widget.flightSearchViewModel.from,
                            to: widget.flightSearchViewModel.to,
                            departureDate: DateFormat('yyyy-MM-dd').format(
                                widget.flightSearchViewModel.departureDate),
                            numberOfAdults:
                                widget.flightSearchViewModel.numberOfAdults,
                            numberOfChildren:
                                widget.flightSearchViewModel.numberOfChildren ??
                                    0,
                            page: (state.searchModel?.pagination?.currentPage ??
                                    1) +
                                1));
                      },
                      onRefresh: () {},
                      child: ListView.builder(
                        itemCount: state.searchModel?.flights?.length ?? 0,
                        itemBuilder: (context, index) {
                          FlightModel? model =
                              state.searchModel?.flights?[index];
                          return buildTicketCard(context, flightModel: model,
                              onTap: () {
                            showFlightBookingBottomSheet(context,
                                model: model!,
                                totalAdults:
                                    widget.flightSearchViewModel.numberOfAdults,
                                totalChildren: widget.flightSearchViewModel
                                        .numberOfChildren ??
                                    0,
                                isReturn:
                                    widget.flightSearchViewModel.isRoundTrip,
                                isReturnNavigate: true,
                                viewModel: widget.flightSearchViewModel);
                          });
                        },
                      ));
                }
              } else if (state.status == ReturnSearchStatus.failure) {
                return Center(
                  child: Text('Something went wrong!'),
                );
              }
              return Container();
            },
          ),
        ),
      ),
    );
  }
}
