part of '../navigation.dart';

class BottomNav extends HookConsumerWidget {
  const BottomNav(this.goBranch, this.currentIndex, {super.key});

  final void Function(int inde) goBranch;
  final int currentIndex;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bottomState = ref.watch(navbarState);

    return AnimatedAlignPositioned(
      alignment: Alignment.bottomCenter,
      /// 상하로 애니메이션
      moveByChildHeight: bottomState.visible ? 0.0 : 1.0,
      /// 좌우로 애이메이션
      // moveByChildWidth: isVisibleBottom ? 0.0 : 1.0,
      child: ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 12.0, sigmaY: 12.0),
          child: NavigationBar(
            backgroundColor: const Color.fromRGBO(0, 0, 0, 0),
            selectedIndex: currentIndex,
            onDestinationSelected: (index) {
              ref.watch(navbarState.notifier).update((state) =>
                  state.copyWith(currentIdx: index, previousIdx: currentIndex));

              goBranch(index);
            },
            labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
            destinations: const [
              NavigationDestination(
                selectedIcon: Icon(Symbols.home, weight: 200, fill: 1.0),
                icon: Icon(Symbols.home, weight: 200),
                label: 'Home',
              ),
              NavigationDestination(
                selectedIcon: Icon(Symbols.people, weight: 200, fill: 1.0),
                icon: Icon(Symbols.people, weight: 200),
                label: 'Users',
              ),
              NavigationDestination(
                selectedIcon: Icon(Symbols.commute, weight: 200, fill: 1.0),
                icon: Icon(Symbols.commute, weight: 200),
                label: 'Commute',
              ),
              NavigationDestination(
                selectedIcon: Icon(Symbols.save, weight: 200, fill: 1.0),
                icon: Icon(Symbols.save, weight: 200),
                label: 'Saved',
              ),
              NavigationDestination(
                selectedIcon: Icon(Symbols.settings, weight: 200, fill: 1.0),
                icon: Icon(Symbols.settings, weight: 200),
                label: 'Settings',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
