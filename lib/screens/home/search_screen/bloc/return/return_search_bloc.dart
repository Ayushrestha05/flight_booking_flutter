import 'package:equatable/equatable.dart';
import 'package:flight_booking/screens/home/search_screen/model/search_model.dart';
import 'package:flight_booking/screens/home/search_screen/repo/search_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'return_search_event.dart';
part 'return_search_state.dart';

class ReturnSearchBloc extends Bloc<ReturnSearchEvent, ReturnSearchState> {
  ReturnSearchBloc() : super(ReturnSearchState()) {
    on<InitialSearchEvent>((event, emit) async {
      emit(ReturnSearchState(status: ReturnSearchStatus.loading));
      var response = await SearchRepository.getExploreData(
        from: event.from,
        to: event.to,
        date: event.departureDate,
        seats: event.numberOfAdults + event.numberOfChildren,
      );

      response.fold((value) {
        emit(ReturnSearchState(searchModel: value, status: ReturnSearchStatus.success));
      }, (failure) {
        emit(ReturnSearchState(status: ReturnSearchStatus.failure));
      });
    });
  }
}
