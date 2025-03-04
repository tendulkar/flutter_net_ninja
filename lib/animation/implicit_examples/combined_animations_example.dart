import 'package:flutter/material.dart';
import 'dart:math' as math;

/// Combined Animations Example
///
/// This example demonstrates how to combine multiple implicit animations
/// to create complex, interactive UI components.
///
/// Animations Used:
/// - AnimatedContainer for card expansion
/// - AnimatedPositioned for menu items
/// - AnimatedOpacity for fade effects
/// - TweenAnimationBuilder for custom rotation
/// - AnimatedDefaultTextStyle for text effects
/// - AnimatedCrossFade for content switching
///
/// Key Benefits:
/// 1. Rich, layered animations
/// 2. Coordinated transitions
/// 3. Complex UI interactions
/// 4. Maintainable animation code

class CombinedAnimationsExample extends StatefulWidget {
  const CombinedAnimationsExample({super.key});

  @override
  State<CombinedAnimationsExample> createState() =>
      _CombinedAnimationsExampleState();
}

class _CombinedAnimationsExampleState extends State<CombinedAnimationsExample> {
  bool _isExpanded = false;
  bool _showDetails = false;
  double _rotation = 0;

  void _toggleCard() {
    setState(() {
      _isExpanded = !_isExpanded;
      _rotation += math.pi / 2; // 90 degrees
    });
  }

  void _toggleDetails() {
    setState(() {
      _showDetails = !_showDetails;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.light,
        ),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Combined Animations Example'),
        ),
        body: Center(
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Background container with size animation
              AnimatedContainer(
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInOut,
                width: _isExpanded ? 320 : 280,
                height: _isExpanded ? 500 : 200,
                decoration: BoxDecoration(
                  color: _isExpanded
                      ? Theme.of(context).colorScheme.primaryContainer
                      : Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: _isExpanded ? 20 : 10,
                      spreadRadius: _isExpanded ? 5 : 2,
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Stack(
                    children: [
                      // Header with rotation animation
                      Positioned(
                        top: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          height: 120,
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          child: Stack(
                            children: [
                              // Background pattern
                              ...List.generate(
                                5,
                                (index) => Positioned(
                                  top: -20 + (index * 30),
                                  left: -20 + (index * 30),
                                  child: TweenAnimationBuilder<double>(
                                    tween: Tween<double>(
                                      begin: 0,
                                      end: _rotation,
                                    ),
                                    duration: const Duration(milliseconds: 500),
                                    curve: Curves.easeInOut,
                                    builder: (context, value, child) {
                                      return Transform.rotate(
                                        angle: value,
                                        child: child,
                                      );
                                    },
                                    child: Container(
                                      width: 100,
                                      height: 100,
                                      decoration: BoxDecoration(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primaryContainer
                                            .withOpacity(0.2),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              // Header content
                              Center(
                                child: AnimatedDefaultTextStyle(
                                  duration: const Duration(milliseconds: 500),
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: _isExpanded ? 28 : 24,
                                    fontWeight: _isExpanded
                                        ? FontWeight.bold
                                        : FontWeight.normal,
                                    letterSpacing: _isExpanded ? 2 : 1,
                                  ),
                                  child: const Text('Interactive Card'),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      // Menu items with position animation
                      if (_isExpanded)
                        ...List.generate(
                          3,
                          (index) => AnimatedPositioned(
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeInOut,
                            top: 140 + (index * 80),
                            left: 20,
                            right: 20,
                            child: AnimatedOpacity(
                              duration: const Duration(milliseconds: 500),
                              opacity: _isExpanded ? 1 : 0,
                              child: Container(
                                height: 60,
                                decoration: BoxDecoration(
                                  color: Theme.of(context).colorScheme.surface,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.1),
                                      blurRadius: 5,
                                      spreadRadius: 1,
                                    ),
                                  ],
                                ),
                                child: Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    borderRadius: BorderRadius.circular(10),
                                    onTap: _toggleDetails,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 20,
                                      ),
                                      child: Row(
                                        children: [
                                          Icon(
                                            [
                                              Icons.star,
                                              Icons.favorite,
                                              Icons.notifications,
                                            ][index],
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary,
                                          ),
                                          const SizedBox(width: 15),
                                          Text(
                                            [
                                              'Feature One',
                                              'Feature Two',
                                              'Feature Three',
                                            ][index],
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleMedium,
                                          ),
                                          const Spacer(),
                                          Icon(
                                            Icons.chevron_right,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      // Details section with cross-fade
                      if (_isExpanded)
                        Positioned(
                          bottom: 20,
                          left: 20,
                          right: 20,
                          child: AnimatedCrossFade(
                            duration: const Duration(milliseconds: 500),
                            crossFadeState: _showDetails
                                ? CrossFadeState.showSecond
                                : CrossFadeState.showFirst,
                            firstChild: Container(
                              height: 80,
                              decoration: BoxDecoration(
                                color: Theme.of(context)
                                    .colorScheme
                                    .primaryContainer
                                    .withOpacity(0.5),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Center(
                                child: Text('Tap any item to see details'),
                              ),
                            ),
                            secondChild: Container(
                              height: 80,
                              decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.primary,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Center(
                                child: Text(
                                  'Feature Details Here',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
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
              // Floating action button with rotation
              Positioned(
                bottom: _isExpanded ? 10 : 10,
                right: 20,
                child: TweenAnimationBuilder<double>(
                  tween: Tween<double>(
                    begin: 0,
                    end: _rotation,
                  ),
                  duration: const Duration(milliseconds: 500),
                  builder: (context, value, child) {
                    return Transform.rotate(
                      angle: value,
                      child: child,
                    );
                  },
                  child: FloatingActionButton(
                    onPressed: _toggleCard,
                    child: Icon(
                      _isExpanded ? Icons.close : Icons.add,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
