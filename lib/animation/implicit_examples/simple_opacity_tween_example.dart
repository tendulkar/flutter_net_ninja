import 'package:flutter/material.dart';

/// Simple Opacity Tween Example
///
/// This example demonstrates how to use [TweenAnimationBuilder] to create
/// smooth opacity transitions. The example fades a container between 50% and 100%
/// opacity over 6 seconds.
///
/// # Understanding TweenAnimationBuilder
///
/// [TweenAnimationBuilder] is a powerful widget that combines the simplicity of
/// implicit animations with the flexibility of explicit animations. Here's how it
/// compares to other animation approaches in Flutter:
///
/// ## 1. Comparison with AnimatedBuilder
///
/// [AnimatedBuilder] requires:
/// - Manual creation and disposal of [AnimationController]
/// - Explicit handling of animation lifecycle
/// - More boilerplate code
/// - Direct control over animation state
///
/// ```dart
/// // AnimatedBuilder example:
/// class MyAnimation extends StatefulWidget {
///   @override
///   State<MyAnimation> createState() => _MyAnimationState();
/// }
///
/// class _MyAnimationState extends State<MyAnimation>
///     with SingleTickerProviderStateMixin {
///   late AnimationController _controller;
///   late Animation<double> _animation;
///
///   @override
///   void initState() {
///     super.initState();
///     _controller = AnimationController(
///       duration: const Duration(seconds: 6),
///       vsync: this,
///     );
///     _animation = Tween<double>(begin: 0.5, end: 1.0).animate(_controller);
///     _controller.forward();
///   }
///
///   @override
///   void dispose() {
///     _controller.dispose();
///     super.dispose();
///   }
///
///   @override
///   Widget build(BuildContext context) {
///     return AnimatedBuilder(
///       animation: _animation,
///       builder: (context, child) {
///         return Opacity(opacity: _animation.value, child: child);
///       },
///     );
///   }
/// }
/// ```
///
/// ## 2. Comparison with ImplicitlyAnimatedWidget
///
/// [ImplicitlyAnimatedWidget] is:
/// - Limited to predefined widgets (AnimatedOpacity, AnimatedContainer, etc.)
/// - Requires creating custom classes for new animations
/// - Less flexible for complex animations
/// - Simpler for basic use cases
///
/// ```dart
/// // ImplicitlyAnimatedWidget example:
/// class CustomAnimatedOpacity extends ImplicitlyAnimatedWidget {
///   final double opacity;
///   final Widget child;
///
///   CustomAnimatedOpacity({
///     required this.opacity,
///     required this.child,
///     required Duration duration,
///   }) : super(duration: duration);
///
///   @override
///   ImplicitlyAnimatedWidgetState<ImplicitlyAnimatedWidget> createState() =>
///       _CustomAnimatedOpacityState();
/// }
///
/// class _CustomAnimatedOpacityState
///     extends AnimatedWidgetBaseState<CustomAnimatedOpacity> {
///   Tween<double>? _opacity;
///
///   @override
///   void forEachTween(TweenVisitor<dynamic> visitor) {
///     _opacity = visitor(
///       _opacity,
///       widget.opacity,
///       (value) => Tween<double>(begin: value),
///     ) as Tween<double>?;
///   }
///
///   @override
///   Widget build(BuildContext context) {
///     return Opacity(
///       opacity: _opacity!.evaluate(animation),
///       child: widget.child,
///     );
///   }
/// }
/// ```
///
/// ## 3. Advantages of TweenAnimationBuilder
///
/// [TweenAnimationBuilder] offers:
/// 1. **Simplicity**: No need to manage AnimationController
/// 2. **Flexibility**: Can animate any type that can be interpolated
/// 3. **Reusability**: Easy to extract and reuse animation logic
/// 4. **Performance**: Automatically handles animation lifecycle
/// 5. **Maintainability**: Less code, fewer potential bugs
///
/// ## When to Use Each
///
/// Use [TweenAnimationBuilder] when:
/// - You need a custom animation without complexity
/// - You want to animate non-standard properties
/// - You need more control than ImplicitlyAnimatedWidget
/// - You want to avoid AnimationController boilerplate
///
/// Use [AnimatedBuilder] when:
/// - You need precise control over the animation
/// - You want to share an AnimationController
/// - You're building complex, multi-part animations
/// - You need to manually control the animation state
///
/// Use [ImplicitlyAnimatedWidget] when:
/// - You're using standard widget properties
/// - You need the simplest possible animation
/// - You're building a reusable animated widget
/// - Performance is critical
///
/// This example demonstrates the simplicity and power of [TweenAnimationBuilder]
/// while maintaining the flexibility to create custom animations.

class SimpleOpacityTweenExample extends StatefulWidget {
  const SimpleOpacityTweenExample({super.key});

  @override
  State<SimpleOpacityTweenExample> createState() =>
      _SimpleOpacityTweenExampleState();
}

class _SimpleOpacityTweenExampleState extends State<SimpleOpacityTweenExample> {
  // Controls whether we're fading in (true) or out (false)
  bool _isFadingIn = true;

  void _toggleFade() {
    setState(() {
      _isFadingIn = !_isFadingIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Simple Opacity Tween'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Opacity animation using TweenAnimationBuilder
              TweenAnimationBuilder<double>(
                // Tween defines the interpolation from start to end value
                tween: Tween<double>(
                  begin:
                      0.5, // begin value is used only for first time, for next time onwards it'll use whatever is the current value.
                  end: _isFadingIn ? 1.0 : 0.5,
                ),
                // Animation duration
                duration: const Duration(seconds: 6),
                // Builder function called on each animation frame
                builder: (context, opacity, child) {
                  return Opacity(
                    opacity: opacity,
                    child: Container(
                      width: 300,
                      height: 200,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.blue.withOpacity(0.3),
                            blurRadius: 10,
                            spreadRadius: 5,
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Opacity: ${opacity.toStringAsFixed(2)}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            _isFadingIn ? 'Fading In' : 'Fading Out',
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 40),
              // Button to toggle fade direction
              ElevatedButton(
                onPressed: _toggleFade,
                child: Text(_isFadingIn ? 'Fade Out' : 'Fade In'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
