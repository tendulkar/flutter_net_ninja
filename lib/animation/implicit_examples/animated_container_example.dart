import 'package:flutter/material.dart';

/// AnimatedContainer Example
///
/// AnimatedContainer is one of the most versatile implicit animations.
/// It can animate multiple properties simultaneously:
/// - width, height
/// - padding, margin
/// - decoration (color, border, shadow)
/// - transform
/// - alignment
///
/// Key Benefits:
/// 1. Animates multiple properties in a single widget
/// 2. Handles all property transitions automatically
/// 3. Great for responsive UI animations
/// 4. Perfect for state-based container modifications

class AnimatedContainerExample extends StatefulWidget {
  const AnimatedContainerExample({super.key});

  @override
  State<AnimatedContainerExample> createState() =>
      _AnimatedContainerExampleState();
}

class _AnimatedContainerExampleState extends State<AnimatedContainerExample> {
  bool _expanded = false;
  bool _hasDecoration = false;

  void _toggleContainer() {
    setState(() {
      _expanded = !_expanded;
      _hasDecoration = !_hasDecoration;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('AnimatedContainer Example'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // AnimatedContainer handles all property transitions
              AnimatedContainer(
                // Dimensions animation
                width: _expanded ? 300.0 : 200.0,
                height: _expanded ? 300.0 : 200.0,

                // Padding animation
                padding: _expanded
                    ? const EdgeInsets.all(30)
                    : const EdgeInsets.all(10),

                // Duration for all property animations
                duration: const Duration(seconds: 6),

                // Curve for smooth animation
                curve: Curves.easeInOut,

                // Decoration animation
                decoration: BoxDecoration(
                  color: _hasDecoration ? Colors.blue : Colors.green,
                  borderRadius: BorderRadius.circular(
                    _hasDecoration ? 50 : 0,
                  ),
                  boxShadow: _hasDecoration
                      ? [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            blurRadius: 20,
                            spreadRadius: 5,
                          )
                        ]
                      : null,
                ),

                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        _expanded ? 'Expanded!' : 'Normal',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Size: ${_expanded ? '300x300' : '200x200'}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _toggleContainer,
                child: Text(_expanded ? 'Shrink' : 'Expand'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
