import 'package:flutter/material.dart';

/// AnimatedPositioned Example
///
/// AnimatedPositioned is used within a Stack to animate a widget's position.
/// It can animate:
/// - top, bottom, left, right positions
/// - width and height
///
/// Key Benefits:
/// 1. Perfect for layout animations within a Stack
/// 2. Great for sliding animations
/// 3. Can animate size and position simultaneously
/// 4. Useful for interactive UI elements

class AnimatedPositionedExample extends StatefulWidget {
  const AnimatedPositionedExample({super.key});

  @override
  State<AnimatedPositionedExample> createState() =>
      _AnimatedPositionedExampleState();
}

class _AnimatedPositionedExampleState extends State<AnimatedPositionedExample> {
  bool _isExpanded = false;

  void _togglePosition() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('AnimatedPositioned Example'),
        ),
        body: Center(
          child: Container(
            width: 300,
            height: 300,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                // Background
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),

                // Animated widget within stack
                AnimatedPositioned(
                  // Position and size values to animate
                  top: _isExpanded ? 20 : 120,
                  left: _isExpanded ? 20 : 120,
                  width: _isExpanded ? 260 : 60,
                  height: _isExpanded ? 260 : 60,

                  // Animation configuration
                  duration: const Duration(seconds: 6),
                  curve: Curves.easeInOut,

                  child: GestureDetector(
                    onTap: _togglePosition,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 10,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                      child: Center(
                        child: AnimatedSwitcher(
                          duration: const Duration(milliseconds: 500),
                          child: Text(
                            _isExpanded ? 'Tap to Shrink' : 'Tap to Expand',
                            key: ValueKey<bool>(_isExpanded),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
