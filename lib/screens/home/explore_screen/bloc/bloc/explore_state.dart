// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'explore_bloc.dart';

class ExploreState extends Equatable {
  ExploreModel? exploreModel;
  NetworkState networkState;

  ExploreState({
    this.exploreModel,
    this.networkState = NetworkState.initial,
  });
  
  @override
  List<Object?> get props => [exploreModel, networkState];

  ExploreState copyWith({
    ExploreModel? exploreModel,
    NetworkState? networkState,
  }) {
    return ExploreState(
      exploreModel: exploreModel ?? this.exploreModel,
      networkState: networkState ?? this.networkState,
    );
  }
}

