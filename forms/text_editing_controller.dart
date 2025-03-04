import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

// we have controllers which are ChangeNotifiers
// They track some value (text, page, tab, scroll, animation state) and can notify the listeners

class TextControllerExampleWidget extends StatefulWidget {
  const TextControllerExampleWidget({super.key});

  @override
  _TextControllerExampleState createState() => _TextControllerExampleState();
}

class _TextControllerExampleState extends State<TextControllerExampleWidget> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: _controller,
          decoration: const InputDecoration(labelText: "Enter text"),
        ),
        const SizedBox(height: 10),
        ElevatedButton(
          onPressed: () {
            print("Button clicked! text: ${_controller.text}");
          },
          child: const Text("Button"),
        )
      ],
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(body: Center(child: TextControllerExampleWidget())),
    );
  }
}
