part of '../navigation.dart';

class ScaffoldWithNavBar extends HookConsumerWidget {
  const ScaffoldWithNavBar({Key? key, required this.navigationShell})
      : super(key: key ?? const ValueKey('ScaffoldWithNavBar'));

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    void goBranch(int index) {
      switch (index) {
        case 4:
          ref
              .read(navbarState.notifier)
              .update((state) => state.copyWith(visible: false));
      }

      navigationShell.goBranch(
        index,
        // A common pattern when using bottom navigation bars is to support
        // navigating to the initial location when tapping the item that is
        // already active. This example demonstrates how to support this behavior,
        // using the initialLocation parameter of goBranch.
        initialLocation: index == navigationShell.currentIndex,
      );
    }

    return Scaffold(
      extendBody: true,
      // appBar: AppBar(
      //   leading: const IconButton(
      //     icon: Icon(Symbols.account_circle, weight: 200),
      //     onPressed: noop,
      //   ),
      //   actions: const [
      //     IconButton(
      //       icon: Icon(Symbols.logout, weight: 200),
      //       onPressed: noop,
      //     ),
      //   ],
      // ),
      body: navigationShell,
      bottomNavigationBar: BottomNav(goBranch, navigationShell.currentIndex),
    );
  }
}
