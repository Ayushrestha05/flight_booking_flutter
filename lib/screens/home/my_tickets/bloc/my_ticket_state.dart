// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'my_ticket_bloc.dart';

class MyTicketState extends Equatable {
  List<MyTicketModel?>? myTickets;
  NetworkState? networkState = NetworkState.initial;

  MyTicketState({
    this.myTickets,
    this.networkState,
  });

  @override
  List<Object?> get props => [myTickets, networkState];

  MyTicketState copyWith({
    List<MyTicketModel?>? myTickets,
    NetworkState? networkState,
  }) {
    return MyTicketState(
      myTickets: myTickets ?? this.myTickets,
      networkState: networkState ?? this.networkState,
    );
  }
}
