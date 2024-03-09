part of '../component.dart';

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
