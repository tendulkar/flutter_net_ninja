import 'package:flutter/material.dart';

class CounterInheritedWidget extends InheritedWidget {
  const CounterInheritedWidget({
    super.key,
    required super.child,
    required this.counter,
    required this.onIncrement,
  });

  final int counter;
  final VoidCallback onIncrement;

  static CounterInheritedWidget of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<CounterInheritedWidget>()!;
  }

  @override
  bool updateShouldNotify(CounterInheritedWidget oldWidget) {
    return counter != oldWidget.counter;
  }
}

class InheritedCounterApp extends StatefulWidget {
  const InheritedCounterApp({super.key});

  @override
  State<InheritedCounterApp> createState() => _InheritedCounterAppState();
}

class _InheritedCounterAppState extends State<InheritedCounterApp> {
  int _counter = 0;

  void _increment() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return CounterInheritedWidget(
      counter: _counter,
      onIncrement: _increment,
      child: const SampleHomePage(),
    );
  }
}

class CounterDisplay extends StatelessWidget {
  const CounterDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(CounterInheritedWidget.of(context).counter.toString());
  }
}

class CounterButton extends StatelessWidget {
  const CounterButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        CounterInheritedWidget.of(context).onIncrement();
      },
      child: const Text('Increment'),
    );
  }
}

class SampleHomePage extends StatelessWidget {
  const SampleHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        title: const Text('Sample Counter'),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('You have pushed the button this many times:'),
            CounterDisplay(),
            CounterButton(),
          ],
        ),
      ),
    ));
  }
}
