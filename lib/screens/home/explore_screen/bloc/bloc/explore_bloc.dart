import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flight_booking/core/constants/network_state.dart';
import 'package:flight_booking/core/model/explore_model.dart';
import 'package:flight_booking/core/utils/decode_api.dart';
import 'package:flight_booking/screens/home/explore_screen/repository/explore_repo.dart';

part 'explore_event.dart';
part 'explore_state.dart';

class ExploreBloc extends Bloc<ExploreEvent, ExploreState> {
  ExploreBloc() : super(ExploreState()) {
    on<FetchExploreEvent>((event, emit) async {
      if (state.networkState == NetworkState.initial) {
        emit(state.copyWith(networkState: NetworkState.loading));
        var response = await ExploreRepoistory.getExploreData();
        response.fold((value) {
          emit(state.copyWith(
              networkState: NetworkState.loaded, exploreModel: value));
        }, (failure) {
          emit(state.copyWith(
              networkState: NetworkState.error));
        });
      }
    });
  }
}
