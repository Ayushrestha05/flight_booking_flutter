// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'auth_bloc.dart';

@immutable
class AuthState extends Equatable {
  final ProfileModel? profileModel;
  final Failure? failure;

  AuthState({this.profileModel, this.failure});

  AuthState copyWith({
    ProfileModel? profileModel,
    Failure? failure,
  }) {
    return AuthState(
      profileModel: profileModel ?? this.profileModel,
      failure: failure ?? this.failure,
    );
  }

  @override
  List<Object?> get props => [profileModel, failure];
}
