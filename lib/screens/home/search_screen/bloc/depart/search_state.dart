part of 'search_bloc.dart';

class SearchState extends Equatable {
  SearchModel? searchModel;
  SearchStatus status = SearchStatus.initial;
  String? queryString;
  SearchState(
      {this.searchModel, this.status = SearchStatus.initial, this.queryString});

  @override
  List<Object?> get props => [searchModel, queryString, status];
}

enum SearchStatus { initial, loading, success, failure }
