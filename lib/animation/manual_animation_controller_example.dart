import 'package:flutter/material.dart';

// Learning:
// AnimationController is a driver of animation, it can be started with forward(), reverse(), reset(),
// Tween is a source of animation values, it can be used with AnimationController, kind of just range.
// tween.animate(AnimationController) will ask AnimationContorller to use this tween for animation.
// AnimationController drives the animation, it can be stopped, reversed, reset.
// AnimationController kind of listens ticks from frame builder, and generates values for animation.
// We can use the generated animation value to build new widget.
// AnimationController generates --> Streams values --> (with listener + setState()) we generate stream of widgets
class ManualAnimationControllerExampleApp extends StatefulWidget {
  const ManualAnimationControllerExampleApp({super.key});

  @override
  State<ManualAnimationControllerExampleApp> createState() =>
      _ManualAnimationControllerExampleAppState();
}

class _ManualAnimationControllerExampleAppState
    extends State<ManualAnimationControllerExampleApp>
    with SingleTickerProviderStateMixin {
  double _opacity = 0.5;
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(seconds: 6),
      vsync: this,
    );

    _animation = Tween<double>(begin: 0, end: 1).animate(_animationController);

    _animation.addListener(() {
      setState(() {
        _opacity = _animation.value;
      });
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Manual Animation Controller Example'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 20,
            children: [
              Opacity(
                opacity: _opacity,
                child: Container(
                    width: 200,
                    height: 200,
                    alignment: Alignment.center,
                    color: Colors.blueAccent,
                    child: const Text('Animated Container',
                        style: TextStyle(color: Colors.white, fontSize: 24))),
              ),
              ElevatedButton(
                onPressed: () {
                  _animationController.forward();
                },
                child: const Text('Start Animation'),
              ),
              ElevatedButton(
                onPressed: () {
                  _animationController.reverse();
                },
                child: const Text('Reverse Animation'),
              ),
              ElevatedButton(
                onPressed: () {
                  _animationController.reset();
                },
                child: const Text('Reset Animation'),
              ),
              ElevatedButton(
                onPressed: () {
                  _animationController.dispose();
                },
                child: const Text('Dispose Animation'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
