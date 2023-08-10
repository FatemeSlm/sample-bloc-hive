part of 'home_admin_bloc.dart';

abstract class HomeAdminEvent extends Equatable {
  const HomeAdminEvent();

  @override
  List<Object> get props => [];
}

class HomeAdminStarted extends HomeAdminEvent{}
