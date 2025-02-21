import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('KeepAliveNotification Example')),
        body: ListView.builder(
          itemCount: 90,
          itemBuilder: (context, index) => MyKeepAliveWidget(index: index),
        ),
      ),
    );
  }
}


class MyKeepAliveWidget extends StatefulWidget {
  final int index;
  MyKeepAliveWidget({required this.index});

  @override
  _MyKeepAliveWidgetState createState() => _MyKeepAliveWidgetState();
}

class _MyKeepAliveWidgetState extends State<MyKeepAliveWidget> 
  with AutomaticKeepAliveClientMixin {
  int counter = 0;

  @override
  bool get wantKeepAlive => true; // Indicate we want to be kept alive

  @override
  Widget build(BuildContext context) {
    super.build(context); // Need to call super.build in mixin
    return ListTile(
      title: Text('Item ${widget.index + 1}, Count: $counter'),
      trailing: ElevatedButton(
        onPressed: () {
          setState(() {
            counter++;
          });
        },
        child: Text('Increment'),
      ),
    );
  }
}
