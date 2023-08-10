part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {
  final List<User> items;

  const LoginSuccess(this.items);

  @override
  List<Object> get props => [items];
}

class LoginError extends LoginState {
  final String errorMessage;

  const LoginError(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}
