import 'package:flutter/material.dart';

/// AnimatedAlign Example
///
/// AnimatedAlign smoothly animates changes in alignment.
/// Use cases include:
/// - Moving widgets within their parent
/// - Creating UI transitions
/// - Building interactive layouts
///
/// Key Benefits:
/// 1. Simple way to animate widget position
/// 2. Works with parent's constraints
/// 3. Great for responsive layouts
/// 4. Maintains widget size during animation

class AnimatedAlignExample extends StatefulWidget {
  const AnimatedAlignExample({super.key});

  @override
  State<AnimatedAlignExample> createState() => _AnimatedAlignExampleState();
}

class _AnimatedAlignExampleState extends State<AnimatedAlignExample> {
  Alignment _alignment = Alignment.center;
  int _alignmentIndex = 0;

  // List of alignments to cycle through
  final List<(Alignment, String)> _alignments = [
    (Alignment.center, 'Center'),
    (Alignment.topLeft, 'Top Left'),
    (Alignment.topRight, 'Top Right'),
    (Alignment.bottomLeft, 'Bottom Left'),
    (Alignment.bottomRight, 'Bottom Right'),
  ];

  void _changeAlignment() {
    setState(() {
      _alignmentIndex = (_alignmentIndex + 1) % _alignments.length;
      _alignment = _alignments[_alignmentIndex].$1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('AnimatedAlign Example'),
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
                child: AnimatedAlign(
                  // Alignment value to animate
                  alignment: _alignment,

                  // Animation configuration
                  duration: const Duration(seconds: 1),
                  curve: Curves.easeInOut,

                  child: Container(
                    width: 100,
                    height: 100,
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
                    child: const Center(
                      child: Icon(
                        Icons.star,
                        color: Colors.white,
                        size: 50,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _changeAlignment,
                child: const Text('Change Position'),
              ),
              const SizedBox(height: 20),
              Text(
                'Current Position: ${_alignments[_alignmentIndex].$2}',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
