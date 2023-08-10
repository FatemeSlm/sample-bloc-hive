import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:march_health_task/data/repo/repository.dart';
import 'package:march_health_task/data/user.dart';
import 'package:march_health_task/ui/home/admin/bloc/home_admin_bloc.dart';

class HomeAdminScreen extends StatelessWidget {
  const HomeAdminScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeAdminBloc>(
      create: (context) => HomeAdminBloc(context.read<Repository<User>>())
        ..add(HomeAdminStarted()),
      child: Scaffold(
        appBar: AppBar(title: const Text('result')),
        body: BlocBuilder<HomeAdminBloc, HomeAdminState>(
          builder: (context, state) {
            if (state is HomeAdminSuccess) {
              final items = state.items;
              return _BadgeResult(items: items);
            } else if (state is HomeAdminLoading) {
              return const Center(child: CupertinoActivityIndicator());
            } else if (state is HomeAdminError) {
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

class _BadgeResult extends StatelessWidget {
  const _BadgeResult({
    Key? key,
    required this.items,
  }) : super(key: key);

  final List<Result> items;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                children: [
                  Text(item.user.name),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(child: Text(item.badgeResult))
                ],
              ),
              const SizedBox(
                height: 16,
              )
            ],
          ),
        );
      },
    );
  }
}
