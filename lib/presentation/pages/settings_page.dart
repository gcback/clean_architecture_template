import 'package:mylib/mylib.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  static const title = 'Settings';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: true,
      child: Scaffold(
        extendBody: false,
        appBar: AppBar(title: const Text(title)),
        body: const Center(child: Text(title)),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
