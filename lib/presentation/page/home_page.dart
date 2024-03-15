part of '../page.dart';

class HomePage extends HookConsumerWidget {
  const HomePage({super.key});

  static const title = 'Home';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final current = useState(0);

    return Scaffold(
      extendBodyBehindAppBar: true,

      appBar: AppBar(
        title: const Text(title),
      ),
      body: Center(
        child: Padding(
          padding: 12.0.horiInsets,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (var (i, e) in OrderStatusEnum.values.indexed)
                OrderStatusWidget(
                  color: current.value == i ? e.color : Colors.grey.shade400,
                  title: e.title,
                  subtitle: e.description,
                  icon: e.icon,
                  showLine: i < OrderStatusEnum.values.length - 1,
                  isActive: current.value == i,
                  order: switch (current.value - 1) {
                    int val when val == i || (val < 0 && i == 3) =>
                      SelectOrder.previous,
                    int val when (val + 1) == i => SelectOrder.selected,
                    _ => SelectOrder.none,
                  },
                ),
            ],
          ),
        ),
      ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: Align(
        alignment: const Alignment(1, 0.7),
        // moveByChildHeight: -2.0,
        child: FloatingActionButton(
          onPressed: () {
            current.value = (current.value + 1) % OrderStatusEnum.values.length;
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
