import 'package:flutter/material.dart';

/// AnimatedCrossFade Example
///
/// AnimatedCrossFade smoothly transitions between two children with a fade effect.
/// Features:
/// - Fade between two widgets
/// - Size transition handling
/// - Multiple cross-fade types
/// - Built-in curves
///
/// Key Benefits:
/// 1. Smooth transitions between states
/// 2. Handles both fade and size
/// 3. Multiple transition types
/// 4. Perfect for content switches

class AnimatedCrossFadeExample extends StatefulWidget {
  const AnimatedCrossFadeExample({super.key});

  @override
  State<AnimatedCrossFadeExample> createState() =>
      _AnimatedCrossFadeExampleState();
}

class _AnimatedCrossFadeExampleState extends State<AnimatedCrossFadeExample> {
  bool _showFirst = true;
  CrossFadeState get _crossFadeState =>
      _showFirst ? CrossFadeState.showFirst : CrossFadeState.showSecond;

  void _toggleChild() {
    setState(() {
      _showFirst = !_showFirst;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('AnimatedCrossFade Example'),
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
                  child: AnimatedCrossFade(
                    // Current state to show
                    crossFadeState: _crossFadeState,

                    // Animation duration
                    duration: const Duration(milliseconds: 6000),

                    // Fade and size curves
                    firstCurve: Curves.easeInOut,
                    secondCurve: Curves.easeInOut,
                    sizeCurve: Curves.easeInOut,

                    // How to align the children
                    alignment: Alignment.center,

                    // First child (shown when showFirst is true)
                    firstChild: Container(
                      width: 200,
                      height: 200,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: const Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.sunny,
                              color: Colors.white,
                              size: 50,
                            ),
                            SizedBox(height: 10),
                            Text(
                              'First Child',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    // Second child (shown when showFirst is false)
                    secondChild: Container(
                      width: 150,
                      height: 150,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: const Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.star,
                              color: Colors.white,
                              size: 40,
                            ),
                            SizedBox(height: 10),
                            Text(
                              'Second Child',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _toggleChild,
                child: Text(_showFirst ? 'Show Second' : 'Show First'),
              ),
              const SizedBox(height: 20),
              Text(
                'Currently Showing: ${_showFirst ? "First" : "Second"} Child',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const Text(
                'Notice how both size and opacity animate smoothly',
                style: TextStyle(color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
