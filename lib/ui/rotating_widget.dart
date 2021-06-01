import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class RotatingWidget extends StatefulWidget {
  final Widget child;

  RotatingWidget({required this.child});

  @override
  State<RotatingWidget> createState() => _RotatingWidgetState();
}

class _RotatingWidgetState extends State<RotatingWidget> with TickerProviderStateMixin {
  late AnimationController animationController;

  @override
  void initState() {
    super.initState();

    animationController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );
    animationController.forward();
    animationController.addListener(() {
      if (animationController.isCompleted) {
        animationController.repeat();
      }
    });
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => RotationTransition(
        turns: Tween(begin: 0.0, end: 1.0).animate(animationController),
        child: widget.child,
      );
}
