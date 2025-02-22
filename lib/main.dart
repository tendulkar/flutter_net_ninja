import 'package:flutter/material.dart';
import './flutter_grid_layout_example.dart';
import './page_view_example.dart';
import './sectioned_list_view.dart';
import './scroll/keep_alive_scroll.dart';
import './scroll/scroll_controller_example.dart';
import './sliver_list_grid_example.dart';
import './scroll/scroll_position_example.dart';
import './tabs/swipe_tab_change.dart';
import './tabs/double_tap_tab_example.dart';

void main() {
  runApp(const DoubleTapTabExampleApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Examples',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Examples'),
      ),
      body: const SafeArea(
        child: Center(
          child: Text('Welcome to Flutter Examples'),
        ),
      ),
    );
  }
}
