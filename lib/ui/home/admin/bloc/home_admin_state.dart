part of 'home_admin_bloc.dart';

abstract class HomeAdminState extends Equatable {
  const HomeAdminState();
  
  @override
  List<Object> get props => [];
}

class HomeAdminLoading extends HomeAdminState {}

class HomeAdminSuccess extends HomeAdminState {
  final List<Result> items;

  const HomeAdminSuccess(this.items);

  @override
  List<Object> get props => [items];
}

class HomeAdminError extends HomeAdminState {
  final String errorMessage;

  const HomeAdminError(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}
