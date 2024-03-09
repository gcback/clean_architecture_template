import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mvvm/presentation/navigation/navbar.dart';
import 'package:mylib/mylib.dart';

class CommutePage extends HookConsumerWidget {
  const CommutePage({super.key});

  static const title = 'Commute';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isVisibleBottom = ref.watch(visibleBottom);

    useValueChanged(isVisibleBottom, (_, __) {
      Future(() => ref.read(visibleBottom.notifier).state = isVisibleBottom);
      return true;
    });

    return const Center(child: Text(title));
  }
}
