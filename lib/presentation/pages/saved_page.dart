part of '../page.dart';

class SavedPage extends StatelessWidget {
  const SavedPage({super.key});

  static const title = 'Saved';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 250.0),
          Expanded(
            child: Center(
              child: AspectRatio(
                aspectRatio: 2 / 3,
                child: CardStack(
                  itemCount: 4,
                  itemBuilder: (context, index) => CardItem(id: index),
                ),
              ),
            ),
          ),
          const SizedBox(height: 250.0),
        ],
      ),
    );
  }
}

double defaultAngle180Degree = pi * 0.1;

class CardStack extends HookWidget {
  const CardStack(
      {super.key,
      required this.itemCount,
      this.initIndex = 0,
      required this.itemBuilder});

  final int itemCount;
  final int initIndex;
  final Widget Function(BuildContext, int) itemBuilder;

  bool lastIndex(int i) => i == (itemCount - 1);

  @override
  Widget build(BuildContext context) {
    final index = useRef(initIndex);
    final slideDirection = useRef(SlideDirection.left);
    final controller = useAnimationController(duration: 400.msecs);

    void animationListner(AnimationStatus status) {
      if (status == AnimationStatus.completed) {
        if (itemCount == ++index.value) {
          index.value = 0;
        }

        controller.reset();
      }
    }

    useEffectOnce(() {
      controller.addStatusListener(animationListner);
    });

    Future onSlideOut(SlideDirection direction) async {
      slideDirection.value = direction;
      await controller.forward();
    }

    Offset getOffser(int id) =>
        {
          0: Offset(lerpDouble(100, -70, controller.value)!, 130),
          1: Offset(lerpDouble(-100, 70, controller.value)!, 30),
          2: const Offset(70, 30) * (1 - controller.value),
        }[id] ??
        Offset(
            MediaQuery.of(context).size.width *
                controller.value *
                (slideDirection.value == SlideDirection.left ? -1 : 1),
            0.0);

    double getAngle(int id) =>
        {
          0: lerpDouble(0, -defaultAngle180Degree, controller.value),
          1: lerpDouble(
              -defaultAngle180Degree, defaultAngle180Degree, controller.value),
          2: lerpDouble(defaultAngle180Degree, 0, controller.value),
        }[id] ??
        0.0;

    double getScale(int id) =>
        {
          0: lerpDouble(0.6, 0.5, controller.value),
          1: lerpDouble(0.9, 0.95, controller.value),
          2: lerpDouble(0.95, 1.0, controller.value),
        }[id] ??
        1.0;

    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) => Stack(
        children: List.generate(
          4,
          (stackIndex) {
            final (scale, angle, offset) = (
              getScale(stackIndex),
              getAngle(stackIndex),
              getOffser(stackIndex)
            );
            final transform = Matrix4.identity()
              ..scale(scale)
              ..rotateZ(angle)
              ..translate(offset.dx, offset.dy);
            final modIndex = (index.value + 3 - stackIndex) % itemCount;

            return Transform(
              alignment: Alignment.center,
              transform: transform,
              child: DraggableWidget(
                onPressed: noop,
                isEnableDrag: lastIndex(stackIndex),
                onSlideOut: onSlideOut,
                child: itemBuilder(context, modIndex),
              ), //.measured(outlined: true),
            );
          },
        ),
      ),
    ); //.measured(outlined: true);
  }
}

enum SlideDirection { left, right }

class DraggableWidget extends HookWidget {
  const DraggableWidget(
      {super.key,
      required this.child,
      this.onSlideOut,
      required this.onPressed,
      required this.isEnableDrag});

  final Widget child;
  final Future<void> Function(SlideDirection)? onSlideOut;
  final VoidCallback onPressed;
  final bool isEnableDrag;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final size = useRef(Size.zero);
    final widgetKey = useMemoized(() => GlobalKey());
    final panOffset = useState(Offset.zero);
    final panAngle = useRef(0.0);
    final itWasMadeSlide = useState(false);
    final restoreController =
        useAnimationController(duration: kThemeAnimationDuration);

