import 'package:flutter/material.dart';

class IntrinsicHeightRowChildColumn extends StatelessWidget {
  const IntrinsicHeightRowChildColumn({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text("Intrinsic Height Row Child Column")),
        body: Center(
          child: IntrinsicHeight(
            child: Row(
              children: [
                Expanded(child: Container(
                  color: Colors.red,
                  child: Column(
                    children: [
                      Text("Hello World", 
                      style: TextStyle(fontSize: 20)
                      ),
                      Expanded(
                        child: Container(
                          color: Colors.red,
                          child: Text("Hello World",  
                            style: TextStyle(fontSize: 20)
                            ),
                        ),
                      ),
                  ],
                  ))
                ),
                // Expanded(child: 
                Container(
                  color: Colors.green,
                  child: Text("Hello World", 
                  style: TextStyle(fontSize: 20)
                  ))
                // ),
                ,
                // Expanded(child: 
                Container(
                  color: Colors.blue,
                  child: Text("Hello World", 
                  style: TextStyle(fontSize: 20)
                  )
                  // )
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}