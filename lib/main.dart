import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mylib/mylib.dart';

import 'presentation/common_widgets.dart';
import 'presentation/navigation/router.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      scaffoldMessengerKey: scaffoldSnackbarKey,
      theme: lightTheme,
      darkTheme: darkTheme,
      routerConfig: router,
    );
  }
}
