import 'package:flight_booking/core/constants/image_sources.dart';
import 'package:flight_booking/core/routes/export_routes.dart';
import 'package:flight_booking/core/services/service_locator.dart';
import 'package:flight_booking/screens/home/my_tickets/bloc/my_ticket_bloc.dart';
import 'package:flight_booking/screens/home/profile_screen/profile_screen.dart';
import 'package:flight_booking/screens/home/search_screen/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BaseScreen extends StatelessWidget {
  final PageController _controller = PageController();
  final ValueNotifier<int> _currentPage = ValueNotifier(0);
  BaseScreen({super.key});

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
              selectedItemColor: Colors.black,
              onTap: ((value) {
                _currentPage.value = value;
                _controller.animateToPage(value,
                    duration: const Duration(milliseconds: 400),
                    curve: Curves.easeIn);
              }),
              type: BottomNavigationBarType.fixed,
              items: [
                ImageSource.homeIcon,
                ImageSource.searchIcon,
                ImageSource.ticketIcon,
                ImageSource.profileIcon,
              ]
                  .map((e) => BottomNavigationBarItem(
                        icon: SvgPicture.asset(e),
                        activeIcon: SvgPicture.asset(
                          e,
                          //TODO Change Color to Theme Color Later on
                          color: Color(0xFF03314B),
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
