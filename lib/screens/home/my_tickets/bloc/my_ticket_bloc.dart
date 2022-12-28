import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flight_booking/core/constants/network_state.dart';
import 'package:flight_booking/core/utils/show_toast.dart';
import 'package:flight_booking/screens/book/repository/booking_repo.dart';
import 'package:flight_booking/screens/home/my_tickets/model/my_ticket_model.dart';

part 'my_ticket_event.dart';
part 'my_ticket_state.dart';

class MyTicketBloc extends Bloc<MyTicketEvent, MyTicketState> {
  MyTicketBloc() : super(MyTicketState()) {
    on<FetchMyTicketEvent>((event, emit) async {
      emit(state.copyWith(networkState: NetworkState.loading));
      await BookingRepo.getBookings().then((value) {
        value.fold((l) {
          emit(state.copyWith(myTickets: l, networkState: NetworkState.loaded));
        }, (r) {
          if (state.networkState == NetworkState.loaded) {
            showToast(r.message, toastType: ToastType.error);
          } else {
            emit(state.copyWith(networkState: NetworkState.error));
          }
        });
      });
    });
  }
}
