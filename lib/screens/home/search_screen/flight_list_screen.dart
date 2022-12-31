import 'package:flight_booking/core/constants/image_sources.dart';
import 'package:flight_booking/core/model/book_model.dart';
import 'package:flight_booking/core/model/flight_model.dart';
import 'package:flight_booking/core/routes/route_names.dart';
import 'package:flight_booking/core/services/navigation_service.dart';
import 'package:flight_booking/core/services/service_locator.dart';
import 'package:flight_booking/screens/home/my_tickets/widgets/flight_sort_bottom_sheet.dart';
import 'package:flight_booking/screens/home/search_screen/bloc/depart/search_bloc.dart';
import 'package:flight_booking/screens/home/search_screen/model/flight_search_view_model.dart';
import 'package:flight_booking/widgets/booking_bottom_sheet.dart';
import 'package:flight_booking/widgets/departDestination_widget.dart';
import 'package:flight_booking/widgets/pagination_widget.dart';
import 'package:flight_booking/widgets/ticketCard_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flight_booking/core/utils/date_convert_extension.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

import '../my_tickets/widgets/flight_details_bottom_sheet.dart';

class FlightListScreen extends StatefulWidget {
  FlightSearchViewModel flightSearchViewModel;
  FlightListScreen({super.key, required this.flightSearchViewModel});

  @override
  State<FlightListScreen> createState() => _FlightListScreenState();
}

