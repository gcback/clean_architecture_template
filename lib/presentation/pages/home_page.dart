import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mylib/mylib.dart';

class HomePage extends HookConsumerWidget {
  const HomePage({super.key});

  static const title = 'Home';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text(title)),
      body: const Center(child: Text(title)),
    );
  }
}
