part of '../navigation.dart';

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
                      Future(
                          () => ref.read(visibleBottom.notifier).state = false);

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