class _FlightListScreenState extends State<FlightListScreen> {
  @override
  void initState() {
    locator<SearchBloc>().add(
      InitialSearchEvent(
          from: widget.flightSearchViewModel.from,
          to: widget.flightSearchViewModel.to,
          departureDate: DateFormat('yyyy-MM-dd')
              .format(widget.flightSearchViewModel.departureDate),
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
                          locator<SearchBloc>();
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
                              departCode: widget.flightSearchViewModel.from,
                              destinationCode: widget.flightSearchViewModel.to,
                              color: Colors.white),
                          Text(
                            widget.flightSearchViewModel.isRoundTrip == true
                                ? 'Round Trip'
                                : 'One Way',
                            style:
                                TextStyle(fontSize: 14.sp, color: Colors.white),
                          ),
                          Text(
                            widget.flightSearchViewModel.departureDate
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
          body: BlocBuilder<SearchBloc, SearchState>(
            builder: (context, state) {
              if (state.status == SearchStatus.loading) {
                return Center(child: CircularProgressIndicator());
              } else if (state.status == SearchStatus.success) {
                if (state.searchModel!.flights?.length == 0) {
                  return Center(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        AssetImageSource.noFlightSVG,
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
                        locator<SearchBloc>().add(FetchMoreSearchEvent(
                            from: widget.flightSearchViewModel.from,
                            to: widget.flightSearchViewModel.to,
                            departureDate: DateFormat('yyyy-MM-dd').format(
                                widget.flightSearchViewModel.departureDate),
                            numberOfAdults:
                                widget.flightSearchViewModel.numberOfAdults,
                            numberOfChildren:
                                widget.flightSearchViewModel.numberOfChildren ??
                                    0,
                            queryString: state.queryString,
                            page: (state.searchModel?.pagination?.currentPage ??
                                    1) +
                                1));
                      },
                      onRefresh: () {
                        locator<SearchBloc>().add(
                          InitialSearchEvent(
                              from: widget.flightSearchViewModel.from,
                              to: widget.flightSearchViewModel.to,
                              departureDate: DateFormat('yyyy-MM-dd').format(
                                  widget.flightSearchViewModel.departureDate),
                              numberOfAdults:
                                  widget.flightSearchViewModel.numberOfAdults,
                              numberOfChildren: widget
                                      .flightSearchViewModel.numberOfChildren ??
                                  0,
                              queryString: state.queryString),
                        );
                      },
                      child: ListView.builder(
                        itemCount: state.searchModel?.flights?.length ?? 0,
                        itemBuilder: (context, index) {
                          FlightModel? model =
                              state.searchModel?.flights?[index];
                          return buildTicketCard(context, flightModel: model,
                              onTap: () {
                            showFlightBookingBottomSheet(
                              context,
                              model: model!,
                              totalAdults:
                                  widget.flightSearchViewModel.numberOfAdults,
                              totalChildren: widget
                                      .flightSearchViewModel.numberOfChildren ??
                                  0,
                              isReturn:
                                  widget.flightSearchViewModel.isRoundTrip,
                              viewModel: widget.flightSearchViewModel,
                            );
                          });
                        },
                      ));
                }
              } else if (state.status == SearchStatus.failure) {
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
              ListTile(
                onTap: () {
                  locator<SearchBloc>().state.queryString = null;
                  locator<SearchBloc>().add(
                    InitialSearchEvent(
                        from: widget.flightSearchViewModel.from,
                        to: widget.flightSearchViewModel.to,
                        departureDate: DateFormat('yyyy-MM-dd')
                            .format(widget.flightSearchViewModel.departureDate),
                        numberOfAdults:
                            widget.flightSearchViewModel.numberOfAdults,
                        numberOfChildren:
                            widget.flightSearchViewModel.numberOfChildren ?? 0,
                        queryString: null),
                  );
                  Navigator.pop(context);
                },
                title: Text('None'),
              ),
              ListTile(
                onTap: () {
                  locator<SearchBloc>().state.queryString = 'price-ascending';
                  locator<SearchBloc>().add(
                    InitialSearchEvent(
                        from: widget.flightSearchViewModel.from,
                        to: widget.flightSearchViewModel.to,
                        departureDate: DateFormat('yyyy-MM-dd')
                            .format(widget.flightSearchViewModel.departureDate),
                        numberOfAdults:
                            widget.flightSearchViewModel.numberOfAdults,
                        numberOfChildren:
                            widget.flightSearchViewModel.numberOfChildren ?? 0,
                        queryString: 'price-ascending'),
                  );
                  Navigator.pop(context);
                },
                title: Text('Lowest Price'),
              ),
              ListTile(
                onTap: () {
                  locator<SearchBloc>().state.queryString = 'price-descending';
                  locator<SearchBloc>().add(
                    InitialSearchEvent(
                        from: widget.flightSearchViewModel.from,
                        to: widget.flightSearchViewModel.to,
                        departureDate: DateFormat('yyyy-MM-dd')
                            .format(widget.flightSearchViewModel.departureDate),
                        numberOfAdults:
                            widget.flightSearchViewModel.numberOfAdults,
                        numberOfChildren:
                            widget.flightSearchViewModel.numberOfChildren ?? 0,
                        queryString: 'price-descending'),
                  );
                  Navigator.pop(context);
                },
                title: Text('Highest Price'),
              ),
              ListTile(
                onTap: () {
                  locator<SearchBloc>().state.queryString = 'short-duration';
                  locator<SearchBloc>().add(
                    InitialSearchEvent(
                        from: widget.flightSearchViewModel.from,
                        to: widget.flightSearchViewModel.to,
                        departureDate: DateFormat('yyyy-MM-dd')
                            .format(widget.flightSearchViewModel.departureDate),
                        numberOfAdults:
                            widget.flightSearchViewModel.numberOfAdults,
                        numberOfChildren:
                            widget.flightSearchViewModel.numberOfChildren ?? 0,
                        queryString: 'short-duration'),
                  );
                  Navigator.pop(context);
                },
                title: Text('Shortest Duration'),
              ),
              ListTile(
                onTap: () {
                  locator<SearchBloc>().state.queryString = 'ascending';
                  locator<SearchBloc>().add(
                    InitialSearchEvent(
                        from: widget.flightSearchViewModel.from,
                        to: widget.flightSearchViewModel.to,
                        departureDate: DateFormat('yyyy-MM-dd')
                            .format(widget.flightSearchViewModel.departureDate),
                        numberOfAdults:
                            widget.flightSearchViewModel.numberOfAdults,
                        numberOfChildren:
                            widget.flightSearchViewModel.numberOfChildren ?? 0,
                        queryString: 'ascending'),
                  );
                  Navigator.pop(context);
                },
                title: Text('Ascending Order'),
              ),
              ListTile(
                onTap: () {
                  locator<SearchBloc>().state.queryString = 'descending';
                  locator<SearchBloc>().add(
                    InitialSearchEvent(
                        from: widget.flightSearchViewModel.from,
                        to: widget.flightSearchViewModel.to,
                        departureDate: DateFormat('yyyy-MM-dd')
                            .format(widget.flightSearchViewModel.departureDate),
                        numberOfAdults:
                            widget.flightSearchViewModel.numberOfAdults,
                        numberOfChildren:
                            widget.flightSearchViewModel.numberOfChildren ?? 0,
                        queryString: 'descending'),
                  );
                  Navigator.pop(context);
                },
                title: Text('Descending Order'),
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
}
