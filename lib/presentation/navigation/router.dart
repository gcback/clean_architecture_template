part of '../navigation.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorAKey = GlobalKey<NavigatorState>(debugLabel: 'Home');
final _shellNavigatorBKey = GlobalKey<NavigatorState>(debugLabel: 'Users');
final _shellNavigatorCKey = GlobalKey<NavigatorState>(debugLabel: 'Commute');
final _shellNavigatorDKey = GlobalKey<NavigatorState>(debugLabel: 'Saved');
final _shellNavigatorEKey = GlobalKey<NavigatorState>(debugLabel: 'Settings');
final _shellNavigatorFKey = GlobalKey<ConsumerState>(debugLabel: 'Settings2');

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
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: _shellNavigatorBKey,
          routes: [
            GoRoute(
              path: '/users',
              builder: (context, state) => Consumer(
                builder: (context, ref, child) {
                  _gRef = ref;
                  return child!;
                },
                child: const UsersPage(),
              ),
              routes: [
                GoRoute(
                  path: 'detail',
                  builder: (context, state) {
                    /// detail 화면은 fullscreen이다. --> bottombar를 숨기자.
                    Future(() => _gRef
                        ?.read(navbarState.notifier)
                        .update((state) => state.copyWith(visible: false)));

                    return ProfileDetail(state.extra as Profile);
                  },
                  onExit: (context) {
                    /// 화면을 나오면 bottombar 복귀
                    _gRef
                        ?.read(navbarState.notifier)
                        .update((state) => state.copyWith(visible: true));
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
              builder: (context, state) => Consumer(
                key: _shellNavigatorFKey,
                builder: (context, ref, child) {
                  _gRef = ref;

                  return child!;
                },
                child: const SettingsPage(),
              ),
              onExit: (context) {
                _gRef
                    ?.read(navbarState.notifier)
                    .update((state) => state.copyWith(visible: true));
                return true;
              },
            ),
          ],
        ),
      ],
    ),
  ],
);
