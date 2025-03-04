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

  SectionedListView({super.key});

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
                  padding: const EdgeInsets.all(8),
                  child: Text(
                    section,
                    style: const TextStyle(
                        fontSize: 32, fontWeight: FontWeight.bold),
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
  const SectionedListApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text("Sectioned ListView")),
        body: Center(
          child: SectionedListView(),
        ),
      ),
    );
  }
}
