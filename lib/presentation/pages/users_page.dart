import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mylib/mylib.dart';

import '../../domain/user_controller.dart';
import '../common_widgets.dart';
import '../usertile_view.dart';

class UsersPage extends HookConsumerWidget {
  const UsersPage({super.key});

  static const title = 'Users';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userCollection = ref.watch(usersProvider);

    return Scaffold(
      appBar: AppBar(),
      body: switch (userCollection) {
        AsyncData(:final value) => CustomScrollView(
            slivers: [
              CupertinoSliverRefreshControl(
                onRefresh: () => ref.watch(usersProvider.notifier).nextUsers(),
                builder: (_, __, ___, ____, _____) => buildRefrechIndicator(),
              ),
              SliverList.builder(
                itemCount: value.total,
                itemBuilder: (context, index) {
                  final item = value.users[index];

                  return Dismissible(
                    key: ValueKey(item.no),
                    background: Container(color: Colors.yellow),
                    secondaryBackground: Container(color: Colors.red),
                    onDismissed: (direction) {
                      ref.watch(usersProvider.notifier).remove(item.no);
                    },
                    child: UserTile(profile: item),
                  );
                },
              ),
            ],
          ),
        AsyncError(:final error) => Center(child: Text(error.toString())),
        const AsyncLoading() || _ => buildRefrechIndicator(),
      }, //?? const Center(),
    );
  }
}
