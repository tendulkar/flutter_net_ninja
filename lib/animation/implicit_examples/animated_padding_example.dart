import 'package:flutter/material.dart';

/// AnimatedPadding Example
/// 
/// AnimatedPadding smoothly animates changes in padding values.
/// It's useful when you want to:
/// - Create spacing animations
/// - Implement responsive padding
/// - Create squeeze/expand effects
///
/// Key Benefits:
/// 1. Simple way to animate EdgeInsets
/// 2. Great for responsive design
/// 3. Combines well with other animations
/// 4. Perfect for layout transitions

class AnimatedPaddingExample extends StatefulWidget {
  const AnimatedPaddingExample({super.key});

  @override
  State<AnimatedPaddingExample> createState() => _AnimatedPaddingExampleState();
}

class _AnimatedPaddingExampleState extends State<AnimatedPaddingExample> {
  double _paddingValue = 20.0;

  void _increasePadding() {
    setState(() {
      _paddingValue = (_paddingValue + 20.0).clamp(0.0, 100.0);
    });
  }

  void _decreasePadding() {
    setState(() {
      _paddingValue = (_paddingValue - 20.0).clamp(0.0, 100.0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('AnimatedPadding Example'),
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
                  borderRadius: BorderRadius.circular(10),
                ),
                child: AnimatedPadding(
                  // Padding value to animate
                  padding: EdgeInsets.all(_paddingValue),
                  
                  // Animation configuration
                  duration: const Duration(seconds: 1),
                  curve: Curves.easeInOut,
                  
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Content',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'Padding: ${_paddingValue.toStringAsFixed(1)}',
                            style: const TextStyle(
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
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: _paddingValue > 0 ? _decreasePadding : null,
                    child: const Text('Decrease Padding'),
                  ),
                  const SizedBox(width: 20),
                  ElevatedButton(
                    onPressed: _paddingValue < 100 ? _increasePadding : null,
                    child: const Text('Increase Padding'),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Text(
                'Current Padding: ${_paddingValue.toStringAsFixed(1)}',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
