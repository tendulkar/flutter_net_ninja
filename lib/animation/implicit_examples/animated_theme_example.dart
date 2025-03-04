import 'package:flutter/material.dart';

/// AnimatedTheme Example
///
/// AnimatedTheme smoothly animates between different ThemeData objects.
/// It can animate all theme properties including:
/// - Colors
/// - Text styles
/// - Icon themes
/// - Material properties
///
/// Key Benefits:
/// 1. Smooth theme transitions
/// 2. Affects entire widget subtree
/// 3. Perfect for dark/light mode transitions
/// 4. Handles complex theme changes

class AnimatedThemeExample extends StatefulWidget {
  const AnimatedThemeExample({super.key});

  @override
  State<AnimatedThemeExample> createState() => _AnimatedThemeExampleState();
}

class _AnimatedThemeExampleState extends State<AnimatedThemeExample> {
  bool _isDarkMode = false;

  // Light theme
  final ThemeData _lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: Colors.blue,
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.blue,
      brightness: Brightness.light,
    ),
  );

  // Dark theme
  final ThemeData _darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: Colors.indigo,
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.indigo,
      brightness: Brightness.dark,
    ),
  );

  void _toggleTheme() {
    setState(() {
      _isDarkMode = !_isDarkMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AnimatedTheme(
        data: _isDarkMode ? _darkTheme : _lightTheme,
        duration: const Duration(milliseconds: 500),
        child: Builder(
          builder: (context) {
            return Scaffold(
              appBar: AppBar(
                title: const Text('AnimatedTheme Example'),
              ),
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Card demonstrating theme changes
                    Card(
                      elevation: 8,
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              _isDarkMode ? Icons.dark_mode : Icons.light_mode,
                              size: 50,
                              color: Theme.of(context).primaryColor,
                            ),
                            const SizedBox(height: 20),
                            Text(
                              'Current Theme',
                              style: Theme.of(context).textTheme.headlineSmall,
                            ),
                            const SizedBox(height: 10),
                            Text(
                              _isDarkMode ? 'Dark Mode' : 'Light Mode',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),

                    // Theme toggle button
                    ElevatedButton.icon(
                      onPressed: _toggleTheme,
                      icon: Icon(
                        _isDarkMode ? Icons.light_mode : Icons.dark_mode,
                      ),
                      label: Text(
                        _isDarkMode
                            ? 'Switch to Light Mode'
                            : 'Switch to Dark Mode',
                      ),
                    ),

                    const SizedBox(height: 40),

                    // Additional widgets showing theme impact
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _ThemeShowcaseItem(
                          icon: Icons.palette,
                          label: 'Colors',
                        ),
                        SizedBox(width: 20),
                        _ThemeShowcaseItem(
                          icon: Icons.text_fields,
                          label: 'Typography',
                        ),
                        SizedBox(width: 20),
                        _ThemeShowcaseItem(
                          icon: Icons.widgets,
                          label: 'Widgets',
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Floating action button demonstrating theme
              floatingActionButton: FloatingActionButton(
                onPressed: () {},
                child: const Icon(Icons.add),
              ),
            );
          },
        ),
      ),
    );
  }
}

// Helper widget to showcase theme changes
class _ThemeShowcaseItem extends StatelessWidget {
  final IconData icon;
  final String label;

  const _ThemeShowcaseItem({
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 30),
        const SizedBox(height: 5),
        Text(
          label,
          style: Theme.of(context).textTheme.labelMedium,
        ),
      ],
    );
  }
}
