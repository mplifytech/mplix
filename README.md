# 🧩 Mplix

<img src="assets/mplix.png" alt="Mplix Banner" style="width:100%; max-height: 240px; object-fit: cover;" />


**Mplix** is a handy Flutter extension package that enhances your Flutter development experience with powerful, readable, and reusable extensions for `String`, `DateTime`, `BuildContext`, `Color`, `Iterable`, `Widget`, and more — including emoji replacement and utility methods.

> 🚀 Make your Flutter code cleaner, shorter, and more expressive!

---

## ✨ Features

- ✅ `String` extensions – capitalize, title case, convert to number, sentence case, emoji replacements
- ✅ `DateTime` and `Duration` extensions – formatted output, comparison helpers
- ✅ `BuildContext` extensions – screen metrics, theme, snackbar, dialog, navigation, clipboard
- ✅ `Widget` extensions – tap handling, padding, spacing
- ✅ `Color` extension – convert to HEX
- ✅ `Iterable` extensions – `mapIndexed`
- ✅ `Emoji` support – `:pizza: → 🍕`, `:india: → 🇮🇳`, and more!
- ✅ Utility – `log()` for debug printing with optional tags

---

## 🚀 Getting Started

1. Add this to your `pubspec.yaml`:

```yaml
dependencies:
  mplix: ^1.0.0

```
## 📦 Usage

### 📝 String Extensions

```dart
'flutter dev'.capitalize();                          // Flutter dev
'flutter is cool'.toTitleCase();                     // Flutter Is Cool
'hello world. this is flutter.'.capitalizeSentences(); // Hello world. This is flutter.
'123'.toInt();                                       // 123
'12.34'.toDouble();                                  // 12.34
'Flutter ❤️ :pizza: from :india:'.withEmojis();      // Flutter ❤️ 🍕 from 🇮🇳\
```
```📐 Number Formatting Extensions
Clean and smart formatting for numbers using intuitive extension methods:

42.toCleanString();          // "42"
42.5.toCleanString();        // "42.50"

1000.toCompact();            // "1K"
1500000.toCompact();         // "1.5M"

1000.toCurrency();           // ₹1,000.00 (default locale: en_IN)
1000.toCurrency(symbol: '\$'); // $1,000.00

1234567.toLocalized();       // "12,34,567" (Indian style by default)

1.toOrdinal();               // "1st"
2.toOrdinal();               // "2nd"
3.toOrdinal();               // "3rd"
11.toOrdinal();              // "11th"

```


### 📆 DateTime Extensions

```dart

final now = DateTime.now();

now.format();                                        // 22 Jun 2025
now.short;                                           // 22/06/25
now.time;                                            // 08:30 AM
now.fullDateTime;                                    // 22 Jun 2025, 08:30 AM

now.isToday;                                         // true or false
now.isSameDate(DateTime(2025, 6, 22));               // true

```


### ⏳ Duration Extension
```dart
Duration(seconds: 75).formatted;       // 01:15

```
### 🧱 BuildContext Extensions

```dart
context.width;                         // Screen width
context.height;                        // Screen height

context.theme;                         // ThemeData
context.textTheme.headlineSmall;       // Text style access
context.colorScheme.primary;           // Color access

context.divider;                       // Divider widget
context.spacing(20);                   // SizedBox(height: 20)

context.showSnackbar("Hello!");        // Show snackbar
context.copyToClipboard("Copied!", successMessage: "Text copied"); // Copy to clipboard

context.showLoader(message: "Loading..."); // Show loader
context.hideLoader();                  // Hide loader
```


### 🔁 Navigation Extensions

```dart
context.push(MyNewPage());                  // Push a new page
context.pushReplacement(MyOtherPage());     // Replace current page
context.pop();                               // Go back

await context.withLoadingDialog(
someAsyncFunction(),
message: "Processing..."
); // Show loader while future runs

```

### 📦 Iterable Extension
```dart
['apple', 'banana', 'grape'].mapIndexed((i, val) => '$i: $val');
// Output: ['0: apple', '1: banana', '2: grape']

```

### 🎨 Color Extension

```dart
Colors.blue.toHex();                        // #FF2196F3
Colors.green.toHex(leadingHashSign: false); // FF4CAF50

```

### 🧩 Widget Extensions

