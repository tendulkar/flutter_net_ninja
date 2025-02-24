import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class TickerBasedOpacityApp extends StatelessWidget {
  const TickerBasedOpacityApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Ticker Based Opacity'),
        ),
        body: const Center(
          child: TickerScheduledOpacityWidget(),
        ),
      ),
    );
  }
}

class TickerScheduledOpacityWidget extends StatefulWidget {
  const TickerScheduledOpacityWidget({super.key});

  @override
  State<TickerScheduledOpacityWidget> createState() =>
      _TickerScheduledOpacityWidgetState();
}

class _TickerScheduledOpacityWidgetState extends State<TickerScheduledOpacityWidget>
    with SingleTickerProviderStateMixin {
  double _opacity = 0.5;
  bool _isSchedulerRunning = false;
  late final Ticker _ticker;
  int _tickCount = 0;
  Duration _elapsedTime = Duration.zero;

  @override
  void initState() {
    super.initState();
    _ticker = createTicker((elapsed) {
      _elapsedTime = elapsed;
      _tickCount++;

      // Update opacity every 60 ticks (approximately 1 second at 60fps)
      if (_tickCount >= 60) {
        setState(() {
          _opacity += 0.1;
          if (_opacity >= 1.0) {
            _opacity = 1.0;
            _ticker.stop();
            _isSchedulerRunning = false;
          }
        });
        _tickCount = 0;
      }
    });
  }

  void _startTickerScheduler() {
    if (_isSchedulerRunning) return;

    setState(() {
      _isSchedulerRunning = true;
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
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Opacity(
          opacity: _opacity,
          child: Container(
            width: 300,
            height: 300,
            alignment: Alignment.center,
            color: Colors.blueAccent,
            child: Text(
              "Ticker Scheduled opacity: ${_opacity.toStringAsFixed(2)}\nElapsed: ${(_elapsedTime.inMilliseconds / 1000).toStringAsFixed(1)}s\nTick Count: $_tickCount",
              style: const TextStyle(color: Colors.white, fontSize: 24),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        const SizedBox(height: 20),
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
