import 'package:flutter/material.dart';

class SampleCounterApp extends StatelessWidget {
  const SampleCounterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sample Counter',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const SampleCounter(),
    );
  }
}

class SampleCounter extends StatefulWidget {
  const SampleCounter({super.key});

  @override
  State<SampleCounter> createState() => _SampleCounterState();
}

class _SampleCounterState extends State<SampleCounter> {
  int _counter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sample Counter')),
      body: Center(
        key: ValueKey<String>("$_counter"),
        child: Column(
          key: ValueKey<String>("$_counter"),
          mainAxisAlignment: _counter % 2 == 0
              ? MainAxisAlignment.start
              : MainAxisAlignment.center,
          children: [
            const Text('You have pushed the button this many times:'),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _counter++;
                });
              },
              child: const Text('Increment'),
            ),
          ],
        ),
      ),
    );
  }
}
