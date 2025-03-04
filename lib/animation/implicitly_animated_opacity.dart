import 'package:flutter/material.dart';

// Example showing how to use ImplicitlyAnimatedWidget for opacity animation
//
// Key differences from explicit animations (AnimatedWidget/AnimatedBuilder):
// 1. No AnimationController needed - transitions are handled automatically
// 2. Animations trigger automatically when properties change
// 3. Simpler to use - just update values and let the widget handle animation
// 4. Great for state-driven animations where you just care about start/end states
class ImplicitlyAnimatedOpacityExample extends StatefulWidget {
  const ImplicitlyAnimatedOpacityExample({super.key});

  @override
  State<ImplicitlyAnimatedOpacityExample> createState() =>
      _ImplicitlyAnimatedOpacityExampleState();
}

class _ImplicitlyAnimatedOpacityExampleState
    extends State<ImplicitlyAnimatedOpacityExample> {
  // Just maintain the target opacity value
  // The animation between values happens automatically
  double _targetOpacity = 0.5;

  void _toggleOpacity() {
    setState(() {
      // Simply update the target value
      // ImplicitlyAnimatedWidget will handle the transition
      _targetOpacity = 1.0;
      // _targetOpacity == 0.5 ? 1.0 : 0.5;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Implicitly Animated Opacity Example'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Pass the current target opacity to our custom widget
              CustomImplicitlyAnimatedOpacity(
                opacity: _targetOpacity,
                duration: const Duration(seconds: 6),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _toggleOpacity,
                child: const Text('Toggle Opacity'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Custom ImplicitlyAnimatedWidget for opacity animation
//
// Benefits of ImplicitlyAnimatedWidget:
// 1. Handles animation lifecycle automatically
// 2. No need to manage AnimationController
// 3. Need to configurate duration and curve, and pass it to super constructor
// 4. Need to create state to manage value ranges
// 5. Great for state-driven animations where you just care about start/end states
class CustomImplicitlyAnimatedOpacity extends ImplicitlyAnimatedWidget {
  // The target opacity value we want to animate to
  final double opacity;

  const CustomImplicitlyAnimatedOpacity({
    super.key,
    required this.opacity,
    required Duration duration,
    Curve curve = Curves.easeInOut,
  }) : super(duration: duration, curve: curve);

  @override
  ImplicitlyAnimatedWidgetState<CustomImplicitlyAnimatedOpacity>
      createState() => _CustomImplicitlyAnimatedOpacityState();
}

class _CustomImplicitlyAnimatedOpacityState
    extends ImplicitlyAnimatedWidgetState<CustomImplicitlyAnimatedOpacity> {
  // Tween to manage the opacity animation
  Tween<double>? _opacityTween;
  late Animation<double> _opacityAnimation;

  // Called when the target opacity value changes, during setState()
  // Core of ImplicitlyAnimatedWidget
  // Needs to create/update the value range using tween
  @override
  void forEachTween(TweenVisitor<dynamic> visitor) {
    _opacityTween = visitor(
      _opacityTween,
      widget.opacity,
      (dynamic value) => Tween<double>(begin: value as double),
    ) as Tween<double>?;
  }

  // Called when the tween is created, during setState(), after forEachTween()
  // Built animation can be be used as `Animation` object in AnimatedBuilder/AnimatedWidget
  @override
  void didUpdateTweens() {
    _opacityAnimation = animation.drive(_opacityTween!);
  }

  // Build method uses the animated value from the tween
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _opacityAnimation,
        builder: (context, child) {
          return Opacity(
              opacity: _opacityAnimation.value,
              child: Container(
                width: 200,
                height: 200,
                color: Colors.blue,
                child: Center(
                  child: Column(
                    spacing: 20,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Implicitly Animated',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      Text(
                        'Target Opacity: ${widget.opacity.toStringAsFixed(2)}',
                        style:
                            const TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      Text(
                        'Opacity: ${(_opacityAnimation.value).toStringAsFixed(2)}',
                        style:
                            const TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ],
                  ),
                ),
              ));
        });
  }
}

// Comparing AnimatedWidget vs ImplicitlyAnimatedWidget:
//
// 1. Animation Control:
//    AnimatedWidget:
//    - Requires explicit AnimationController
//    - You control when and how the animation runs
//    - More control but more complexity
//
//    ImplicitlyAnimatedWidget:
//    - No AnimationController needed
//    - Animation runs automatically when properties change
//    - Less control but simpler to use
//
// 2. State Management:
//    AnimatedWidget:
//    - Stateless widget that rebuilds with animation
//    - Animation state managed externally
//    - Good for custom animations with complex timing
//
//    ImplicitlyAnimatedWidget:
//    - Manages its own animation state
//    - Only needs target values
//    - Perfect for state-driven animations
//
// 3. Use Cases:
//    AnimatedWidget:
//    - Complex animations with custom timing
//    - Animations that need external control
//    - Coordinated animations
//
//    ImplicitlyAnimatedWidget:
//    - Simple transitions between states
//    - UI responses to data changes
//    - Automatic animations
//
// 4. Code Structure:
//    AnimatedWidget:
//    - Requires animation setup code
//    - Needs controller management
//    - More verbose implementation
//
//    ImplicitlyAnimatedWidget:
//    - Simpler implementation
//    - Built-in animation management
//    - Focus on state transitions
class SimpleImplicitOpacityExample extends StatefulWidget {
  const SimpleImplicitOpacityExample({super.key});

  @override
  State<SimpleImplicitOpacityExample> createState() =>
      _SimpleImplicitOpacityExampleState();
}

class _SimpleImplicitOpacityExampleState
    extends State<SimpleImplicitOpacityExample> {
  double _opacity = 0.5;

  void _toggleOpacity() {
    setState(() {
      _opacity = 1.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Simple Implicit Animation Example'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Using our custom ImplicitlyAnimatedWidget
              CustomImplicitlyAnimatedOpacity(
                opacity: _opacity,
                duration: const Duration(seconds: 6),
                curve: Curves.easeInOut,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _toggleOpacity,
                child: const Text('Increase Opacity'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
