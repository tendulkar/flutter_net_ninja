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
          key: ValueKey<int>(_counter),
          child: Column(
            key: ValueKey<int>(_counter),
            mainAxisAlignment: _counter % 2 == 0
                ? MainAxisAlignment.start
                : MainAxisAlignment.center,
            children: [
              const Text('You have pushed the button this many times:'),
              Text('$_counter', style: const TextStyle(fontSize: 30)),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _counter++;
                  });
                },
                child: const Text('Increment'),
              ),
            ],
          )),
    );
  }
}

class FastCounterWidget extends StatefulWidget {
  const FastCounterWidget({super.key});

  @override
  State<FastCounterWidget> createState() => _FastCounterWidgetState();
}

class _FastCounterWidgetState extends State<FastCounterWidget> {
  int _counter = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: _counter % 2 == 0
          ? MainAxisAlignment.start
          : MainAxisAlignment.center,
      children: [
        const Text('You have pushed the button this many times:'),
        Text(
          '$_counter',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        ElevatedButton(
          onPressed: () {
            setState(() {
              _counter++;
            });
          },
          child: const Text('Increment'),
        ),
      ],
    );
  }
}
