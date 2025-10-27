import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

/// Extension on [Widget] to provide a `.onTap()` method for adding tap handlers.
extension ExTapExtension on Widget {
  /// Wraps the widget in a [GestureDetector] that calls [onTap] when tapped.
  ///
  /// Example:
  /// ```dart
  /// Text('Tap me').onTap(() => print('Tapped!'));
  /// ```
  Widget onTap(VoidCallback onTap) => GestureDetector(
    onTap: onTap,
    behavior: HitTestBehavior.opaque,
    child: this,
  );
}

/// Extension on [Widget] for adding padding.
extension ExPadding on Widget {
  /// Applies equal padding on all sides.
  Widget withPaddingAll(double value) =>
      Padding(padding: EdgeInsets.all(value), child: this);

  /// Applies horizontal and vertical symmetric padding.
  Widget withPaddingSymmetric({double horizontal = 0, double vertical = 0}) =>
      Padding(
        padding: EdgeInsets.symmetric(
          horizontal: horizontal,
          vertical: vertical,
        ),
        child: this,
      );

  /// Applies padding to specific sides.
  Widget withPaddingOnly({
    double left = 0,
    double top = 0,
    double right = 0,
    double bottom = 0,
  }) => Padding(
    padding: EdgeInsets.only(
      left: left,
      top: top,
      right: right,
      bottom: bottom,
    ),
    child: this,
  );
}

/// Extension on [Iterable] to provide indexed mapping.
extension ExIndexedMap<E> on Iterable<E> {
  /// Maps each element with its index.
  ///
  /// Example:
  /// ```dart
  /// ['a', 'b'].mapIndexed((i, v) => '$i: $v'); // ['0: a', '1: b']
  /// ```
  Iterable<T> mapIndexed<T>(T Function(int index, E element) f) {
    var i = 0;
    return map((e) => f(i++, e));
  }
}

/// Extension on [num] to easily create spacing widgets.
extension ExSpacing on num {
  /// Returns a vertical [SizedBox] with the given height.
  SizedBox spacingY() => SizedBox(height: toDouble());

  /// Returns a horizontal [SizedBox] with the given width.
  SizedBox spacingX() => SizedBox(width: toDouble());
}

/// Extension on [double] to convert into [EdgeInsets].
extension ExEdgeInsets on double {
  /// Returns [EdgeInsets.all] with this value.
  EdgeInsets get toAll => EdgeInsets.all(this);

  /// Returns [EdgeInsets.symmetric] with this value used for both vertical and horizontal.
  EdgeInsets get toSymmetric =>
      EdgeInsets.symmetric(vertical: this, horizontal: this);
}

/// Extension to add simple debug logging to any object.
extension ExDebugLog on Object {
  /// Prints the object using `debugPrint()` in debug mode only.
  ///
  /// Optionally adds a [tag] prefix in square brackets.
  ///
  /// Example:
  /// ```dart
  /// 'Something went wrong'.log(tag: 'ERROR');
  /// // Output: [ERROR] Something went wrong
  /// ```
  void log({String tag = ''}) {
    assert(() {
      debugPrint('${tag.isNotEmpty ? '[$tag] ' : ''}$this');
      return true;
    }());
  }
}

/// Extension on [Widget] to wrap it in a card-like [Container] with rounded corners,
/// padding, background color, optional shadow, border, and alignment.
///
/// Useful for quickly creating reusable card UIs.
///
/// Example:
/// ```dart
/// Text('Hello Card').asCard();
/// ```
extension ExCardContainer on Widget {
  /// Wraps the widget in a Card-like [Container] with rounded corners, padding,
  /// background color, and soft shadow.
  ///
  /// Ideal for building lightweight custom cards.
  ///
  /// Example:
  /// ```dart
  /// Text('Hello Card').asCard();
  /// ```
  Widget asCard({
    Color color = Colors.white,
    double radius = 12.0,
    EdgeInsetsGeometry padding = const EdgeInsets.all(12),
    EdgeInsetsGeometry? margin,
    BoxShadow? boxShadow,
    BoxBorder? border,
    double? width,
    double? height,
    AlignmentGeometry? alignment,
  }) {
    return Container(
      width: width,
      height: height,
      alignment: alignment,
      margin: margin,
      padding: padding,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(radius),
        border: border,
        boxShadow: [
          boxShadow ??
              BoxShadow(
                color: Colors.black12,
                blurRadius: 6,
                offset: Offset(0, 3),
              ),
        ],
      ),
      child: this,
    );
  }
}

