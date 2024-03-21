import 'package:mylib/mylib.dart';

import '../component.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Splash Page'),
            SizedBox(height: 16),
            LoadingSpinner(size: 28.0),
          ],
        ),
      ),
    );
  }
}
