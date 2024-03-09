import 'package:mylib/mylib.dart';

final scaffoldSnackbarKey = GlobalKey<ScaffoldMessengerState>();

void showSnackBar(String message) {
  WidgetsBinding.instance.addPostFrameCallback((_) {
    final snackBar = SnackBar(
      duration: 3.secs,
      backgroundColor: Colors.grey,
      content: Text(message),
      showCloseIcon: true,
    );

    scaffoldSnackbarKey.currentState!.showSnackBar(snackBar);
  });
}

extension CircularProgressIndicatorExts on CircularProgressIndicator {
  get center => Center(child: this);
}

Widget buildRefrechIndicator([double? ratio]) => const Center(
      child: FittedBox(
        fit: BoxFit.contain,
        child: CircularProgressIndicator(
          strokeWidth: 2.0,
          strokeCap: StrokeCap.round,
        ),
      ),
    );
