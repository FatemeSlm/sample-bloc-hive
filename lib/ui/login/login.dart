import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:march_health_task/data/repo/repository.dart';
import 'package:march_health_task/data/user.dart';
import 'package:march_health_task/ui/home/admin/home_admin.dart';
import 'package:march_health_task/ui/home/user/home_user.dart';
import 'package:march_health_task/ui/login/bloc/login_bloc.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('login')),
      body: BlocProvider<LoginBloc>(
        create: (context) =>
            LoginBloc(context.read<Repository<User>>())..add(LoginStarted()),
        child: Center(
          child: BlocBuilder<LoginBloc, LoginState>(
            builder: (context, state) {
              if (state is LoginSuccess) {
                final users = state.items;
                return DropdownButton<User>(
                  items: users.map((User value) {
                    return DropdownMenuItem<User>(
                      value: value,
                      child: Text(value.name),
                    );
                  }).toList(),
                  onChanged: (user) {
                    if (user!.admin) {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const HomeAdminScreen()));
                    } else {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => HomeUserScreen(user: user)));
                    }
                  },
                );
              } else if (state is LoginLoading) {
                return const CupertinoActivityIndicator();
              } else if (state is LoginError) {
                return Text(state.errorMessage);
              } else {
                throw Exception('state is not supported');
              }
            },
          ),
        ),
      ),
    );
  }
}
