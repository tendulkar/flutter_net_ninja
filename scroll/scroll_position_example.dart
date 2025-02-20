import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ScrollPositionExample(),
    );
  }
}

class ScrollPositionExample extends StatefulWidget {
  @override
  _ScrollPositionExampleState createState() => _ScrollPositionExampleState();
}

class _ScrollPositionExampleState extends State<ScrollPositionExample> {
  final ScrollController _scrollController = ScrollController();
  double _scrollOffset = 0.0;
  double _minScrollExtent = -1.0;
  double _maxScrollExtent = -1.0;
  String _scrollDirection = "<NA>";
  bool? _isAtEdge = null;
  bool? _outOfRange = null;

  @override
  void initState() {
    super.initState();
    
    _scrollController.addListener(() {
      setState(() {
        _scrollOffset = _scrollController.position.pixels; // Get current scroll position
        _minScrollExtent = _scrollController.position.minScrollExtent;
        _maxScrollExtent = _scrollController.position.maxScrollExtent;
        _scrollDirection = _scrollController.position.userScrollDirection.name;
        _isAtEdge = _scrollController.position.atEdge;
        _outOfRange = _scrollController.position.outOfRange;
      });
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Scroll Position Example")),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16),
            child: Text("Current Scroll Offset: $_scrollOffset, minScrollExtent: $_minScrollExtent, maxScrollExtent: $_maxScrollExtent, scroll direction: $_scrollDirection, at Edge: $_isAtEdge, out of range: $_outOfRange", style: TextStyle(fontSize: 18)),
          ),
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              itemCount: 100,
              itemBuilder: (context, index) => ListTile(title: Text("Item ${index + 1}")),
            ),
          ),
        ],
      ),
    );
  }
}
