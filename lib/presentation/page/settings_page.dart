part of '../page.dart';

class SettingsPage extends HookConsumerWidget {
  const SettingsPage({super.key});

  static const title = 'Settings';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(title),
        leading: IconButton(
            onPressed: () {
              final BottomNavState(:previousIdx) = ref.watch(navbarState);
              final prevRoute = NavItem.getById(previousIdx).route;

              context.go(prevRoute);
            },
            icon: const Icon(Icons.arrow_back)),
      ),
      body: const Center(child: Text(title)),
    );
  }
}
