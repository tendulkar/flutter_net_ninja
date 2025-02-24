import 'package:flutter/material.dart';

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
  Duration _elapsedDuration = Duration.zero;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(seconds: 6),
      vsync: this,
    );

    _animation =
        Tween<double>(begin: 0.5, end: 1).animate(_animationController);

    _animation.addListener(() {
      setState(() {
        _opacity = _animation.value;
        if (_animationController.isAnimating) {
          if (_animationController.status == AnimationStatus.forward) {
            _elapsedDuration =
                _animationController.lastElapsedDuration ?? Duration.zero;
          } else if (_animationController.status == AnimationStatus.reverse) {
            _elapsedDuration = _animationController.duration! -
                (_animationController.lastElapsedDuration ?? Duration.zero);
          }
        }
      });
    });

    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _elapsedDuration = _animationController.duration!;
      } else if (status == AnimationStatus.dismissed) {
        _elapsedDuration = Duration.zero;
      }
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
            children: [
              Opacity(
                opacity: _opacity,
                child: Container(
                  width: 400,
                  height: 400,
                  alignment: Alignment.center,
                  color: Colors.blueAccent,
                  child: Text(
                    "AnimatedController container\n"
                    "Opacity: ${_opacity.toStringAsFixed(2)}\n"
                    "Elapsed: ${(_elapsedDuration.inMilliseconds / 1000).toStringAsFixed(1)}s\n"
                    "Status: ${_animationController.status.toString()}",
                    style: const TextStyle(color: Colors.white, fontSize: 24),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  _animationController.forward();
                },
                child: const Text('Start Animation'),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  _animationController.reverse();
                },
                child: const Text('Reverse Animation'),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _elapsedDuration = Duration.zero;
                    _animationController.reset();
                  });
                },
                child: const Text('Reset Animation'),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  _animationController.stop();
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
