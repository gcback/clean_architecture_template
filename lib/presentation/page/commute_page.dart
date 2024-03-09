part of '../page.dart';

class CommutePage extends HookConsumerWidget {
  const CommutePage({super.key});

  static const title = 'Commute';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Center(child: Text(title));
  }
}
