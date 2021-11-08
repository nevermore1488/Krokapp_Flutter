import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

enum AnimationType { rotate, scale }

class CustomAnimatedContainer extends StatefulWidget {
  final Widget child;
  final AnimationType animationType;

  CustomAnimatedContainer(
    this.animationType, {
    required this.child,
  });

  @override
  State<CustomAnimatedContainer> createState() =>
      _CustomAnimatedContainerState();
}

class _CustomAnimatedContainerState extends State<CustomAnimatedContainer>
    with TickerProviderStateMixin {
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
  Widget build(BuildContext context) {
    Widget transition;
    switch (widget.animationType) {
      case AnimationType.rotate:
        {
          transition = _rotationTransition(context);
          break;
        }
      case AnimationType.scale:
        {
          //transition = _scaleTransition(context);
          transition = widget.child;
          break;
        }
      default:
        throw ArgumentError("no such transition type");
    }
    return transition;
  }

  Widget _rotationTransition(BuildContext context) => RotationTransition(
        turns: Tween(begin: 0.0, end: 1.0).animate(animationController),
        child: widget.child,
      );

  Widget _scaleTransition(BuildContext context) => ScaleTransition(
        scale: CurvedAnimation(
          parent: animationController,
          curve: Curves.linear,
        ),
        child: widget.child,
      );
}
