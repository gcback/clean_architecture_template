part of '../navigation.dart';

enum NavItem {
  home('Home', '/', Symbols.home),
  users('Users', '/users', Symbols.people),
  saved('Saved', '/saved', Symbols.save),
  commute('Commute', '/commute', Symbols.commute),
  menu('Settings', '/settings', Symbols.settings);

  final String label;
  final String route;
  final IconData selectedIcon;

  const NavItem(this.label, this.route, this.selectedIcon);

  factory NavItem.getById(int index) {
    return NavItem.values.firstWhere((el) => el.index == index);
  }
}

final visibleBottom = StateProvider((ref) => true);

class BottomNav extends HookConsumerWidget {
  const BottomNav(this.goBranch, this.currentIndex, {super.key});

  final void Function(int inde) goBranch;
  final int currentIndex;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isVisibleBottom = ref.watch(visibleBottom);

    return AnimatedAlignPositioned(
      alignment: Alignment.bottomCenter,
      moveByChildHeight: isVisibleBottom ? 0.0 : 1.0,
      child: ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 12.0,
            sigmaY: 12.0,
          ),
          child: NavigationBar(
            backgroundColor: Colors.transparent,
            selectedIndex: currentIndex,
            onDestinationSelected: goBranch,
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
