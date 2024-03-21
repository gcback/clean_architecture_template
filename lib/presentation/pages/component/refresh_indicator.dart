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

class LoadingSpinner extends StatelessWidget {
  const LoadingSpinner({required this.size, super.key});
  final double size;

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: size,
      child: const CircularProgressIndicator(
        strokeWidth: 1.5,
      ),
    );
  }
}
