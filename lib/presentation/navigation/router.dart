import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mvvm/domain/user.dart';
import 'package:mvvm/presentation/navigation/navbar.dart';

import 'package:mylib/mylib.dart';

import '../pages/home_page.dart';
import '../pages/commute_page.dart';
import '../pages/saved_page.dart';
import '../pages/settings_page.dart';
import '../pages/users_page.dart';
import '../user_detail_page.dart';
import 'scaffold_with_navbar.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorAKey = GlobalKey<NavigatorState>(debugLabel: 'Home');
final _shellNavigatorBKey = GlobalKey<NavigatorState>(debugLabel: 'Users');
final _shellNavigatorCKey = GlobalKey<NavigatorState>(debugLabel: 'Commute');
final _shellNavigatorDKey = GlobalKey<NavigatorState>(debugLabel: 'Saved');
final _shellNavigatorEKey = GlobalKey<NavigatorState>(debugLabel: 'Settings');

WidgetRef? _gRef;

final GoRouter router = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/',
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return ScaffoldWithNavBar(
          navigationShell: navigationShell,
        );
      },
      branches: [
        StatefulShellBranch(
          navigatorKey: _shellNavigatorAKey,
          routes: [
            GoRoute(
              path: '/',
              builder: (context, state) => const HomePage(),
              // pageBuilder: (context, state) =>
              //     const NoTransitionPage(child: HomePage()),
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: _shellNavigatorBKey,
          routes: [
            GoRoute(
              path: '/users',
              builder: (context, state) => const UsersPage(),
              routes: [
                GoRoute(
                  path: 'detail',
                  builder: (context, state) => Consumer(
                    builder: (context, ref, child) {
                      _gRef = ref;
                      Future(() => ref.read(visibleBottom.notifier).state = false);

                      return UserDetail(state.extra as User);
                    },
                  ),
                  onExit: (context) {
                    _gRef?.read(visibleBottom.notifier).state = true;
                    return true;
                  },
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: _shellNavigatorCKey,
          routes: [
            GoRoute(
              path: '/commute',
              builder: (context, state) => const CommutePage(),
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: _shellNavigatorDKey,
          routes: [
            GoRoute(
              path: '/saved',
              builder: (context, state) => const SavedPage(),
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: _shellNavigatorEKey,
          routes: [
            GoRoute(
              path: '/settings',
              builder: (context, state) => const SettingsPage(),
            ),
          ],
        ),
      ],
    ),
  ],
);
