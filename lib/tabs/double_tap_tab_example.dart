import 'package:flutter/material.dart';

// Learnings
// wrap widgets with GestureDetector to detect double tap and long press
// onDoubleTap: <Lambda function defintion>
// onLongPress: <Lambda function defintion>
class DoubleTapTabExampleApp extends StatefulWidget {
  const DoubleTapTabExampleApp({super.key});

  @override
  State<DoubleTapTabExampleApp> createState() => _DoubleTapTabExampleAppState();
}

class _DoubleTapTabExampleAppState extends State<DoubleTapTabExampleApp>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(icon: Icon(Icons.home), text: "Home"),
            Tab(icon: Icon(Icons.settings), text: "Settings"),
            Tab(icon: Icon(Icons.person), text: "Profile"),
          ],
        ),
        title: const Text('Double Tap Tab Example'),
      ),
      body: GestureDetector(
        onDoubleTap: () {
          _tabController.animateTo((_tabController.index + 1) % 3);
        },
        onLongPress: () {
          _tabController.animateTo((_tabController.index + 2) % 3);
        },
        child: TabBarView(
          controller: _tabController,
          children: const [
            Center(child: Text('Home')),
            Center(child: Text('Settings')),
            Center(child: Text('Profile')),
          ],
        ),
      ),
    ));
  }
}
