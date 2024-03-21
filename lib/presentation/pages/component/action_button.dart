import 'package:flutter/foundation.dart';
import 'package:mylib/mylib.dart';

import '../component.dart';
import 'hook_sideeffect.dart';

class ActionButton extends HookWidget {
  const ActionButton({
    super.key,
    required this.onPressed,
    // required this.label,
    required this.icon,
  });
  final AsyncCallback onPressed;
  // final Widget label;
  final Widget icon;

  @override
  Widget build(BuildContext context) {
    final (clear: _, :mutate, :snapshot) = useSideEffect<void>();
    Future<void> pressButton() async {
      final future = onPressed();
      mutate(future);
      try {
        await future;
      } catch (exception) {
        if (!context.mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Something went wrong $exception')),
        );
      }
    }

    return Center(
      child: IconButton(
        onPressed: switch (snapshot) {
          AsyncSnapshot(connectionState: ConnectionState.waiting) => null,
          _ => pressButton,
        },
        icon: switch (snapshot) {
          AsyncSnapshot(connectionState: ConnectionState.waiting) =>
            const LoadingSpinner(size: 16.0),
          _ => icon,
        },
        // label: label,
      ),
    );
  }
}
