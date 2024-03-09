import 'package:mylib/mylib.dart';

class SavedPage extends StatelessWidget {
  const SavedPage({super.key});

  static const title = 'Saved';

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text(title)),
    );
  }
}
