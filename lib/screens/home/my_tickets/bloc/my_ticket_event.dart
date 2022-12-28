part of 'my_ticket_bloc.dart';

abstract class MyTicketEvent {
  const MyTicketEvent();

}

class FetchMyTicketEvent extends MyTicketEvent {
  const FetchMyTicketEvent();
}
