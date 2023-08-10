part of 'home_user_bloc.dart';

abstract class HomeUserEvent extends Equatable {
  final User user;
  const HomeUserEvent(this.user);

  @override
  List<Object> get props => [user];
}

class HomeUserStarted extends HomeUserEvent {
  const HomeUserStarted(User user) : super(user);
}

class HomeUserClickedSubmit extends HomeUserEvent {
  final List<Score> scoreList;

  const HomeUserClickedSubmit(User user, this.scoreList) : super(user);
}
