import 'package:march_health_task/data/source/source.dart';
import 'package:march_health_task/data/user.dart';

class Repository<T> implements DataSource<T> {
  final DataSource<T> localDataSource;

  Repository(this.localDataSource);

  @override
  Future<T> createOrUpdate(T data) async {
    final result = await localDataSource.createOrUpdate(data);

    return result;
  }

  @override
  Future<List<T>> getAll(User? user) async {
    return await localDataSource.getAll(user);
  }

  @override
  Future<T> findById(id) async {
    return await localDataSource.findById(id);
  }
}
