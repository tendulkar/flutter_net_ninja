/// Index file for ImplicitlyAnimatedWidget examples
/// 
/// This file exports all the example implementations of ImplicitlyAnimatedWidget.
/// Each example demonstrates different aspects and use cases of implicit animations.
///
/// Common ImplicitlyAnimatedWidget implementations:
/// 1. AnimatedContainer - Animates container properties
/// 2. AnimatedPadding - Animates padding values
/// 3. AnimatedPositioned - Animates position in a Stack
/// 4. AnimatedAlign - Animates alignment
/// 5. AnimatedOpacity - Animates opacity
/// 6. AnimatedDefaultTextStyle - Animates text style properties
/// 7. AnimatedPhysicalModel - Animates physical properties like elevation
/// 8. AnimatedTheme - Animates between different themes
/// 9. TweenAnimationBuilder - Custom implicit animations
/// 10. AnimatedCrossFade - Fades between two children
/// 11. AnimatedSize - Animates size changes
/// 12. AnimatedSwitcher - Transitions between widgets
///
/// Special Examples:
/// 13. CombinedAnimations - Shows how to combine multiple animations
///
/// Key concepts across all implementations:
/// - No explicit AnimationController needed
/// - State-driven animations
/// - Automatic animation handling
/// - Simple property updates trigger animations
///
/// Usage Tips:
/// 1. Choose the right widget for your use case:
///    - AnimatedContainer for general purpose animations
///    - AnimatedPositioned for Stack-based layouts
///    - AnimatedAlign for alignment changes
///    - AnimatedPadding for spacing animations
///    - AnimatedDefaultTextStyle for text animations
///    - AnimatedPhysicalModel for elevation/shadow
///    - AnimatedTheme for theme transitions
///    - TweenAnimationBuilder for custom animations
///    - AnimatedCrossFade for switching content
///    - AnimatedSize for size changes
///    - AnimatedSwitcher for widget transitions
///
/// 2. Consider performance:
///    - Use simpler widgets when possible
///    - Avoid animating too many properties
///    - Keep animations short and smooth
///    - Be mindful of widget rebuilds
///
/// 3. User Experience:
///    - Use appropriate durations
///    - Choose suitable curves
///    - Provide visual feedback
///    - Keep animations meaningful
///    - Consider accessibility
///
/// 4. Best Practices:
///    - Group related animations
///    - Use consistent durations
///    - Handle state properly
///    - Clean up resources
///    - Test on different devices

export 'animated_align_example.dart';
export 'animated_container_example.dart';
export 'animated_cross_fade_example.dart';
export 'animated_padding_example.dart';
export 'animated_positioned_example.dart';
export 'animated_size_example.dart';
export 'animated_switcher_example.dart';
export 'animated_text_style_example.dart';
export 'animated_physical_model_example.dart';
export 'animated_theme_example.dart';
export 'combined_animations_example.dart';
export 'simple_opacity_tween_example.dart';
export 'tween_animation_builder_example.dart';
