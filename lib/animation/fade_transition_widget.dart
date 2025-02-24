import 'package:flutter/material.dart';

class FadeTransitionWidget extends AnimatedWidget {
  FadeTransitionWidget({required this.child, required this.opacity})
      : super(listenable: opacity);
  final Widget child;
  final Animation<double> opacity;
  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: opacity.value,
      child: child,
    );
  }
}
