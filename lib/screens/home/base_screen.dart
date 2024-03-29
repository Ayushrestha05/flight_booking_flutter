import 'package:flight_booking/core/constants/image_sources.dart';
import 'package:flight_booking/core/routes/export_routes.dart';
import 'package:flight_booking/core/services/cubit/navigation_cubit.dart';
import 'package:flight_booking/core/services/service_locator.dart';
import 'package:flight_booking/screens/home/my_tickets/bloc/my_ticket_bloc.dart';
import 'package:flight_booking/screens/home/profile_screen/profile_screen.dart';
import 'package:flight_booking/screens/home/search_screen/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BaseScreen extends StatefulWidget {
  BaseScreen({super.key});

  @override
  State<BaseScreen> createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  final PageController _controller = locator<NavigationCubit>().state;

  final ValueNotifier<int> _currentPage = ValueNotifier(0);

  @override
  void initState() {
    if (locator<NavigationCubit>().state.hasClients) {
      _currentPage.value = locator<NavigationCubit>().state.page!.toInt();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: PageView(
        controller: _controller,
        onPageChanged: ((value) => _currentPage.value = value),
        children: [
          ExploreScreen(),
          SearchScreen(),
          BlocProvider.value(
            value: locator<MyTicketBloc>(),
            child: MyTicketsScreen(),
          ),
          ProfileScreen(),
        ],
      )),
      bottomNavigationBar: ValueListenableBuilder<int>(
          valueListenable: _currentPage,
          builder: (context, page, _) {
            return BottomNavigationBar(
              currentIndex: page,
              selectedItemColor:
                  Theme.of(context).brightness == Brightness.light
                      ? Colors.white
                      : Colors.black,
              onTap: ((value) {
                _currentPage.value = value;
                _controller.animateToPage(value,
                    duration: const Duration(milliseconds: 400),
                    curve: Curves.easeIn);
              }),
              type: BottomNavigationBarType.fixed,
              items: [
                AssetImageSource.homeIcon,
                AssetImageSource.searchIcon,
                AssetImageSource.ticketIcon,
                AssetImageSource.profileIcon,
              ]
                  .map((e) => BottomNavigationBarItem(
                        icon: SvgPicture.asset(e),
                        activeIcon: SvgPicture.asset(
                          e,
                          color:
                              Theme.of(context).brightness == Brightness.light
                                  ? Color(0xFF03314B)
                                  : Colors.blue,
                        ),
                        label: "",
                      ))
                  .toList(),
              showSelectedLabels: false,
              showUnselectedLabels: false,
            );
          }),
    );
  }
}
