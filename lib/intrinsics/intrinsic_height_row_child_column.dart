import 'package:flutter/material.dart';

class IntrinsicHeightRowChildColumn2 extends StatelessWidget {
  const IntrinsicHeightRowChildColumn2({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text("Intrinsic Height Row Child Column")),
        body: Center(
          // child: IntrinsicHeight(
          child: Row(
            children: [
              Expanded(
                child: Container(
                  // Container(
                  color: Colors.red,
                  height: 100,
                  child: Text('Hello World', style: TextStyle(fontSize: 20)),
                  // child: Column(
                  //   children: [
                  //     Text("Hello World", style: TextStyle(fontSize: 20)),
                  //     Container(
                  //       color: Colors.red,
                  //       child: Text("Hello World",
                  //           style: TextStyle(fontSize: 20)),
                  //     ),
                  //   ],
                  // )
                  // )
                ),
              ),
              Expanded(
                  child: Container(
                      color: Colors.green,
                      child:
                          Text("Hello World", style: TextStyle(fontSize: 20)))),
              Expanded(
                child: Container(
                  color: Colors.blue,
                  child: Text("Hello World", style: TextStyle(fontSize: 20)),
                ),
              ),
            ],
          ),
          // ),
        ),
      ),
    );
  }
}

class IntrinsicHeightRowExample extends StatelessWidget {
  const IntrinsicHeightRowExample({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text("Intrinsic Height Row Child Column")),
        body: Center(
          child: IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Column(
                  children: [
                    Container(
                        color: Colors.red,
                        child: Text('Hello World',
                            style: TextStyle(fontSize: 20))),
                    Expanded(
                      child: Container(
                          color: Colors.redAccent,
                          child: Text('Hello World',
                              style: TextStyle(fontSize: 20))),
                    ),
                  ],
                ),
                Container(
                    color: Colors.green,
                    child: Text("Hello World", style: TextStyle(fontSize: 20))),
                Container(
                  color: Colors.blue,
                  child: Text("Hello World", style: TextStyle(fontSize: 20)),
                ),
              ],
            ),
            // ),
          ),
        ),
      ),
    );
  }
}
