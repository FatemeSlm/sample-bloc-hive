import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:march_health_task/data/repo/repository.dart';
import 'package:march_health_task/data/user.dart';

part 'home_user_event.dart';
part 'home_user_state.dart';

class HomeUserBloc extends Bloc<HomeUserEvent, HomeUserState> {
  final Repository<User> repository;
  HomeUserBloc(this.repository) : super(HomeUserLoading()) {
    on<HomeUserEvent>((event, emit) async {
      try {
        if (event is HomeUserStarted) {
          emit(HomeUserLoading());
          final result = await repository.getAll(event.user);
          emit(HomeUserSuccess(result));
        } else if (event is HomeUserClickedSubmit) {
          for (var score in event.scoreList) {
            score.colleague.badges.add(score.badge);
            await repository.createOrUpdate(score.colleague);
          }
          event.user.checked = true;
          await repository.createOrUpdate(event.user);
          emit(const HomeUserSubmitSuccess('done successfully'));
        }
      } catch (e) {
        emit(HomeUserError(e.toString()));
      }
    });
  }
}
