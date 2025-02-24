import 'package:flutter/material.dart';
import 'dart:async';

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