/// Extension on [Widget] (typically an [Image]) to clip it with rounded corners
/// using a [ClipRRect].
///
/// Example:
/// ```dart
/// Image.asset('image.png').clipRounded(10);
/// ```
extension ExClipImage on Widget {
  /// Wraps the widget (usually an image) in a [ClipRRect] with rounded corners.
  ///
  /// Example:
  /// ```dart
  /// Image.network(url).clipRounded(12);
  /// ```
  Widget clipRounded(double radius) {
    return ClipRRect(borderRadius: BorderRadius.circular(radius), child: this);
  }
}

/// Extension on [Widget] (specifically an [Image]) that makes it tappable,
/// opening a full-screen zoomable preview using [InteractiveViewer].
///
/// Example:
/// ```dart
/// Image.network(url)
///   .clipRounded(12)
///   .onImageTapPreview(context, imageProvider: NetworkImage(url));
/// ```
extension ExImageZoomPreview on Widget {
  /// Makes the image tappable to open in a full-screen or custom-sized zoomable view.
  ///
  /// - [imageProvider]: Required to display the full image.
  /// - [maxScale]: Maximum zoom scale (default: 4.0).
  /// - [minScale]: Minimum zoom scale (default: 1.0).
  /// - [previewSize]: If provided, uses a fixed size for the image preview instead of full screen.
  ///   Use `Size.infinite` or skip to use full screen.
  Widget onImageTapPreview(
    BuildContext context, {
    required ImageProvider imageProvider,
    double minScale = 1.0,
    double maxScale = 4.0,
    Size? previewSize,
  }) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            fullscreenDialog: true,
            builder:
                (_) => Scaffold(
                  backgroundColor: Colors.black,
                  appBar: AppBar(
                    backgroundColor: Colors.transparent,
                    iconTheme: const IconThemeData(color: Colors.white),
                    elevation: 0,
                  ),
                  body: Center(
                    child: InteractiveViewer(
                      minScale: minScale,
                      maxScale: maxScale,
                      child:
                          previewSize != null
                              ? SizedBox(
                                width: previewSize.width,
                                height: previewSize.height,
                                child: FittedBox(
                                  fit: BoxFit.contain,
                                  child: Image(image: imageProvider),
                                ),
                              )
                              : SizedBox.expand(
                                child: FittedBox(
                                  fit: BoxFit.contain,
                                  child: Image(image: imageProvider),
                                ),
                              ),
                    ),
                  ),
                ),
          ),
        );
      },
      child: this,
    );
  }
}

/// Extension on [Widget] to provide simple animation effects.
extension ExAnimations on Widget {
  /// Wraps the widget in a fade-in animation.
  Widget fadeIn({
    Duration duration = const Duration(milliseconds: 500),
    Curve curve = Curves.easeIn,
  }) {
    return TweenAnimationBuilder<double>(
      duration: duration,
      tween: Tween(begin: 0, end: 1),
      curve: curve,
      builder: (_, value, child) => Opacity(opacity: value, child: child),
      child: this,
    );
  }
}

/// Extension on [Widget] to add a scale-down animation on tap (similar to TikTok buttons).
extension ExTapEffect on Widget {
  /// Adds a tap-down scale animation (like TikTok buttons).
  Widget tapScale({
    double scale = 0.95,
    Duration duration = const Duration(milliseconds: 100),
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: TweenAnimationBuilder(
        duration: duration,
        curve: Curves.easeInOut,
        tween: Tween<double>(begin: 1.0, end: 1.0),
        builder: (context, value, child) {
          return GestureDetector(
            onTapDown: (_) => value = scale,
            onTapUp: (_) => value = 1.0,
            onTapCancel: () => value = 1.0,
            child: Transform.scale(scale: value, child: this),
          );
        },
        child: this,
      ),
    );
  }
}

/// Extension on [Widget] to apply a Gaussian blur effect using [BackdropFilter].
extension ExBlur on Widget {
  /// Extension on [Widget] to apply a Gaussian blur effect using [BackdropFilter].
  Widget blurred({double sigma = 10}) {
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: sigma, sigmaY: sigma),
        child: this,
      ),
    );
  }
}

