import 'package:flutter/material.dart';
import 'dart:math' as math;

/// TweenAnimationBuilder Example
///
/// TweenAnimationBuilder is the most flexible implicit animation widget.
/// It can animate:
/// - Any type of value that can be interpolated
/// - Custom objects
/// - Multiple properties simultaneously
/// - Complex animations
///
/// Key Benefits:
/// 1. Complete control over animation
/// 2. Can animate custom properties
/// 3. No need for AnimationController
/// 4. Perfect for custom animations

class TweenAnimationBuilderExample extends StatefulWidget {
  const TweenAnimationBuilderExample({super.key});

  @override
  State<TweenAnimationBuilderExample> createState() =>
      _TweenAnimationBuilderExampleState();
}

class _TweenAnimationBuilderExampleState
    extends State<TweenAnimationBuilderExample> {
  double _progress = 0.0;
  Color _color = Colors.blue;
  double _angle = 0.0;

  void _updateProgress() {
    setState(() {
      _progress = (_progress + 0.2).clamp(0.0, 1.0);
      if (_progress >= 1.0) {
        _color = Color.lerp(
          _color,
          Colors.primaries[math.Random().nextInt(Colors.primaries.length)],
          0.5,
        )!;
      }
      _angle += math.pi / 2; // 90 degrees
    });
  }

  void _resetAnimation() {
    setState(() {
      _progress = 0.0;
      _color = Colors.blue;
      _angle = 0.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('TweenAnimationBuilder Example'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Complex animation combining multiple TweenAnimationBuilders
              Column(
                // alignment: Alignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Rotation animation
                  TweenAnimationBuilder<double>(
                    tween: Tween<double>(begin: 0, end: _angle),
                    duration: const Duration(seconds: 6),
                    curve: Curves.easeInOut,
                    builder: (context, angle, child) {
                      return Transform.rotate(
                        angle: angle,
                        child: child,
                      );
                    },
                    child: Container(
                      width: 200,
                      height: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: Colors.grey.withOpacity(0.5),
                          width: 2,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Color and size animation
                  TweenAnimationBuilder<double>(
                    tween: Tween<double>(begin: 0, end: _progress),
                    duration: const Duration(seconds: 6),
                    curve: Curves.easeInOut,
                    builder: (context, progress, _) {
                      return TweenAnimationBuilder<Color?>(
                        tween: ColorTween(
                          begin: Colors.grey,
                          end: _color,
                        ),
                        duration: const Duration(seconds: 6),
                        builder: (context, color, _) {
                          return Container(
                            width: 150 + (progress * 50),
                            height: 150 + (progress * 50),
                            decoration: BoxDecoration(
                              color: color,
                              borderRadius: BorderRadius.circular(
                                20 + (progress * 20),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color:
                                      (color ?? Colors.grey).withOpacity(0.5),
                                  blurRadius: 10 + (progress * 10),
                                  spreadRadius: progress * 5,
                                ),
                              ],
                            ),
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.star,
                                    color: Colors.white,
                                    size: 30 + (progress * 30),
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    '${(progress * 100).toInt()}%',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16 + (progress * 8),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: _progress < 1.0 ? _updateProgress : null,
                    child: const Text('Animate'),
                  ),
                  const SizedBox(width: 20),
                  ElevatedButton(
                    onPressed: _progress > 0.0 ? _resetAnimation : null,
                    child: const Text('Reset'),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Text(
                'Progress: ${(_progress * 100).toInt()}%',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
