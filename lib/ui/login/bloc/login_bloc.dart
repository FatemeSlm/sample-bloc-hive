import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:march_health_task/data/mock_data.dart';
import 'package:march_health_task/data/repo/repository.dart';
import 'package:march_health_task/data/user.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final Repository<User> repository;

  LoginBloc(this.repository) : super(LoginLoading()) {
    on<LoginEvent>((event, emit) async {
      if (event is LoginStarted) {
        try {
          emit(LoginLoading());
          var users = await repository.getAll(null);
          if (users.isEmpty) {
            for (final item in getUsers()) {
              await repository.createOrUpdate(item);
            }
            users = await repository.getAll(null);
          }
          emit(LoginSuccess(users));
        } catch (e) {
          emit(const LoginError('unknown error'));
        }
      }
    });
  }
}