    double getOutSizeLimit() => size.value.width * 0.65;

    void onPanStart(DragStartDetails details) {
      if (restoreController.isAnimating) return;
      panOffset.value = Offset.zero;
    }

    void onPanUpdate(DragUpdateDetails details) {
      if (restoreController.isAnimating) return;

      panOffset.value += details.delta;
      panAngle.value = getCurrentAngle(
        getCurrentPosition(widgetKey).dx,
        size.value,
        screenSize,
      );
    }

    void onPanEnd(DragEndDetails details) {
      if (restoreController.isAnimating) return;

      final velocityX = details.velocity.pixelsPerSecond.dx;
      final positionX = getCurrentPosition(widgetKey).dx;

      if (velocityX < -1000 || positionX < -getOutSizeLimit()) {
        itWasMadeSlide.value = onSlideOut != null;

        /// sliding animation을 마치면 top item을 초기화 한다.
        onSlideOut?.call(SlideDirection.left).then((_) {
          panAngle.value = 0.0;
          panOffset.value = Offset.zero;
        });

        return;
      }

      if (velocityX > 1000 ||
          positionX > (screenSize.width - getOutSizeLimit())) {
        itWasMadeSlide.value = onSlideOut != null;

        /// sliding animation을 마치면 top item을 초기화 한다.
        onSlideOut?.call(SlideDirection.right).then((_) {
          panAngle.value = 0.0;
          panOffset.value = Offset.zero;
        });

        return;
      }

      restoreController.forward();
    }

    void restoreAnimationListner() {
      if (restoreController.isCompleted) {
        itWasMadeSlide.value = false;
        panOffset.value = Offset.zero;
        panAngle.value = 0.0;
        restoreController.reset();
      }
    }

    useEffectOnce(() {
      restoreController.addListener(restoreAnimationListner);

      WidgetsBinding.instance.addPostFrameCallback((_) {
        size.value = getChildSize(widgetKey);
      });
    });

    final widget = SizedBox(key: widgetKey, child: child);
    if (!isEnableDrag) return widget;

    return GestureDetector(
      onPanStart: onPanStart,
      onPanEnd: onPanEnd,
      onPanUpdate: onPanUpdate,
      child: AnimatedBuilder(
        animation: restoreController,
        builder: (context, child) {
          final value = 1 - restoreController.value;

          final offset = panOffset.value * value;
          final angle = panAngle.value * (itWasMadeSlide.value ? 1 : value);

          final transform = Matrix4.identity()
            ..rotateZ(angle)
            ..translate(offset.dx, offset.dy);

          return Transform(transform: transform, child: widget);
        },
      ),
    ); //.measured(outlined: true);
  }

  Offset getCurrentPosition(GlobalKey key) {
    final renderBox = key.currentContext?.findRenderObject() as RenderBox?;
    return renderBox?.localToGlobal(Offset.zero) ?? Offset.zero;
  }

  Size getChildSize(GlobalKey key) {
    return (key.currentContext?.findRenderObject() as RenderBox?)?.size ??
        Size.zero;
  }

  double getCurrentAngle(double dx, Size size, Size screen) {
    return dx < 0
        ? (pi * 0.1) * dx / size.width
        : dx + size.width > screen.width
            ? (pi * 0.1) * (dx + size.width - screen.width) / size.width
            : 0;
  }
}

class CardItem extends HookWidget {
  const CardItem({super.key, required this.id});
  final int id;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        image: DecorationImage(
          image: CachedNetworkImageProvider(id.image('nature')),
          fit: BoxFit.cover,
        ),
      ),
      alignment: const Alignment(0.9, 0.95),
      child: Text(
        id.toString(),
        style:
            const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
      ),
    );
  }
}
