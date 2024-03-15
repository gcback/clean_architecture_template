import 'package:mylib/mylib.dart';
import 'package:timelines_plus/timelines_plus.dart';

enum SelectOrder {
  selected,
  previous,
  none,
}

enum OrderStatusEnum {
  processing(
    color: Colors.black38,
    title: 'Processing',
    description: 'Your processing..',
    icon: Icons.hourglass_top_outlined,
  ),
  package(
    color: Colors.black38,
    title: 'Packaging',
    description: 'Your packaging in progress..',
    icon: Icons.touch_app_outlined,
  ),
  inTransit(
    color: Colors.black38,
    title: 'inTransit',
    description: 'Your packaging in transit..',
    icon: Icons.local_shipping_outlined,
  ),
  delivery(
    color: Colors.black38,
    title: 'Delivered',
    description: 'Your packaging has deliverd..',
    icon: Icons.task_alt_outlined,
  );

  final Color color;
  final String title;
  final String description;
  final IconData icon;

  const OrderStatusEnum({
    required this.color,
    required this.title,
    required this.description,
    required this.icon,
  });
}

class OrderStatusWidget extends HookWidget {
  const OrderStatusWidget({
    super.key,
    required this.color,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.showLine,
    required this.isActive,
    required this.order,
  });

  final Color color;
  final String title;
  final String subtitle;
  final IconData icon;

  final bool showLine;
  final bool isActive;
  final SelectOrder order;

  static Color selectedColor = Colors.grey.shade600;
  static Color defaultColor = Colors.grey.shade400;

  @override
  Widget build(BuildContext context) {
    final textColor =
        order == SelectOrder.selected ? Colors.white : Colors.black38;
    final iconColor =
        order == SelectOrder.selected ? Colors.white : Colors.black38;
    final activeColor =
        order == SelectOrder.selected ? selectedColor : defaultColor;

    final tween = order == SelectOrder.selected
        ? ColorTween(begin: defaultColor, end: selectedColor)
        : ColorTween(begin: selectedColor, end: defaultColor);

    return SizedBox(
      height: 90.0,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TimelineTile(
            nodeAlign: TimelineNodeAlign.start,
            mainAxisExtent: 95.0,
            crossAxisExtent: 64.0,
            contents: order == SelectOrder.selected
                ? Container(
                    alignment: Alignment.center,
                    child: Icon(
                      Icons.fire_truck,
                      color: selectedColor,
                    ),
                  )
                : null,
            node: TimelineNode(
              direction: Axis.vertical,
              indicatorPosition: 0.0,
              indicator: Indicator.outlined(
                borderWidth: 3,
                color: activeColor,
                size: 22.0,
                child: Indicator.dot(
                  size: 12.0,
                  color: activeColor,
                ),
              ),
              endConnector: showLine
                  ? DashedLineConnector(
                      thickness: 2.0,
                      gap: 2.0,
                      dash: 4.0,
                      color: activeColor,
                      // endIndent: 8.0,
                    )
                  : null,
            ),
          ),
          const Gap(4.0),
          Expanded(
            child: order != SelectOrder.none
                ? TweenAnimationBuilder(
                    tween: tween,
                    duration: 350.msecs,
                    builder: (context, value, child) {
                      return Card(
                        color: value,
                        child: ListTile(
                          title:
                              Text(title, style: TextStyle(color: textColor)),
                          subtitle: Text(subtitle,
                              style: TextStyle(color: textColor)),
                          trailing: Icon(
                            icon,
                            color: iconColor,
                          ),
                        ),
                      );
                    },
                  )
                : Card(
                    color: activeColor,
                    child: ListTile(
                      title: Text(title, style: TextStyle(color: textColor)),
                      subtitle:
                          Text(subtitle, style: TextStyle(color: textColor)),
                      trailing: Icon(
                        icon,
                        color: iconColor,
                      ),
                    ),
                  ),
          ),
          // TimelineTile(
          //   oppositeContents: const Padding(
          //     padding: EdgeInsets.all(8.0),
          //     child: Text('opposite\ncontents'),
          //   ),
          //   contents: Card(
          //     child: Container(
          //       padding: const EdgeInsets.all(8.0),
          //       child: const Text('contents'),
          //     ),
          //   ),
          //   node: const TimelineNode(
          //     indicator: DotIndicator(),
          //     startConnector: SolidLineConnector(),
          //     endConnector: SolidLineConnector(),
          //   ),
          // )
        ],
      ),
    );
  }
}
