import 'package:hive_flutter/hive_flutter.dart';
import 'package:march_health_task/data/user.dart';

const boxName = 'users';
final box = Hive.box<User>(boxName);

initHive() async {
  await Hive.initFlutter();
  Hive.registerAdapter(UserAdapter());
  Hive.registerAdapter(BadgeAdapter());
  await Hive.openBox<User>(boxName);
}
