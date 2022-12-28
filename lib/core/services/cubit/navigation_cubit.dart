import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

class NavigationCubit extends Cubit<PageController> {
  NavigationCubit() : super(PageController());
}
