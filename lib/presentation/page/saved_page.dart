part of '../page.dart';

class SavedPage extends StatelessWidget {
  const SavedPage({super.key});

  static const title = 'Saved';


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text(title)),
        body: const Center(child: Text(title)));
  }
}
