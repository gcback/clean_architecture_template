part of '../page.dart';

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
                onRefresh: () => ref.watch(usersProvider.notifier).next(),
                builder: (_, __, ___, ____, _____) => buildRefrechIndicator(),
              ),
              SliverList.builder(
                itemCount: value.total,
                itemBuilder: (context, index) {
                  final item = value.users[index];

                  return HookBuilder(
                    builder: (context) {
                      final progress = useState(0.0);

                      return Dismissible(
                        key: ValueKey(item.no),
                        background: Container(color: Colors.yellow),
                        secondaryBackground: AlignPositioned(
                          alignment: Alignment(1 - progress.value, 0),
                          child: CircularProgressIndicator(
                            value: progress.value,
                          ),
                        ),
                        onDismissed: (direction) {
                          ref.watch(usersProvider.notifier).remove(item.no);
                        },
                        onUpdate: (details) {
                          progress.value = details.progress;
                        },
                        child: UserTile(profile: item),
                      );
                    },
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
