import 'package:march_health_task/data/user.dart';

abstract class DataSource<T> {
  Future<List<T>> getAll(User? user);
  Future<T> createOrUpdate(T data);
  Future<T> findById(dynamic id);
}
