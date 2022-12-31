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
      var response = await SearchRepository.getSearchData(
        from: event.from,
        to: event.to,
        date: event.departureDate,
        seats: event.numberOfAdults + event.numberOfChildren,
        queryString: event.queryString,
      );

      response.fold((value) {
        emit(ReturnSearchState(searchModel: value, status: ReturnSearchStatus.success));
      }, (failure) {
        emit(ReturnSearchState(status: ReturnSearchStatus.failure));
      });
    });

    on<FetchMoreSearchEvent>((event, emit) async {
      var response = await SearchRepository.getSearchData(
        from: event.from,
        to: event.to,
        date: event.departureDate,
        seats: event.numberOfAdults + event.numberOfChildren,
        page: event.page,
        queryString: event.queryString,
      );

      response.fold((value) {
        SearchModel newModel = SearchModel(
          flights: state.searchModel!.flights! + value.flights!,
          pagination: value.pagination,
        );

        emit(ReturnSearchState(
            searchModel: newModel,
            status: ReturnSearchStatus.success,
            queryString: event.queryString));
      }, (failure) {
        emit(ReturnSearchState(
            searchModel: state.searchModel, queryString: event.queryString));
      });
    });
  }
}
