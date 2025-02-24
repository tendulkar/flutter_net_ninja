import 'package:flutter/material.dart';

class ButtonControlledOpacityWidget extends StatefulWidget {
  const ButtonControlledOpacityWidget({super.key});

  @override
  State<ButtonControlledOpacityWidget> createState() =>
      _ButtonControlledOpacityWidgetState();
}

class _ButtonControlledOpacityWidgetState
    extends State<ButtonControlledOpacityWidget> {
  double _opacity = 0.5;

  void _incrementOpacity() {
    setState(() {
      _opacity += 0.1;
      if (_opacity > 1.0) {
        _opacity = 1.0;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Opacity(
          opacity: _opacity,
          child: Container(
              width: 300,
              height: 300,
              alignment: Alignment.center,
              color: Colors.blueAccent,
              child: Text(
                  "Animated Container Height: 300, Width: 300, opacity: $_opacity",
                  style: const TextStyle(color: Colors.white, fontSize: 24))),
        ),
        ElevatedButton(
          onPressed: _incrementOpacity,
          child: const Text("Increment opacity by 0.1",
              style: TextStyle(color: Colors.black, fontSize: 23)),
        ),
      ],
    );
  }
}
