part of 'home_user_bloc.dart';

abstract class HomeUserState extends Equatable {
  const HomeUserState();

  @override
  List<Object> get props => [];
}

class HomeUserLoading extends HomeUserState {}

class HomeUserSuccess extends HomeUserState {
  final List<User> items;

  const HomeUserSuccess(this.items);

  @override
  List<Object> get props => [items];
}

class HomeUserError extends HomeUserState {
  final String errorMessage;

  const HomeUserError(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}

class HomeUserSubmitSuccess extends HomeUserState {
  final String msg;

  const HomeUserSubmitSuccess(this.msg);

  @override
  List<Object> get props => [msg];
}
