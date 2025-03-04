import 'package:flutter/material.dart';

/// AnimatedSwitcher Example
///
/// AnimatedSwitcher provides a way to animate between different widgets.
/// Features:
/// - Smooth transitions between widgets
/// - Custom transition builders
/// - Duration and curve control
/// - Built-in fade transition
///
/// Key Benefits:
/// 1. Flexible widget transitions
/// 2. Multiple transition effects
/// 3. Handles widget replacement
/// 4. Perfect for dynamic content

class AnimatedSwitcherExample extends StatefulWidget {
  const AnimatedSwitcherExample({super.key});

  @override
  State<AnimatedSwitcherExample> createState() =>
      _AnimatedSwitcherExampleState();
}

class _AnimatedSwitcherExampleState extends State<AnimatedSwitcherExample> {
  int _count = 0;
  bool _showAlternate = false;

  void _incrementCounter() {
    setState(() {
      _count++;
    });
  }

  void _toggleWidget() {
    setState(() {
      _showAlternate = !_showAlternate;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('AnimatedSwitcher Example'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 300,
                height: 300,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Example 1: Number counter with scale transition
                      AnimatedSwitcher(
                        duration: const Duration(seconds: 2),
                        transitionBuilder:
                            (Widget child, Animation<double> animation) {
                          return ScaleTransition(
                            scale: animation,
                            child: child,
                          );
                        },
                        child: Text(
                          '$_count',
                          key: ValueKey<int>(_count),
                          style: Theme.of(context).textTheme.displayLarge,
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Example 2: Widget switching with custom transition
                      AnimatedSwitcher(
                        duration: const Duration(seconds: 2),
                        transitionBuilder:
                            (Widget child, Animation<double> animation) {
                          return FadeTransition(
                            opacity: animation,
                            child: SlideTransition(
                              position: Tween<Offset>(
                                begin: const Offset(0.0, 0.5),
                                end: Offset.zero,
                              ).animate(animation),
                              child: child,
                            ),
                          );
                        },
                        child: _showAlternate
                            ? Container(
                                key: const ValueKey<String>('alternate'),
                                width: 150,
                                height: 100,
                                decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: const Center(
                                  child: Icon(
                                    Icons.star,
                                    color: Colors.white,
                                    size: 50,
                                  ),
                                ),
                              )
                            : Container(
                                key: const ValueKey<String>('default'),
                                width: 100,
                                height: 100,
                                decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                child: const Center(
                                  child: Icon(
                                    Icons.favorite,
                                    color: Colors.white,
                                    size: 50,
                                  ),
                                ),
                              ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: _incrementCounter,
                    child: const Text('Increment'),
                  ),
                  const SizedBox(width: 20),
                  ElevatedButton(
                    onPressed: _toggleWidget,
                    child: const Text('Switch Widget'),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Text(
                'Counter: $_count\n'
                'Widget: ${_showAlternate ? "Alternate" : "Default"}',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
