import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:march_health_task/data/mock_data.dart';
import 'package:march_health_task/data/repo/repository.dart';
import 'package:march_health_task/ui/home/user/bloc/home_user_bloc.dart';

import '../../../data/user.dart';

class HomeUserScreen extends StatefulWidget {
  final User user;
  const HomeUserScreen({Key? key, required this.user}) : super(key: key);

  @override
  State<HomeUserScreen> createState() => _HomeUserScreenState();
}

class _HomeUserScreenState extends State<HomeUserScreen> {
  HomeUserBloc? bloc;
  StreamSubscription? subscription;

  @override
  void dispose() {
    subscription?.cancel();
    bloc?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<Score> scoreList = [];
    return BlocProvider<HomeUserBloc>(
      create: (context) {
        bloc = HomeUserBloc(context.read<Repository<User>>())
          ..add(HomeUserStarted(widget.user));
        bloc?.stream.listen((event) {
          if (event is HomeUserSubmitSuccess) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(event.msg)));
            Navigator.of(context).pop();
          }
        });
        return bloc!;
      },
      child: Scaffold(
        appBar: AppBar(title: const Text('Rate your colleagues')),
        body: BlocBuilder<HomeUserBloc, HomeUserState>(
          buildWhen: (previous, current) =>
              current is HomeUserSuccess ||
              current is HomeUserLoading ||
              current is HomeUserError,
          builder: (context, state) {
            if (state is HomeUserSuccess) {
              final users = state.items;
              return Column(
                children: [
                  Expanded(
                    child: _UserList(
                      users: users,
                      scoreList: scoreList,
                    ),
                  ),
                  Button(
                    scoreList: scoreList,
                    users: users,
                    user: widget.user,
                  )
                ],
              );
            } else if (state is HomeUserLoading) {
              return const Center(child: CupertinoActivityIndicator());
            } else if (state is HomeUserError) {
              return Center(child: Text(state.errorMessage));
            } else {
              throw Exception('state is not supported');
            }
          },
        ),
      ),
    );
  }
}

class Button extends StatelessWidget {
  const Button({
    Key? key,
    required this.user,
    required this.scoreList,
    required this.users,
  }) : super(key: key);

  final User user;
  final List<Score> scoreList;
  final List<User> users;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          if (user.checked == true) {
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('You have already rated')));
          } else if (scoreList.length != users.length) {
            ScaffoldMessenger.of(context)
                .showSnackBar(const SnackBar(content: Text('Rate all users')));
          } else {
            context
                .read<HomeUserBloc>()
                .add(HomeUserClickedSubmit(user, scoreList));
          }
        },
        child: const Text('     Submit     '));
  }
}

class _UserList extends StatelessWidget {
  const _UserList({
    Key? key,
    required this.users,
    required this.scoreList,
  }) : super(key: key);

  final List<User> users;
  final List<Score> scoreList;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          final user = users[index];
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(user.name),
                _Dropdown(scoreList: scoreList, user: user)
              ],
            ),
          );
        });
  }
}

class _Dropdown extends StatefulWidget {
  _Dropdown({
    Key? key,
    required this.scoreList,
    required this.user,
  }) : super(key: key);

  final List<Score> scoreList;
  final User user;
  Badge? _selectedBadge;

  @override
  State<_Dropdown> createState() => _DropdownState();
}

class _DropdownState extends State<_Dropdown> {
  @override
  Widget build(BuildContext context) {
    return widget._selectedBadge == null
        ? DropdownButton<Badge>(
            items: getBadges().map((Badge value) {
              return DropdownMenuItem<Badge>(
                value: value,
                child: Text(value.name),
              );
            }).toList(),
            onChanged: (badge) {
              widget.scoreList.add(Score(widget.user, badge!));
              setState(() {
                widget._selectedBadge = badge;
              });
            },
          )
        : Text('${widget._selectedBadge?.name} was chosen');
  }
}
