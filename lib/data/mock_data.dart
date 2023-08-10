import 'package:march_health_task/data/user.dart';

List<User> getUsers() {
  List<User> items = [];

  for (int i = 1; i <= 5; i++) {
    final user =
        User(id: i, name: 'user$i', checked: false, admin: false, badges: []);

    items.add(user);
  }

  final user =
      User(id: 6, name: 'admin', checked: false, admin: true, badges: []);
  items.add(user);

  return items;
}

List<Badge> getBadges() {
  List<Badge> items = [];

  items.add(Badge(id: 1, name: 'Batman/girl'));
  items.add(Badge(id: 2, name: 'Spiderman/girl'));
  items.add(Badge(id: 3, name: 'Sherlock'));
  items.add(Badge(id: 4, name: 'Joker'));
  items.add(Badge(id: 5, name: 'Ironman/girl'));

  return items;
}
