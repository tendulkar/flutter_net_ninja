import 'package:flutter/material.dart';

class AnimatedBuilderOpacityExample extends StatefulWidget {
  const AnimatedBuilderOpacityExample({super.key});

  @override
  State<AnimatedBuilderOpacityExample> createState() =>
      _AnimatedBuilderOpacityExampleState();
}

class _AnimatedBuilderOpacityExampleState
    extends State<AnimatedBuilderOpacityExample>
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

    // Create animation with curved animation
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
          title: const Text('AnimatedBuilder Example'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Using AnimatedBuilder for more efficient rebuilds
              AnimatedBuilder(
                animation: _animation,
                // The child parameter is passed to the builder
                child: Container(
                  width: 400,
                  height: 400,
                  alignment: Alignment.center,
                  color: Colors.blueAccent,
                ),
                // Builder only rebuilds the opacity wrapper, not the entire container
                builder: (BuildContext context, Widget? child) {
                  return Opacity(
                    opacity: _animation.value,
                    child: child != null
                        ? Stack(
                            children: [
                              child,
                              Center(
                                child: Text(
                                  "AnimatedBuilder Example\n"
                                  "Opacity: ${_animation.value.toStringAsFixed(2)}\n"
                                  "Elapsed: ${(_elapsedDuration.inMilliseconds / 1000).toStringAsFixed(1)}s\n"
                                  "Status: ${_controller.status}",
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 24),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          )
                        : const SizedBox(),
                  );
                },
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

// A minimal implementation of opacity animation using AnimatedBuilder
//
// Key advantages over AnimatedWidget:
// 1. No need to create a separate widget class - everything in one place
// 2. Child widget optimization - static child is not rebuilt on every animation tick
// 3. More flexible - can animate multiple properties in a single builder
// 4. Easier composition - can wrap any existing widget without subclassing
// 5. Better separation - animation logic stays with the parent widget
class SimpleAnimatedBuilderOpacity extends StatefulWidget {
  const SimpleAnimatedBuilderOpacity({super.key});

  @override
  State<SimpleAnimatedBuilderOpacity> createState() =>
      _SimpleAnimatedBuilderOpacityState();
}

class _SimpleAnimatedBuilderOpacityState
    extends State<SimpleAnimatedBuilderOpacity>
    with SingleTickerProviderStateMixin {
  // Animation setup is identical to AnimatedWidget
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    // Controller setup same as AnimatedWidget
    _controller = AnimationController(
      duration: const Duration(seconds: 6),
      vsync: this,
    );

    // Animation configuration identical to AnimatedWidget
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
          title: const Text('Simple AnimatedBuilder Example'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Instead of creating a separate AnimatedWidget class,
              // we directly use AnimatedBuilder here
              AnimatedBuilder(
                animation: _animation,
                // Performance optimization: static child won't rebuild
                // In AnimatedWidget, the entire widget tree would rebuild
                child: Container(
                  width: 200,
                  height: 200,
                  color: Colors.blue,
                  child: const Center(
                    child: Text(
                      'Animated Opacity',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                ),
                // Only the builder function is called on animation ticks
                // More efficient than AnimatedWidget which rebuilds everything
                builder: (context, child) => Opacity(
                  opacity: _animation.value,
                  child: child,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Animation control identical to AnimatedWidget
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
