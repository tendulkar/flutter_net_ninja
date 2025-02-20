import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

void main() {
  runApp(MyApp());
}


class ScrollControllerExample extends StatefulWidget {
  @override
  _ScrollControllerExampleState createState() => _ScrollControllerExampleState();
}

class _ScrollControllerExampleState extends State<ScrollControllerExample> {
  ScrollController _controller = ScrollController();
  bool _isFabVisible = true;
  
  void _scrollToBottom() {
    _controller.animateTo(
      _controller.position.maxScrollExtent,
      duration: Duration(seconds: 1),
      curve: Curves.easeOut,
    );
  }
  
  
  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      if (_controller.position.userScrollDirection == ScrollDirection.reverse) {
        setState(() { _isFabVisible = false;});
      } else if (_controller.position.userScrollDirection == ScrollDirection.forward) {
        setState(() { _isFabVisible = true;});
      }
    });
  }
  
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Scroll example")),
      body: ListView.builder(
        controller: _controller,
        itemCount: 50,
        itemBuilder: (context, index) => ListTile(title: Text("Item ${index + 1}")),
      ),
      floatingActionButton: _isFabVisible ? FloatingActionButton(
        onPressed: _scrollToBottom,
        child: Icon(Icons.arrow_downward),
      ): null,
    );
  }
}

class InfiniteScrollExample extends StatefulWidget {
  @override
  _InfiniteScrollState createState() => _InfiniteScrollState();
}

class _InfiniteScrollState extends State<InfiniteScrollExample> {
  ScrollController _scrollController = ScrollController();
  List<int> items = List.generate(50, (index) => index + 1);
  
  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        setState(() {
          items.addAll(List.generate(15, (index) => items.length + index + 1));
        });
      }
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Infinite Scroll Example")),
      body: Center(
        child: ListView.builder(
          itemCount: items.length,
          controller: _scrollController,
          itemBuilder: (context, index) => ListTile(title: Text("Item ${items[index]}")),
        ),
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(),
      home: InfiniteScrollExample(),
    );
  }
}
