import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mplix/src/context_extensions.dart';

extension ExStringUtils on String {
  bool get isNullOrEmpty => trim().isEmpty;

  String capitalize() =>
      isEmpty ? '' : this[0].toUpperCase() + substring(1).toLowerCase();

  String toTitleCase() => split(' ').map((str) => str.capitalize()).join(' ');

  int toInt({int defaultValue = 0}) => int.tryParse(this) ?? defaultValue;

  double toDouble({double defaultValue = 0.0}) =>
      double.tryParse(this) ?? defaultValue;
}

extension ExNullableString on String? {
  bool get isNullOrBlank => this == null || this!.trim().isEmpty;
}

extension ExClipboard on BuildContext {
  void copyToClipboard(String text, {String? successMessage}) {
    Clipboard.setData(ClipboardData(text: text));
    if (successMessage != null) {
      showSnackbar(successMessage);
    }
  }
}

extension ExStringSentenceCase on String {
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

extension ExEmojiReplace on String {
  static const Map<String, String> _emojiMap = {
    // Smileys & Emotions
    'smile': '😄',
    'grin': '😁',
    'laugh': '😂',
    'wink': '😉',
    'blush': '😊',
    'sunglasses': '😎',
    'heart_eyes': '😍',
    'thinking': '🤔',
    'shush': '🤫',
    'angry': '😠',
    'cry': '😢',
    'sleep': '😴',
    'party': '🥳',
    'poop': '💩',
    'clown': '🤡',

    // Flags
    'india': '🇮🇳',
    'usa': '🇺🇸',
    'uk': '🇬🇧',
    'canada': '🇨🇦',
    'germany': '🇩🇪',
    'france': '🇫🇷',
    'italy': '🇮🇹',
    'japan': '🇯🇵',
    'china': '🇨🇳',
    'brazil': '🇧🇷',
    'australia': '🇦🇺',
    'russia': '🇷🇺',
    'mexico': '🇲🇽',
    'spain': '🇪🇸',
    'south_korea': '🇰🇷',
    'uae': '🇦🇪',
    'pakistan': '🇵🇰',
    'bangladesh': '🇧🇩',
    'nepal': '🇳🇵',
    'sri_lanka': '🇱🇰',
    'afghanistan': '🇦🇫',
    'philippines': '🇵🇭',
    'argentina': '🇦🇷',
    'nigeria': '🇳🇬',
    'kenya': '🇰🇪',

    // Gestures
    'thumbs_up': '👍',
    'thumbs_down': '👎',
    'clap': '👏',
    'ok': '👌',
    'wave': '👋',
    'pray': '🙏',
    'fist': '✊',
    'peace': '✌️',
    'crossed_fingers': '🤞',

    // People & Activities
    'man': '👨',
    'woman': '👩',
    'boy': '👦',
    'girl': '👧',
    'baby': '👶',
    'person': '🧑',
    'student': '🧑‍🎓',
    'teacher': '🧑‍🏫',
    'doctor': '🧑‍⚕️',
    'developer': '👨‍💻',
    'artist': '🧑‍🎨',

    // Objects & Tools
    'phone': '📱',
    'laptop': '💻',
    'camera': '📷',
    'watch': '⌚',
    'bulb': '💡',
    'money': '💰',
    'gift': '🎁',
    'key': '🔑',
    'lock': '🔒',
    'book': '📚',
    'pen': '🖊️',
    'chart': '📈',

    // Foods
    'pizza': '🍕',
    'burger': '🍔',
    'fries': '🍟',
    'coffee': '☕',
    'tea': '🍵',
    'cake': '🍰',
    'icecream': '🍦',
    'chocolate': '🍫',
    'apple': '🍎',
    'banana': '🍌',
    'grapes': '🍇',

    // Travel & Places
    'house': '🏠',
    'building': '🏢',
    'school': '🏫',
    'hospital': '🏥',
    'car': '🚗',
    'bus': '🚌',
    'train': '🚆',
    'plane': '✈️',
    'rocket': '🚀',
    'globe': '🌍',

    // Nature
    'sun': '☀️',
    'moon': '🌙',
    'star': '⭐',
    'fire': '🔥',
    'rain': '🌧️',
    'cloud': '☁️',
    'tree': '🌳',
    'flower': '🌸',
    'leaf': '🍃',

    // Symbols
    'heart': '❤️',
    '100': '💯',
    'check': '✅',
    'x': '❌',
    'warning': '⚠️',
    'info': 'ℹ️',
    'star2': '🌟',
    'bell': '🔔',
    'zap': '⚡',

    // Celebration
    'tada': '🎉',
    'confetti': '🎊',
    'balloon': '🎈',
    'medal': '🏅',
    'trophy': '🏆',
    'crown': '👑',
  };

  /// Replace :emoji_name: with its emoji (e.g., :pizza: → 🍕)
  String withEmojis() {
    return replaceAllMapped(RegExp(r':([a-zA-Z0-9_+-]+):'), (match) {
      final key = match.group(1)!;
      return _emojiMap[key] ?? match.group(0)!;
    });
  }
}