```dart
Text('Click Me').onTap(() => print('Tapped!'));           // Tap handler

Container().withPaddingAll(8);                                // Padding on all sides
Text('Custom').withPaddingOnly(left: 12, top: 8);             // Specific side padding
Text('Symmetric').withPaddingSymmetric(horizontal: 16); // Horizontal/Vertical
Text('Fade In').fadeIn();                                 // Fade-in animation

Icon(Icons.favorite).tapScale(onTap: () {});              // Tap shrink animation

Text('Soft UI').asNeumorphic();                           // Neumorphic card style

Text('Gradient Card').asGradientCard();                   // Gradient background card

Text('Glass Card').asGlassCard();                         // Frosted glass blur card

Image.asset('pic.png').clipRounded(12);                                       // Clip with corner radius

Image.network(url).clipRounded(12).onImageTapPreview(context, imageProvider: NetworkImage(url)); // Zoomable full preview

'https://picsum.photos/800/300'.asImageCard(
height: 180,
radius: 20,
shadow: true,
onTap: () => print('Image tapped'),
), //resuable image card, (asset,network or file image)


```

### 📐 Spacing & EdgeInsets Extensions
```dart
16.spacingY();                     // SizedBox(height: 16)
8.spacingX();                      // SizedBox(width: 8)

12.0.toAll;                        // EdgeInsets.all(12)
10.0.toSymmetric;                 // EdgeInsets.symmetric(horizontal: 10, vertical: 10)

```

### 😀 Emoji Replacement

```dart
'I love :pizza: and :fries:'.withEmojis();        // I love 🍕 and 🍟
'Greetings from :india:'.withEmojis();            // Greetings from 🇮🇳
```

### 📋 Clipboard Utility
```dart
context.copyToClipboard('Secret Key', successMessage: 'Copied to clipboard!');
```

### 🧠 Debug Logging
```dart
'Something went wrong'.log();                     // Logs to debug console
'Page Loaded'.log(tag: 'INIT');                   // [INIT] Page Loaded
```
### 🧮 Math Extensions
Helper extensions to display math expressions cleanly on UI, similar to how they're shown in math books.
```dart
Text('Square Value: ${5.square}'),                    // 5²
Text('Cube Display: ${2.cube}'),                      // 2³
Text('Power UI: ${2.toSuperPower(5)}'),               // 2⁵
Text('Power Formula: ${2.asSuperPowerFormula(5)}'),   // 2⁵ = 32
Text('Root Display: ${16.toRoot(2)}'),                // √16
Text('Root Formula: ${27.asRootFormula(3)}'),         // ³√27 = 3.0000
Text('Fraction: ${0.25.toFractionSymbol()}'),         // ¼
Text('Mixed: ${1.75.toMixedFraction()}'),             // 1¾
Text('Log Base 2: ${8.asLogFormula(2)}'),             // log₂(8) = 3.0000

```
You can format powers, roots, logs, and common fractions in a visually clean and math-friendly way. Ideal for math-based learning or quiz apps.

### Full-Screen Loading Extension

Mplix provides a highly customizable full-screen loader that can display spinners, images, or icons along with primary and secondary messages. Works with Flutter Web, Mobile, and Desktop.
```dart
// Example: Full-screen loader with icon/image
ElevatedButton(
  onPressed: () {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Scaffold(
        backgroundColor: Colors.transparent,
        body: Container().asLoadingScreen(
          blur: 8.0,
          backgroundColor: Colors.black.withOpacity(0.6),
          fadeDuration: const Duration(milliseconds: 500),
          customChild: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.network(
                'https://img.icons8.com/ios-filled/100/cloud-download.png',
                width: 60,
                height: 60,
                color: Colors.deepPurple,
              ),
              const SizedBox(height: 20),
              SpinKitFadingCube(
                color: Colors.deepPurpleAccent,
                size: 50,
              ),
              const SizedBox(height: 20),
              Text(
                "Fetching data...",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "Please wait a moment",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white.withOpacity(0.8),
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ),
    );

    Future.delayed(const Duration(seconds: 3), () {
      Navigator.of(context).pop();
      context.showSnackbar("Data loaded successfully!");
    });
  },
  child: const Text('Show Full-Screen Loader with Icon'),
);

```
### Shimmer Loading Effect Extension
```dart
// Basic shimmer effect
Container(height: 20, width: 100, color: Colors.grey).asShimmer();

// Custom shimmer
Container(
  height: 20,
  width: 150,
  color: Colors.grey.shade400,
).asShimmer(
  baseColor: Colors.grey.shade400,
  highlightColor: Colors.grey.shade200,
  period: const Duration(seconds: 1),
);

```

### 📌 More Coming Soon...
We’re continuously improving Mplix – more utility extensions, emoji packs, and integration widgets are on the way!



