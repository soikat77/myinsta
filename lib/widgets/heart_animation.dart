import 'package:flutter/material.dart';

class HeartAnimation extends StatefulWidget {
  final Widget child;
  final bool isAnimate;
  final Duration duration;
  final VoidCallback? onEnd;
  final bool smallLike;

  const HeartAnimation({
    super.key,
    required this.child,
    required this.isAnimate,
    this.duration = const Duration(milliseconds: 150),
    this.onEnd,
    this.smallLike = false,
  });

  @override
  State<HeartAnimation> createState() => _HeartAnimationState();
}

class _HeartAnimationState extends State<HeartAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> scale;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: widget.duration.inMilliseconds ~/ 2,
      ),
    );
    scale = Tween<double>(begin: 1, end: 1.2).animate(controller);
  }

  void didUpdateWidget(covariant HeartAnimation oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.isAnimate != oldWidget.isAnimate) {
      startAnimation();
    }
  }

  void startAnimation() async {
    if (widget.isAnimate || widget.smallLike) {
      await controller.forward();
      await controller.reverse();
      await Future.delayed(
        const Duration(milliseconds: 200),
      );

      if (widget.onEnd != null) {
        widget.onEnd!();
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: scale,
      child: widget.child,
    );
  }
}
