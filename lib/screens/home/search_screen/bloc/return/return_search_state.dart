part of 'return_search_bloc.dart';


class ReturnSearchState extends Equatable {
  SearchModel? searchModel;
  ReturnSearchStatus status = ReturnSearchStatus.initial;
  ReturnSearchState({this.searchModel, this.status = ReturnSearchStatus.initial});

  @override
  List<Object?> get props => [searchModel];
}

enum ReturnSearchStatus { initial, loading, success, failure }