/// Extension on [Widget] to wrap it in a glassmorphic (blurred and translucent) card.
///
/// Example:
/// ```dart
/// Text('Frosted Glass').asGlassCard();
/// ```
extension ExGlassCard on Widget {
  /// Wraps the widget in a glassmorphic card with background blur and semi-transparent overlay.
  ///
  /// - [blur]: Strength of the background blur (default: 10).
  /// - [color]: Background overlay color with transparency (default: white 20%).
  /// - [radius]: Border radius for rounded corners (default: 16).
  /// - [borderColor]: Optional border color with transparency.
  /// - [padding]: Optional inner padding (default: 16).
  /// - [width]/[height]: Optional fixed size.
  Widget asGlassCard({
    double blur = 10,
    Color color = const Color(0x33FFFFFF), // White with ~20% opacity
    double radius = 16,
    Color borderColor = const Color(0x55FFFFFF),
    EdgeInsetsGeometry padding = const EdgeInsets.all(16),
    double? width,
    double? height,
    AlignmentGeometry alignment = Alignment.center,
  }) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
        child: Container(
          width: width,
          height: height,
          padding: padding,
          alignment: alignment,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(radius),
            border: Border.all(color: borderColor.withValues(alpha: 0.3)),
          ),
          child: this,
        ),
      ),
    );
  }
}

/// Extension to wrap a widget with a neumorphic-style container.
///
/// Example:
/// ```dart
/// Icon(Icons.star).asNeumorphic();
/// ```
extension ExNeumorphic on Widget {
  /// Wraps the widget in a soft neumorphic-style container.
  ///
  /// - [color]: Background color (should match app bg).
  /// - [radius]: Corner radius.
  /// - [padding]: Inner padding.
  /// - [depth]: Shadow depth (positive for outer, negative for inner).
  /// - [lightSource]: Direction of the light source.
  Widget asNeumorphic({
    Color color = const Color(0xFFE0E0E0),
    double radius = 16,
    EdgeInsetsGeometry padding = const EdgeInsets.all(16),
    double depth = 6.0,
    Offset lightSource = const Offset(-4, -4),
  }) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(radius),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            offset: lightSource,
            blurRadius: depth,
          ),
          BoxShadow(
            color: Colors.white,
            offset: -lightSource,
            blurRadius: depth,
          ),
        ],
      ),
      child: this,
    );
  }
}

/// Extension to wrap a widget with a gradient background card.
///
/// Example:
/// ```dart
/// Text('Gradient').asGradientCard();
/// ```
extension ExGradientCard on Widget {
  /// Wraps the widget in a container with gradient, padding, rounded corners and shadow.
  ///
  /// - [colors]: Gradient colors.
  /// - [radius]: Corner radius.
  /// - [padding]: Inner padding.
  /// - [begin]/[end]: Gradient direction.
  /// - [shadow]: Optional box shadow.
  Widget asGradientCard({
    List<Color> colors = const [Color(0xFF8E2DE2), Color(0xFF4A00E0)],
    double radius = 16,
    EdgeInsetsGeometry padding = const EdgeInsets.all(16),
    Alignment begin = Alignment.topLeft,
    Alignment end = Alignment.bottomRight,
    List<BoxShadow>? shadow,
  }) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        gradient: LinearGradient(begin: begin, end: end, colors: colors),
        borderRadius: BorderRadius.circular(radius),
        boxShadow:
            shadow ??
            [
              const BoxShadow(
                color: Colors.black26,
                blurRadius: 8,
                offset: Offset(0, 4),
              ),
            ],
      ),
      child: this,
    );
  }
}


/// Extension on [Widget] to apply a shimmer loading effect.
///
/// Example:
/// ```dart
/// Container(height: 20, width: 100, color: Colors.grey).asShimmer();
/// ```
extension ExShimmer on Widget {
  /// Wraps the widget with a shimmer effect (animated gradient overlay).
  Widget asShimmer({
    Color baseColor = const Color(0xFFE0E0E0),
    Color highlightColor = const Color(0xFFF5F5F5),
    Duration period = const Duration(seconds: 2),
  }) {
    return Shimmer.fromColors(
      baseColor: baseColor,
      highlightColor: highlightColor,
      period: period,
      child: this,
    );
  }
}

