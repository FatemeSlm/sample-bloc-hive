import 'package:flutter/material.dart';
import 'package:march_health_task/common/hive_database.dart';
import 'package:march_health_task/data/repo/repository.dart';
import 'package:march_health_task/data/source/hive_user_source.dart';
import 'package:march_health_task/data/user.dart';
import 'package:march_health_task/ui/login/login.dart';
import 'package:provider/provider.dart';

void main() async {
  await initHive();
  runApp(Provider<Repository<User>>(
    create: (context) => Repository<User>(HiveUserDataSource(box)),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const LoginScreen(),
    );
  }
}
