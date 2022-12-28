part of 'search_bloc.dart';

class SearchState extends Equatable {
  SearchModel? searchModel;
  SearchStatus status = SearchStatus.initial;
  SearchState({this.searchModel, this.status = SearchStatus.initial});

  @override
  List<Object?> get props => [searchModel];
}

enum SearchStatus { initial, loading, success, failure }
