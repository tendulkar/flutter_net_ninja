import 'package:flutter/material.dart';

// void main() {
//   runApp(MyApp());
// }

class TestContainer extends StatelessWidget {
  final Color color;
  final String text;

  const TestContainer({super.key, required this.text, required this.color});

  @override
  Widget build(BuildContext context) {
    // learning colored box always takes max space
    return Center(
      child: Container(
        color: color,
        child: Center(
          child: Text(
            text,
            style: const TextStyle(fontSize: 24, color: Colors.white),
          ),
        ),
      ),
    );
  }
}

// we have controllers which are ChangeNotifiers
// They track some value (text, page, tab, scroll, animation state) and can notify the listeners
class PageControllerExample extends StatefulWidget {
  const PageControllerExample({super.key});

  @override
  _PageControllerState createState() => _PageControllerState();
}

class _PageControllerState extends State<PageControllerExample> {
  // learning
  // 1. put as controller in PageView
  // 2. use this controller to navigate, _pageController.animateToPage(...) method
  // 3. unlike TabController, this doesn't take care of buttons / trigger logic, call the method manually, based on event (button click, swipe...)
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _gotoPreviousPage() {
    if (_currentPage > 0) {
      _currentPage--;
    }
    _pageController.animateToPage(
      _currentPage,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  void _gotoNextPage() {
    if (_currentPage < 2) {
      _currentPage++;
    }
    _pageController.animateToPage(
      _currentPage,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: (index) {},
              children: [
                TestContainer(color: Colors.red, text: "Page 1"),
                TestContainer(color: Colors.green, text: "Page 2"),
                TestContainer(color: Colors.blue, text: "Page 3"),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          FloatingActionButton(
            onPressed: _gotoPreviousPage,
            child: const Icon(Icons.arrow_back),
          ),
          FloatingActionButton(
            onPressed: _gotoNextPage,
            child: const Icon(Icons.arrow_forward),
          ),
        ],
      ),
    );
  }
}

class ColumnListView extends StatelessWidget {
  const ColumnListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: 100,
            itemBuilder: (context, index) => Container(
              width: 100,
              height: 100,
              color: Colors.blue,
              child: Text(
                "Item ${index + 1}",
                style: const TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class PageViewApp extends StatelessWidget {
  const PageViewApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(),
      home: Scaffold(body: PageControllerExample()),
    );
  }
}
