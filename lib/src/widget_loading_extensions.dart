import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

/// Enum representing all available types of loading spinners in [ExLoadingScreen].
/// Use this enum with the [spinnerType] parameter to choose a SpinKit animation
/// or other supported loading indicator.
enum LoadingSpinnerType {
  /// Simple spinning circle.
  circle,

  /// Cube fading animation.
  fadingCube,

  /// Wave animation with bouncing bars.
  wave,

  /// Circular ring spinner.
  ring,

  /// Two bouncing circles.
  doubleBounce,

  /// Three bouncing dots animation.
  threeBounce,

  /// Chasing dots animation.
  chasingDots,

  /// Fading four dots animation.
  fadingFour,

  /// Folding cube animation.
  foldingCube,

  /// Rotating circle of dots.
  rotatingCircle,

  /// Pulse animation.
  pulse,

  /// Hourglass-style spinner.
  hourGlass,

  /// Ripple effect animation.
  ripple,

  /// Cube grid spinner animation.
  cubeGrid,
}


/// Extension on [Widget] to wrap it as a professional, highly customizable
/// full-screen loading overlay.
///
/// Example usage:
/// ```dart
/// Container().asLoadingScreen(
///   message: "Loading data...",
///   subMessage: "Please wait",
///   spinnerColor: Colors.blue,
///   spinnerType: LoadingSpinnerType.ring,
/// );
///
/// // Or with a custom image or icon
/// Container().asLoadingScreen(
///   customChild: Image.asset('assets/loader.gif', width: 100, height: 100),
/// );
/// ```
extension ExLoadingScreen on Widget {
  /// Wraps the widget in a full-screen loading overlay with optional messages,
  /// blur, spinner, fade animation, or fully custom child.
  Widget asLoadingScreen({
    String? message,
    String? subMessage,
    double blur = 6.0,
    Color backgroundColor = const Color(0x88000000),
    Color spinnerColor = Colors.white,
    double spinnerSize = 50.0,
    LoadingSpinnerType spinnerType = LoadingSpinnerType.circle,
    TextStyle? messageStyle,
    TextStyle? subMessageStyle,
    Widget? customChild, // Fully customizable: image, icon, Lottie, etc.
    Duration fadeDuration = const Duration(milliseconds: 400),
  }) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Container(color: backgroundColor),
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
          child: TweenAnimationBuilder<double>(
            tween: Tween(begin: 0, end: 1),
            duration: fadeDuration,
            builder: (context, value, child) => Opacity(
              opacity: value,
              child: child,
            ),
            child: Center(
              child: customChild ?? _defaultLoadingContent(
                spinnerType,
                spinnerSize,
                spinnerColor,
                message,
                subMessage,
                messageStyle,
                subMessageStyle,
              ),
            ),
          ),
        ),
      ],
    );
  }

  /// Default loading content (SpinKit + optional messages)
  Widget _defaultLoadingContent(
      LoadingSpinnerType spinnerType,
      double spinnerSize,
      Color spinnerColor,
      String? message,
      String? subMessage,
      TextStyle? messageStyle,
      TextStyle? subMessageStyle,
      ) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildSpinner(spinnerType, spinnerSize, spinnerColor),
        if (message != null) ...[
          const SizedBox(height: 16),
          Text(
            message,
            textAlign: TextAlign.center,
            style: messageStyle ??
                TextStyle(
                  color: spinnerColor,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
          ),
        ],
        if (subMessage != null) ...[
          const SizedBox(height: 8),
          Text(
            subMessage,
            textAlign: TextAlign.center,
            style: subMessageStyle ??
                TextStyle(
                  color: spinnerColor.withValues(alpha: 0.8),
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
          ),
        ],
      ],
    );
  }

  /// Build SpinKit spinner based on type
  Widget _buildSpinner(LoadingSpinnerType type, double size, Color color) {
    switch (type) {
      case LoadingSpinnerType.circle:
        return SpinKitCircle(color: color, size: size);
      case LoadingSpinnerType.fadingCube:
        return SpinKitFadingCube(color: color, size: size);
      case LoadingSpinnerType.wave:
        return SpinKitWave(color: color, size: size, type: SpinKitWaveType.center);
      case LoadingSpinnerType.ring:
        return SpinKitRing(color: color, size: size, lineWidth: 4.0);
      case LoadingSpinnerType.doubleBounce:
        return SpinKitDoubleBounce(color: color, size: size);
      case LoadingSpinnerType.threeBounce:
        return SpinKitThreeBounce(color: color, size: size);
      case LoadingSpinnerType.chasingDots:
        return SpinKitChasingDots(color: color, size: size);
      case LoadingSpinnerType.fadingFour:
        return SpinKitFadingFour(color: color, size: size);
      case LoadingSpinnerType.foldingCube:
        return SpinKitFoldingCube(color: color, size: size);
      case LoadingSpinnerType.rotatingCircle:
        return SpinKitRotatingCircle(color: color, size: size);
      case LoadingSpinnerType.pulse:
        return SpinKitPulse(color: color, size: size);
      case LoadingSpinnerType.hourGlass:
        return SpinKitHourGlass(color: color, size: size);
      case LoadingSpinnerType.ripple:
        return SpinKitRipple(color: color, size: size);
      case LoadingSpinnerType.cubeGrid:
        return SpinKitCubeGrid(color: color, size: size);
    }
  }
}
