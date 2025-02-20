import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TweenAnimationExample(),
    );
  }
}

class TweenAnimationExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Tween Animation")),
      body: ListView.builder(
        itemCount: 100,
        itemBuilder: (context, index) {
          return TweenAnimationBuilder<double>(
            tween: Tween(begin: 0, end: 1),
            duration: Duration(milliseconds: 1000 + (index * 500)),
            builder: (context, value, child) => Opacity(opacity: value, child: child),
            child: ListTile(title: Text("Item ${index + 1}")),
          );
        }
      ),
    );
  }
}
