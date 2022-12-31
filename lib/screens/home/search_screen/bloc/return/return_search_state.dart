part of 'return_search_bloc.dart';


class ReturnSearchState extends Equatable {
  SearchModel? searchModel;
  ReturnSearchStatus status = ReturnSearchStatus.initial;
    String? queryString;
  ReturnSearchState({this.searchModel, this.status = ReturnSearchStatus.initial, this.queryString});

  @override
  List<Object?> get props => [searchModel, queryString, status];
}

enum ReturnSearchStatus { initial, loading, success, failure }
