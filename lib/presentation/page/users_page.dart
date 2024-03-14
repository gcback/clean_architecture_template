part of '../page.dart';

class UsersPage extends HookConsumerWidget {
  const UsersPage({super.key});

  static const title = 'Users';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userCollection = ref.watch(usersProvider);
    final scroller = useScrollController();
    useEffectOnce(() {
      // 스크롤 방향에 따라 bottomBar를 숨길지 보일지 결정한다.
      scroller.addListener(() {
        final direction = scroller.position.userScrollDirection;
        final isEnabled = switch (direction) {
          ScrollDirection.reverse => false,
          ScrollDirection.forward => true,
          _ => ref.watch(navbarState).visible, // not changed
        };

        ref
            .watch(navbarState.notifier)
            .update((state) => state.copyWith(visible: isEnabled));
      });
    });

    return ScrollsToTop(
      onScrollsToTop: (event) async {
        final BottomNavState(currentIdx: index) = ref.watch(navbarState);

        if (index == 1) {
          scroller.animateTo(
            event.to,
            duration: event.duration,
            curve: event.curve,
          );
        }
      },
      child: Scaffold(
        primary: true,
        appBar: AppBar(
          surfaceTintColor: Theme.of(context).scaffoldBackgroundColor,
          title: const Text(title),
        ),
        body: switch (userCollection) {
          AsyncData(:final value) => CustomScrollView(
              // primary: true,
              controller: scroller,
              slivers: [
                CupertinoSliverRefreshControl(
                  onRefresh: () => ref.refresh(usersProvider.future),
                  builder: (_, __, ___, ____, _____) => buildRefrechIndicator(),
                ),
                SliverList.builder(
                  itemCount: value.total + 1,
                  itemBuilder: (context, index) {
                    if (value.total < 6 && index == value.total) {
                      return ActionButton(
                        onPressed: ref.read(usersProvider.notifier).next,
                        icon: const Icon(Symbols.download),
                      );
                    }

                    // for infinite scrolling
                    if (index == value.total) {
                      ref.read(usersProvider.notifier).next();

                      return const Center(
                        child: CircularProgressIndicator(
                          strokeWidth: 2.0,
                          strokeCap: StrokeCap.round,
                        ),
                      );
                    }

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
      ),
    );
  }
}
