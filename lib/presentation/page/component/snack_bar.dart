part of '../component.dart';

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
