import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flight_booking/screens/home/search_screen/model/search_model.dart';
import 'package:flight_booking/screens/home/search_screen/repo/search_repo.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(SearchState()) {
    on<InitialSearchEvent>((event, emit) async {
      emit(SearchState(status: SearchStatus.loading));
      var response = await SearchRepository.getSearchData(
        from: event.from,
        to: event.to,
        date: event.departureDate,
        seats: event.numberOfAdults + event.numberOfChildren,
        queryString: event.queryString,
      );

      response.fold((value) {
        emit(SearchState(searchModel: value, status: SearchStatus.success));
      }, (failure) {
        emit(SearchState(status: SearchStatus.failure));
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

        emit(SearchState(
            searchModel: newModel,
            status: SearchStatus.success,
            queryString: event.queryString));
      }, (failure) {
        emit(SearchState(
            searchModel: state.searchModel, queryString: event.queryString));
      });
    });
  }
}
