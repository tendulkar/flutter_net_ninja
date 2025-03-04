import 'package:flutter/material.dart';

/// AnimatedPhysicalModel Example
///
/// AnimatedPhysicalModel provides a physical model animation that shows
/// how a material would look in the real world. It can animate:
/// - elevation
/// - color
/// - shadowColor
/// - borderRadius
///
/// Key Benefits:
/// 1. Realistic material elevation animations
/// 2. Built-in shadow calculations
/// 3. Smooth color transitions
/// 4. Perfect for card-like UI elements

class AnimatedPhysicalModelExample extends StatefulWidget {
  const AnimatedPhysicalModelExample({super.key});

  @override
  State<AnimatedPhysicalModelExample> createState() =>
      _AnimatedPhysicalModelExampleState();
}

class _AnimatedPhysicalModelExampleState
    extends State<AnimatedPhysicalModelExample> {
  bool _isElevated = false;
  bool _isRounded = false;

  void _toggleElevation() {
    setState(() {
      _isElevated = !_isElevated;
    });
  }

  void _toggleShape() {
    setState(() {
      _isRounded = !_isRounded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('AnimatedPhysicalModel Example'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedPhysicalModel(
                // Physical properties to animate
                elevation: _isElevated ? 20.0 : 0.0,
                color: _isElevated ? Colors.blue : Colors.grey,
                shadowColor: Colors.black,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(_isRounded ? 30.0 : 0.0),

                // Animation configuration
                duration: const Duration(seconds: 6),
                curve: Curves.easeInOut,

                child: Container(
                  width: 200,
                  height: 200,
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        _isElevated ? Icons.height : Icons.height_outlined,
                        color: Colors.white,
                        size: 50,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Elevation: ${_isElevated ? "High" : "None"}',
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: _toggleElevation,
                    child: Text(
                      _isElevated ? 'Lower' : 'Raise',
                    ),
                  ),
                  const SizedBox(width: 20),
                  ElevatedButton(
                    onPressed: _toggleShape,
                    child: Text(
                      _isRounded ? 'Make Square' : 'Make Round',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Text(
                'Current State:\n'
                'Elevation: ${_isElevated ? "20.0" : "0.0"}\n'
                'Shape: ${_isRounded ? "Rounded" : "Square"}',
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
