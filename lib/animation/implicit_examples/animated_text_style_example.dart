import 'package:flutter/material.dart';

/// AnimatedDefaultTextStyle Example
///
/// AnimatedDefaultTextStyle smoothly animates changes in text style properties.
/// It can animate:
/// - fontSize
/// - fontWeight
/// - color
/// - letterSpacing
/// - wordSpacing
/// - textBaseline
/// - height
/// - locale
/// - foreground
/// - background
/// - shadows
/// - fontFeatures
///
/// Key Benefits:
/// 1. Animate any text style property
/// 2. Affects all descendant Text widgets
/// 3. Great for theme transitions
/// 4. Perfect for interactive text effects

class AnimatedTextStyleExample extends StatefulWidget {
  const AnimatedTextStyleExample({super.key});

  @override
  State<AnimatedTextStyleExample> createState() =>
      _AnimatedTextStyleExampleState();
}

class _AnimatedTextStyleExampleState extends State<AnimatedTextStyleExample> {
  bool _isLarge = false;
  bool _isColorful = false;

  void _toggleSize() {
    setState(() {
      _isLarge = !_isLarge;
    });
  }

  void _toggleColor() {
    setState(() {
      _isColorful = !_isColorful;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('AnimatedDefaultTextStyle Example'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 300,
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Center(
                  child: AnimatedDefaultTextStyle(
                    // Text style properties to animate
                    style: TextStyle(
                      fontSize: _isLarge ? 40.0 : 20.0,
                      fontWeight:
                          _isLarge ? FontWeight.bold : FontWeight.normal,
                      color: _isColorful ? Colors.green : Colors.blue,
                      letterSpacing: _isLarge ? 2.0 : 1.0,
                      shadows: _isLarge
                          ? [
                              Shadow(
                                color: Colors.black.withOpacity(0.3),
                                offset: const Offset(2, 2),
                                blurRadius: 4,
                              ),
                            ]
                          : null,
                    ),

                    // Animation configuration
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeInOut,

                    child: const Text('Animated Text'),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: _toggleSize,
                    child: Text(_isLarge ? 'Make Smaller' : 'Make Larger'),
                  ),
                  const SizedBox(width: 20),
                  ElevatedButton(
                    onPressed: _toggleColor,
                    child: Text(_isColorful ? 'Make Blue' : 'Make Green'),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              // Description of current state
              AnimatedDefaultTextStyle(
                style: TextStyle(
                  fontSize: 16,
                  color: _isColorful ? Colors.purple : Colors.blue,
                  fontWeight: _isLarge ? FontWeight.bold : FontWeight.normal,
                ),
                duration: const Duration(milliseconds: 500),
                child: Text(
                  'Size: ${_isLarge ? "Large" : "Small"}\n'
                  'Color: ${_isColorful ? "Purple" : "Blue"}',
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
