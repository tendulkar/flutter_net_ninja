import 'package:flutter/material.dart';

class TabsWithVerticalSwipeApp2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.home)),
              Tab(icon: Icon(Icons.settings)),
              Tab(icon: Icon(Icons.person)),
            ],
          ),
          title: const Text('Tabs with Vertical Swipe'),
        ),
        body: const TabBarView(
          children: [
            Center(child: Text('Home')),
            Center(child: Text('Settings')),
            Center(child: Text('Profile')),
          ],
        ),
      ),
    ));
  }
}

class TabsWithVerticalSwipeApp extends StatefulWidget {
  @override
  _TabBarViewWithVerticalSwipeState createState() =>
      _TabBarViewWithVerticalSwipeState();
}

class _TabBarViewWithVerticalSwipeState extends State<TabsWithVerticalSwipeApp>
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
            Tab(icon: Icon(Icons.home)),
            Tab(icon: Icon(Icons.settings)),
            Tab(icon: Icon(Icons.person)),
          ],
        ),
        title: const Text('Tabs with Vertical Swipe'),
      ),
      body: GestureDetector(
        onVerticalDragUpdate: (details) {
          print("Vertical drag happend: ${details.toString()}");
          if (details.delta.dy < -10) {
            // Swipe down
            _tabController.animateTo(_tabController.index - 1);
            print("Swipe down detected");
          } else if (details.delta.dy > 10) {
            // Swipe up
            _tabController.animateTo(_tabController.index + 1);
            print("Swipe up detected");
          }
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
