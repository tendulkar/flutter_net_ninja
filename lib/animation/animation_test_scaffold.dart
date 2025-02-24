import 'package:flutter/material.dart';
import 'ticker_scheduled_opacity_widget.dart';
import 'frame_scheduled_opacity_widget.dart';
import 'scheduled_opacity_widget.dart';

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
                Text('Timer-based Scheduler', style: TextStyle(fontSize: 20)),
                ScheduledOpacityWidget(),
                SizedBox(height: 40),
                Text('Frame-based Scheduler', style: TextStyle(fontSize: 20)),
                FrameScheduledOpacityWidget(),
                SizedBox(height: 20),
                Text('Ticker-based Scheduler', style: TextStyle(fontSize: 20)),
                TickerScheduledOpacityWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
