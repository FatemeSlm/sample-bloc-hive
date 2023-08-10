import 'package:hive_flutter/hive_flutter.dart';
import 'package:march_health_task/data/source/source.dart';
import 'package:march_health_task/data/user.dart';

class HiveUserDataSource implements DataSource<User> {
  final Box<User> box;

  HiveUserDataSource(this.box);

  @override
  Future<User> createOrUpdate(User data) async {
    if (data.isInBox) {
      await data.save();
    } else {
      await box.put(data.id, data);
    }
    return data;
  }

  @override
  Future<List<User>> getAll(User? user) async {
    if (user == null) {
      return box.values.toList();
    } else {
      return box.values.where((element) => element.id != user.id && element.admin == false).toList();
    }
  }

  @override
  Future<User> findById(id) async {
    return box.values.firstWhere((element) => element.id == id);
  }
}
