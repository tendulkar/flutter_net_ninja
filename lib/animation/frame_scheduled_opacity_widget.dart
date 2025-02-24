import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

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
