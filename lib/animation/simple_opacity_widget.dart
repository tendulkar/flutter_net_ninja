import 'package:flutter/material.dart';

class SimpleOpacityWidget extends StatelessWidget {
  const SimpleOpacityWidget({super.key});
  final double _opacity = 0.5;

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: _opacity,
      child: Container(
          width: 300,
          height: 300,
          alignment: Alignment.center,
          color: Colors.blueAccent,
          child: Text(
              "Animated Container Height: 300, Width: 300, opacity: $_opacity",
              style: const TextStyle(color: Colors.white, fontSize: 24))),
    );
  }
}
