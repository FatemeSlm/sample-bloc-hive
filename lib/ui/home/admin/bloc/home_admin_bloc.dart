import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:march_health_task/data/mock_data.dart';
import 'package:march_health_task/data/repo/repository.dart';
import 'package:march_health_task/data/user.dart';

part 'home_admin_event.dart';
part 'home_admin_state.dart';

class HomeAdminBloc extends Bloc<HomeAdminEvent, HomeAdminState> {
  final Repository<User> repository;

  HomeAdminBloc(this.repository) : super(HomeAdminLoading()) {
    on<HomeAdminEvent>((event, emit) async {
      if (event is HomeAdminStarted) {
        try {
          emit(HomeAdminLoading());
          List<User> allItems = await repository.getAll(null);
          emit(HomeAdminSuccess(calculateBadgeResult(allItems)));
        } catch (e) {
          emit(HomeAdminError(e.toString()));
        }
      }
    });
  }

  List<Result> calculateBadgeResult(List<User> allItems) {
    List<Result> resultList = [];
    final users = allItems.where((element) => !element.admin);
    for (var user in users) {
      String badgeResult = '';

      for (var badge in getBadges()) {
        int count =
            user.badges.where((element) => element.id == badge.id).length;
        badgeResult += '${badge.name}: $count     ';
      }

      resultList.add(Result(user, badgeResult));
    }
    return resultList;
  }
}
