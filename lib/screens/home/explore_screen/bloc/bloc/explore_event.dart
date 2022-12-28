part of 'explore_bloc.dart';

abstract class ExploreEvent {
  const ExploreEvent();
}

class FetchExploreEvent extends ExploreEvent {
  const FetchExploreEvent();
}
