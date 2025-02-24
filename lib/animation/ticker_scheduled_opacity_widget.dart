import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

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
