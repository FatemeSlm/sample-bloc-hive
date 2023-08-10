import 'package:hive_flutter/adapters.dart';

part 'user.g.dart';

@HiveType(typeId: 0)
class User extends HiveObject {
  @HiveField(0)
  int id;
  @HiveField(1)
  String name;
  @HiveField(2)
  bool admin;
  @HiveField(3)
  bool checked;
  @HiveField(4)
  List<Badge> badges;

  User(
      {required this.id,
      required this.name,
      required this.admin,
      required this.checked,
      required this.badges});
}

@HiveType(typeId: 1)
class Badge {
  @HiveField(0)
  int id;
  @HiveField(1)
  String name;

  Badge({required this.id, required this.name});
}

class Score {
  final User colleague;
  final Badge badge;

  Score(this.colleague, this.badge);
}

class Result {
  final User user;
  final String badgeResult;

  Result(this.user, this.badgeResult);
}
