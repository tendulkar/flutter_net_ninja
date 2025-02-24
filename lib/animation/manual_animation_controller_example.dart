import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/scheduler.dart';

class FadeTransitionWidget extends AnimatedWidget {
  FadeTransitionWidget({required this.child, required this.opacity})
      : super(listenable: opacity);
  final Widget child;
  final Animation<double> opacity;
  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: opacity.value,
      child: child,
    );
  }
}

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
              style: TextStyle(color: Colors.white, fontSize: 24))),
    );
  }
}

class AnimationTestScaffold extends StatelessWidget {
  const AnimationTestScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Animation Examples'),
        ),
        body: const SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 20),
                // Text('Timer-based Scheduler', style: TextStyle(fontSize: 20)),
                // ScheduledOpacityWidget(),
                // SizedBox(height: 40),
                // Text('Frame-based Scheduler', style: TextStyle(fontSize: 20)),
                // FrameScheduledOpacityWidget(),
                // SizedBox(height: 20),
                // Text('Ticker-based Scheduler', style: TextStyle(fontSize: 20)),
                // TickerScheduledOpacityWidget(),
                // SizedBox(height: 20),
                TickerScheduledOpacityWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

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

class ScheduledOpacityWidget extends StatefulWidget {
  const ScheduledOpacityWidget({super.key});

  @override
  State<ScheduledOpacityWidget> createState() => _ScheduledOpacityWidgetState();
}

class _ScheduledOpacityWidgetState extends State<ScheduledOpacityWidget> {
  double _opacity = 0.5;
  Timer? _timer;
  bool _isSchedulerRunning = false;

  void _startScheduler() {
    setState(() {
      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        setState(() {
          _opacity += 0.1;
          if (_opacity >= 1.0) {
            _opacity = 1.0;
          }
        });
      });
      _isSchedulerRunning = true;
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
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
              "Scheduled opacity: ${_opacity.toStringAsFixed(2)}",
              style: const TextStyle(color: Colors.white, fontSize: 24),
            ),
          ),
        ),
        ElevatedButton(
          onPressed: _startScheduler,
          child: Text(
            _isSchedulerRunning ? "Sceduler Started!!!" : "Start Scheduler",
            style: const TextStyle(color: Colors.black, fontSize: 23),
          ),
        ),
      ],
    );
  }
}

class FrameScheduledOpacityWidget extends StatefulWidget {
  const FrameScheduledOpacityWidget({super.key});

  @override
  State<FrameScheduledOpacityWidget> createState() =>
      _FrameScheduledOpacityWidgetState();
}

class _FrameScheduledOpacityWidgetState
    extends State<FrameScheduledOpacityWidget>
    with SingleTickerProviderStateMixin {
  double _opacity = 0.5;
  bool _isSchedulerRunning = false;
  Duration _lastFrameTime = Duration.zero;
  int _frameCount = 0;

  // Constants for animation
  final double _startOpacity = 0.5;
  final double _endOpacity = 1.0;
  final Duration _totalDuration = const Duration(seconds: 6);

  void _startFrameScheduler() {
    if (_isSchedulerRunning) return;

    _isSchedulerRunning = true;
    _lastFrameTime = Duration.zero;
    _frameCount = 0;
    _opacity = _startOpacity;

    SchedulerBinding.instance.scheduleFrameCallback(_onFrame);
    setState(() {}); // Update button text
  }

  void _onFrame(Duration timeStamp) {
    if (!_isSchedulerRunning) return;

    _frameCount++;
    // Calculate elapsed time since last frame
    if (_lastFrameTime == Duration.zero) {
      _lastFrameTime = timeStamp;
      SchedulerBinding.instance.scheduleFrameCallback(_onFrame);
      return;
    }

    final elapsed = timeStamp - _lastFrameTime;

    // Calculate progress (0.0 to 1.0) based on elapsed time
    final progress = elapsed.inMicroseconds / _totalDuration.inMicroseconds;

    // Calculate new opacity value
    setState(() {
      _opacity = _startOpacity + (_endOpacity - _startOpacity) * progress;

      if (progress >= 1.0 || _opacity >= _endOpacity) {
        _opacity = _endOpacity;
        _isSchedulerRunning = false;
        return;
      }
    });

    // Schedule next frame
    SchedulerBinding.instance.scheduleFrameCallback(_onFrame);
  }

  @override
  void dispose() {
    _isSchedulerRunning = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final elapsedSeconds = _lastFrameTime == Duration.zero
        ? 0.0
        : (_opacity - _startOpacity) /
            (_endOpacity - _startOpacity) *
            _totalDuration.inMilliseconds /
            1000;

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
              "Container opacity: ${_opacity.toStringAsFixed(2)}\nFrame Count: $_frameCount\nElapsed: ${elapsedSeconds.toStringAsFixed(1)}s",
              style: const TextStyle(color: Colors.white, fontSize: 24),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        ElevatedButton(
          onPressed: _startFrameScheduler,
          child: Text(
            _isSchedulerRunning
                ? "Frame Scheduler Running!"
                : "Start Frame Scheduler",
            style: const TextStyle(color: Colors.black, fontSize: 23),
          ),
        ),
      ],
    );
  }
}

class TickerScheduledOpacityWidget extends StatefulWidget {
  const TickerScheduledOpacityWidget({super.key});

  @override
  State<TickerScheduledOpacityWidget> createState() =>
      _TickerScheduledOpacityWidgetState();
}

class _TickerScheduledOpacityWidgetState
    extends State<TickerScheduledOpacityWidget>
    with SingleTickerProviderStateMixin {
  double _opacity = 0.5;
  bool _isSchedulerRunning = false;
  late final Ticker _ticker;
  int _tickCount = 0;
  Duration _elapsedDuration = Duration.zero;

  // Constants for animation
  final double _startOpacity = 0.5;
  final double _endOpacity = 1.0;
  final Duration _totalDuration = const Duration(seconds: 6);

  @override
  void initState() {
    super.initState();
    _ticker = createTicker((elapsed) {
      _tickCount++;
      _elapsedDuration = elapsed;

      // Calculate progress (0.0 to 1.0) based on elapsed time
      final progress = elapsed.inMicroseconds / _totalDuration.inMicroseconds;

      setState(() {
        // Interpolate opacity between start and end values
        _opacity = _startOpacity + (_endOpacity - _startOpacity) * progress;

        if (progress >= 1.0 || _opacity >= _endOpacity) {
          _opacity = _endOpacity;
          _ticker.stop();
          _isSchedulerRunning = false;
        }
      });
    });
  }

  void _startTickerScheduler() {
    if (_isSchedulerRunning) return;

    setState(() {
      _isSchedulerRunning = true;
      _opacity = _startOpacity;
      _tickCount = 0;
      _elapsedDuration = Duration.zero;
      _ticker.start();
    });
  }

  @override
  void dispose() {
    _ticker.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Calculate progress as a percentage of total duration
    final elapsedSeconds = _elapsedDuration.inMilliseconds;

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
              "Container opacity: ${_opacity.toStringAsFixed(3)}\n"
              "Tick Count: $_tickCount\n"
              "Elapsed: ${(elapsedSeconds / 1000).toStringAsFixed(1)}s",
              style: const TextStyle(color: Colors.white, fontSize: 24),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        ElevatedButton(
          onPressed: _startTickerScheduler,
          child: Text(
            _isSchedulerRunning ? "Ticker Running!" : "Start Ticker",
            style: const TextStyle(color: Colors.black, fontSize: 23),
          ),
        ),
      ],
    );
  }
}
