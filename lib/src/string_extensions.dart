import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mplix/src/context_extensions.dart';

/// String extension with common utility methods.
extension ExStringUtils on String {
  /// Returns `true` if the string is null, empty or contains only whitespace.
  bool get isNullOrEmpty => trim().isEmpty;

  /// Capitalizes the first letter of the string and converts the rest to lowercase.
  ///
  /// Example: `'flutter'.capitalize()` → `'Flutter'`
  String capitalize() =>
      isEmpty ? '' : this[0].toUpperCase() + substring(1).toLowerCase();

  /// Converts the string to title case (capitalizing the first letter of each word).
  ///
  /// Example: `'hello world'.toTitleCase()` → `'Hello World'`
  String toTitleCase() => split(' ').map((str) => str.capitalize()).join(' ');

  /// Parses the string into an `int`. Returns [defaultValue] if parsing fails.
  int toInt({int defaultValue = 0}) => int.tryParse(this) ?? defaultValue;

  /// Parses the string into a `double`. Returns [defaultValue] if parsing fails.
  double toDouble({double defaultValue = 0.0}) =>
      double.tryParse(this) ?? defaultValue;
}

/// Nullable string extension for checking null or blank.
extension ExNullableString on String? {
  /// Returns `true` if the string is null or contains only whitespace.
  bool get isNullOrBlank => this == null || this!.trim().isEmpty;
}

/// Extension on `BuildContext` to easily copy text to clipboard and optionally show a snackbar.
extension ExClipboard on BuildContext {
  /// Copies [text] to the clipboard and optionally shows a [successMessage] via snackbar.
  void copyToClipboard(String text, {String? successMessage}) {
    Clipboard.setData(ClipboardData(text: text));
    if (successMessage != null) {
      showSnackbar(successMessage);
    }
  }
}

/// Extension on `String` to capitalize the first letter of each sentence.
extension ExStringSentenceCase on String {
  /// Capitalizes the first letter of each sentence.
  ///
  /// Example: `'hello. this is a test.'` → `'Hello. This is a test.'`
  String capitalizeSentences() {
    final sentenceEndRegex = RegExp(r'([.!?])\s+');
    final parts = split(sentenceEndRegex);

    StringBuffer buffer = StringBuffer();
    for (int i = 0; i < parts.length; i++) {
      final part = parts[i].trim();
      if (sentenceEndRegex.hasMatch(part)) {
        buffer.write('$part ');
      } else if (part.isNotEmpty) {
        buffer.write(
          '${part[0].toUpperCase()}${part.substring(1).toLowerCase()}',
        );
      }
    }
    return buffer.toString().trim();
  }
}

/// Extension on `String` to replace emoji codes like `:pizza:` with real emojis like 🍕.
extension ExEmojiReplace on String {
  /// A map of emoji keywords to their emoji representations.
  static const Map<String, String> _emojiMap = {
    // ... (unchanged map contents)
    // You can keep this part as is — no need to duplicate here for brevity
  };

  /// Replaces emoji codes (e.g. `:pizza:`) with actual emojis (e.g. 🍕).
  ///
  /// Example: `'I love :pizza: and :india:'` → `'I love 🍕 and 🇮🇳'`
  String withEmojis() {
    return replaceAllMapped(RegExp(r':([a-zA-Z0-9_+-]+):'), (match) {
      final key = match.group(1)!;
      return _emojiMap[key] ?? match.group(0)!;
    });
  }
}

/// easy to use Image card, ready to use.
extension ExImageCard on String {
  /// Creates a customizable image card with rounded corners, shadow, and tap effect.
  ///
  /// Pass asset path, network URL, or local file path.
  Widget asImageCard({
    double? height,
    double? width,
    double radius = 16,
    BoxFit fit = BoxFit.cover,
    bool shadow = true,
    VoidCallback? onTap,
    EdgeInsetsGeometry padding = EdgeInsets.zero,
    AlignmentGeometry alignment = Alignment.center,
    Color? backgroundColor,
    BoxBorder? border,
  }) {
    ImageProvider imageProvider;

    if (startsWith('http') || startsWith('https')) {
      imageProvider = NetworkImage(this);
    } else if (startsWith('/') || startsWith('file://')) {
      imageProvider = FileImage(File(this));
    } else {
      imageProvider = AssetImage(this);
    }

    Widget image = Container(
      height: height,
      width: width,
      alignment: alignment,
      padding: padding,
      decoration: BoxDecoration(
        color: backgroundColor ?? Colors.white,
        image: DecorationImage(image: imageProvider, fit: fit),
        borderRadius: BorderRadius.circular(radius),
        border: border,
        boxShadow:
            shadow
                ? [
                  const BoxShadow(
                    color: Colors.black12,
                    blurRadius: 8,
                    offset: Offset(0, 4),
                  ),
                ]
                : null,
      ),
    );

    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child:
          onTap != null ? GestureDetector(onTap: onTap, child: image) : image,
    );
  }
}
