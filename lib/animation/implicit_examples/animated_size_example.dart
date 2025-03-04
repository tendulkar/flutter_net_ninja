import 'package:flutter/material.dart';

/// AnimatedSize Example
/// 
/// AnimatedSize smoothly animates its child's size changes.
/// Features:
/// - Automatic size animations
/// - Works with any child widget
/// - Handles clipping
/// - Supports different alignment options
/// 
/// Key Benefits:
/// 1. Smooth size transitions
/// 2. Works with dynamic content
/// 3. Maintains child constraints
/// 4. Perfect for expandable widgets

class AnimatedSizeExample extends StatefulWidget {
  const AnimatedSizeExample({super.key});

  @override
  State<AnimatedSizeExample> createState() => _AnimatedSizeExampleState();
}

class _AnimatedSizeExampleState extends State<AnimatedSizeExample> {
  bool _isExpanded = false;
  bool _showMore = false;

  void _toggleSize() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }

  void _toggleContent() {
    setState(() {
      _showMore = !_showMore;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('AnimatedSize Example'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                constraints: const BoxConstraints(
                  maxWidth: 300,
                  maxHeight: 400,
                ),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: AnimatedSize(
                    // Animation duration
                    duration: const Duration(milliseconds: 500),
                    
                    // Animation curve
                    curve: Curves.easeInOut,
                    
                    // Alignment during size change
                    alignment: Alignment.topCenter,
                    
                    // The child whose size we're animating
                    child: Container(
                      width: _isExpanded ? 260 : 200,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            height: _isExpanded ? 200 : 100,
                            decoration: BoxDecoration(
                              color: Colors.blue[700],
                              borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(10),
                              ),
                            ),
                            child: Center(
                              child: Icon(
                                Icons.photo,
                                size: _isExpanded ? 80 : 40,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              children: [
                                const Text(
                                  'Animated Content',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  'This container smoothly animates its size changes.',
                                  style: TextStyle(
                                    color: Colors.white.withOpacity(0.9),
                                    fontSize: 14,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                if (_showMore) ...[
                                  const SizedBox(height: 10),
                                  Text(
                                    'AnimatedSize is perfect for expandable content '
                                    'and dynamic layouts that need smooth transitions.',
                                    style: TextStyle(
                                      color: Colors.white.withOpacity(0.9),
                                      fontSize: 14,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ],
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
                    onPressed: _toggleSize,
                    child: Text(
                      _isExpanded ? 'Make Smaller' : 'Make Larger',
                    ),
                  ),
                  const SizedBox(width: 20),
                  ElevatedButton(
                    onPressed: _toggleContent,
                    child: Text(
                      _showMore ? 'Show Less' : 'Show More',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Text(
                'Size: ${_isExpanded ? "Large" : "Small"}\n'
                'Content: ${_showMore ? "Expanded" : "Collapsed"}',
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
