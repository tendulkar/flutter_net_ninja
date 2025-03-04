import 'package:flutter/material.dart';

// Example using AnimatedOpacity - Flutter's built-in implicit animation widget
//
// Key benefits of AnimatedOpacity:
// 1. Simplest approach - no animation controller or custom widget needed
// 2. Automatic animation between opacity values
// 3. Built-in performance optimizations
// 4. Great for most common opacity animation use cases
//
// When to use AnimatedOpacity vs other approaches:
//
// AnimatedOpacity:
// - Simple opacity transitions
// - Quick to implement
// - No custom animation logic needed
// - Standard duration/curve animations
//
// AnimatedBuilder:
// - Complex animations with multiple properties
// - Custom animation logic
// - Need to optimize child rebuilds
// - Manual control over animation
//
// AnimatedWidget:
// - Reusable animated widgets
// - Custom animation behaviors
// - Animation logic tied to widget
// - Need animation state
//
// ImplicitlyAnimatedWidget:
// - Custom implicit animations
// - Complex state transitions
// - Need to animate multiple properties
// - Custom animation behaviors

class AnimatedOpacityExample extends StatefulWidget {
  const AnimatedOpacityExample({super.key});

  @override
  State<AnimatedOpacityExample> createState() => _AnimatedOpacityExampleState();
}

class _AnimatedOpacityExampleState extends State<AnimatedOpacityExample> {
  // Just store the current opacity value
  // AnimatedOpacity handles the transition automatically
  double _opacity = 0.5;

  void _increaseOpacity() {
    setState(() {
      // Increase opacity by 0.5, capped at 1.0
      _opacity = (_opacity + 0.5).clamp(0.0, 1.0);
    });
  }

  void _decreaseOpacity() {
    setState(() {
      // Decrease opacity by 0.5, capped at 0.0
      _opacity = (_opacity - 0.5).clamp(0.0, 1.0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('AnimatedOpacity Example'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // AnimatedOpacity automatically handles the transition
              // when opacity value changes
              AnimatedOpacity(
                // Current opacity value
                opacity: _opacity,
                // Duration of the animation
                duration: const Duration(seconds: 6),
                // Curve for smooth animation
                curve: Curves.easeInOut,
                // Child widget to animate
                child: Container(
                  width: 250,
                  height: 250,
                  color: Colors.blue,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Fade Me',
                          style: TextStyle(color: Colors.white, fontSize: 24),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          "Target Opacity: ${_opacity.toStringAsFixed(2)}\n(Can't read animated opacity)",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: _opacity > 0.0 ? _decreaseOpacity : null,
                    child: const Text('Decrease Opacity'),
                  ),
                  const SizedBox(width: 20),
                  ElevatedButton(
                    onPressed: _opacity < 1.0 ? _increaseOpacity : null,
                    child: const Text('Increase Opacity'),
                  ),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
