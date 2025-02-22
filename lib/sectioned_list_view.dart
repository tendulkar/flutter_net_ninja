import 'package:flutter/material.dart';

// void main() {
//   runApp(MyApp());
// }

class SectionedListView extends StatelessWidget {
  final List<String> sections = ["A", "B", "C"];
  final Map<String, List<String>> items = {
    "A": ["Apple", "Avacado"],
    "B": ["Banana", "Blueberry"],
    "C": ["Cherry", "Coconut"],
  };

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: sections.length,
        itemBuilder: (context, index) {
          String section = sections[index];
          return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.all(8),
                  child: Text(
                    section,
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                  ),
                ),
                ...items[section]!
                    .map((item) => ListTile(title: Text(item)))
                    .toList(),
              ]);
        });
  }
}

class SectionedListApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("Sectioned ListView")),
        body: Center(
          child: SectionedListView(),
        ),
      ),
    );
  }
}
