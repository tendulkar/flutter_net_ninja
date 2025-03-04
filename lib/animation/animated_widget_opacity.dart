import 'package:flutter/material.dart';

// Detailed implementation with elapsed time tracking
class AnimatedWidgetOpacityExample extends StatefulWidget {
  const AnimatedWidgetOpacityExample({super.key});

  @override
  State<AnimatedWidgetOpacityExample> createState() =>
      _AnimatedWidgetOpacityExampleState();
}

class _AnimatedWidgetOpacityExampleState
    extends State<AnimatedWidgetOpacityExample>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;
  Duration _elapsedDuration = Duration.zero;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 6),
      vsync: this,
    );

    _animation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.linear,
      ),
    );

    // Listen to animation status changes
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _elapsedDuration = _controller.duration!;
      } else if (status == AnimationStatus.dismissed) {
        _elapsedDuration = Duration.zero;
      }
      setState(() {}); // Update elapsed time display
    });

    // Listen to animation progress for elapsed time
    _controller.addListener(() {
      if (_controller.isAnimating) {
        setState(() {
          if (_controller.status == AnimationStatus.forward) {
            _elapsedDuration = _controller.lastElapsedDuration ?? Duration.zero;
          } else if (_controller.status == AnimationStatus.reverse) {
            _elapsedDuration = _controller.duration! -
                (_controller.lastElapsedDuration ?? Duration.zero);
          }
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('AnimatedWidget Example'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DetailedOpacityWidget(
                animation: _animation,
                elapsedDuration: _elapsedDuration,
                controllerStatus: _controller.status,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  _controller.forward();
                },
                child: const Text('Start Animation'),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  _controller.reverse();
                },
                child: const Text('Reverse Animation'),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _elapsedDuration = Duration.zero;
                    _controller.reset();
                  });
                },
                child: const Text('Reset Animation'),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  _controller.stop();
                  _controller.dispose();
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

// Detailed AnimatedWidget implementation
class DetailedOpacityWidget extends AnimatedWidget {
  final Duration elapsedDuration;
  final AnimationStatus controllerStatus;

  const DetailedOpacityWidget({
    super.key,
    required Animation<double> animation,
    required this.elapsedDuration,
    required this.controllerStatus,
  }) : super(listenable: animation);

  @override
  Widget build(BuildContext context) {
    final animation = listenable as Animation<double>;
    return Opacity(
      opacity: animation.value,
      child: Container(
        width: 400,
        height: 400,
        alignment: Alignment.center,
        color: Colors.blueAccent,
        child: Text(
          "AnimatedWidget Example\n"
          "Opacity: ${animation.value.toStringAsFixed(2)}\n"
          "Elapsed: ${(elapsedDuration.inMilliseconds / 1000).toStringAsFixed(1)}s\n"
          "Status: $controllerStatus",
          style: const TextStyle(color: Colors.white, fontSize: 24),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

// AnimatedWidget approach for opacity animation
//
// Key differences from manual AnimationController usage:
// 1. No need for manual setState() calls when animation value changes
// 2. Animation logic is encapsulated in a reusable widget
// 3. Widget rebuilds automatically when animation ticks
// 4. Cleaner separation between animation setup and UI updates
class SimpleAnimatedWidgetOpacity extends StatefulWidget {
  const SimpleAnimatedWidgetOpacity({super.key});

  @override
  State<SimpleAnimatedWidgetOpacity> createState() =>
      _SimpleAnimatedWidgetOpacityState();
}

class _SimpleAnimatedWidgetOpacityState
    extends State<SimpleAnimatedWidgetOpacity>
    with SingleTickerProviderStateMixin {
  // AnimationController is still needed to drive the animation
  // This is common between both approaches
  late final AnimationController _controller;

  // Animation<double> defines how the value changes over time
  // In manual approach, we would need to listen to this directly
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    // Controller setup is same as manual approach
    _controller = AnimationController(
      duration: const Duration(seconds: 6),
      vsync: this,
    );

    // Animation setup is same as manual approach
    // The difference is we won't need to manually listen to value changes
    _animation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Simple AnimatedWidget Example'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Instead of manually listening to animation changes and calling setState,
              // we pass the animation to AnimatedWidget which handles updates automatically
              SimpleOpacityWidget(animation: _animation),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Controller methods remain the same as manual approach
                  ElevatedButton(
                    onPressed: () => _controller.forward(),
                    child: const Text('Fade In'),
                  ),
                  const SizedBox(width: 20),
                  ElevatedButton(
                    onPressed: () => _controller.reverse(),
                    child: const Text('Fade Out'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Custom AnimatedWidget that handles the opacity animation
//
// Benefits over manual AnimationController approach:
// 1. No need to add animation listeners manually
// 2. No need to call setState() when animation value changes
// 3. Animation value updates are handled automatically
// 4. Widget code focuses purely on building UI with current value
// 5. No need to have StatefulWidget along with State defined for this.
class SimpleOpacityWidget extends AnimatedWidget {
  // Animation is passed to super as listenable
  // In manual approach, we would need to add listeners to this animation
  const SimpleOpacityWidget({
    super.key,
    required Animation<double> animation,
  }) : super(listenable: animation);

  @override
  Widget build(BuildContext context) {
    // Get current animation value - no listener needed
    // In manual approach, we would need an animation listener
    // to trigger setState when this value changes
    final animation = listenable as Animation<double>;

    // Build UI with current animation value
    // This method is called automatically when animation ticks
    return Opacity(
      opacity: animation.value,
      child: Container(
        width: 200,
        height: 200,
        color: Colors.blue,
        child: Center(
          child: Text(
            'Opacity: ${animation.value.toStringAsFixed(2)}',
            style: const TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
      ),
    );
  }
}
