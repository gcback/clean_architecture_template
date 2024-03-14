import 'package:dart_mappable/dart_mappable.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:mylib/mylib.dart';

part 'navbar_state.mapper.dart';

@MappableClass()
class BottomNavState with BottomNavStateMappable {
  /// 현재 bottombar를 보여줄지 숨길지 결정
  final bool visible;

  /// 현재 선택된 item index
  final int currentIdx;

  /// 직전에 선택된 item index
  final int previousIdx;

  BottomNavState(
      {required this.visible,
      required this.currentIdx,
      required this.previousIdx});
}

enum NavItem {
  home('Home', '/', Symbols.home),
  users('Users', '/users', Symbols.people),
  commute('Commute', '/commute', Symbols.commute),
  saved('Saved', '/saved', Symbols.save),
  menu('Settings', '/settings', Symbols.settings);

  final String label;
  final String route;
  final IconData selectedIcon;

  const NavItem(this.label, this.route, this.selectedIcon);

  factory NavItem.getById(int index) {
    return NavItem.values.firstWhere((el) => el.index == index);
  }
}

final navbarState = StateProvider(
  (ref) => BottomNavState(visible: true, currentIdx: 0, previousIdx: 0),
);
