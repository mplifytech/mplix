import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mplix/mplix.dart';

void main() {
  runApp(const MplixDemoApp());
}

class MplixDemoApp extends StatelessWidget {
  const MplixDemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mplix Extensions Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      home: const DemoHomePage(),
    );
  }
}

class DemoHomePage extends StatelessWidget {
  const DemoHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final name = 'flutter dev';
    final emojiText = 'I love :pizza: and :coffee: from :india:!'.withEmojis();
    final now = DateTime.now();

    return Scaffold(
      appBar: AppBar(title: const Text('🧩 Mplix Demo')),
      body: SingleChildScrollView(
        padding: 16.0.toAll,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _sectionTitle('📝 String Extensions'),
            Text('Original: $name'),
            Text('Capitalize: ${name.capitalize()}'),
            Text('Title Case: ${name.toTitleCase()}'),
            Text(
              'Sentence Case: ${'hello world. this is flutter.'.capitalizeSentences()}',
            ),
            Text('To Int: ${'123'.toInt()}'),
            Text('To Double: ${'12.34'.toDouble()}'),

            20.spacingY(),
            _sectionTitle('💬 Emoji Extension'),
            Text(emojiText),

            20.spacingY(),
            _sectionTitle('🧪 Nullable Extension'),
            Text('Is null or blank: ${null.isNullOrBlank}'),

            20.spacingY(),
            _sectionTitle('📆 DateTime Extensions'),
            Text('Formatted: ${now.format()}'),
            Text('Short: ${now.short}'),
            Text('Time: ${now.time}'),
            Text('Full: ${now.fullDateTime}'),
            Text('Is today: ${now.isToday}'),

            20.spacingY(),
            _sectionTitle('🎨 Color Extension'),
            Container(
              height: 40,
              width: 120,
              color: Colors.teal,
              alignment: Alignment.center,
              child: Text(
                Colors.teal.toHex(),
                style: const TextStyle(color: Colors.white),
              ),
            ).fadeIn().withPaddingAll(8).asCard(),

            20.spacingY(),
            _sectionTitle('📦 Iterable Extension'),
            ...[
              'One',
              'Two',
              'Three',
            ].mapIndexed((i, val) => Text('$i → $val')),

            20.spacingY(),
            _sectionTitle('📐 Context Extensions'),
            Text('Width: ${context.width}'),
            Text('Height: ${context.height}'),
            Text('Primary color: ${context.theme.primaryColor.toHex()}'),

            20.spacingY(),
            _sectionTitle('📎 Clipboard & Snackbar'),
            ElevatedButton(
              onPressed: () {
                context.copyToClipboard(
                  'Copied via Mplix!',
                  successMessage: '✅ Copied to clipboard',
                );
              },
              child: const Text('Copy Text'),
            ),

            10.spacingY(),
            ElevatedButton(
              onPressed: () {
                context.showSnackbar('Hello from snackbar!');
              },
              child: const Text('Show Snackbar'),
            ),

            20.spacingY(),
            _sectionTitle('🔁 Navigation & Loader'),
            ElevatedButton(
              onPressed: () {
                context
                    .withLoadingDialog(
                      Future.delayed(const Duration(seconds: 2), () => 'Done'),
                      message: 'Loading demo...',
                    )
                    .then((result) {
                      context.showSnackbar('Loaded result: $result');
                    });
              },
              child: const Text('Show Loader and Then Snackbar'),
            ),

            20.spacingY(),
            _sectionTitle('📏 Widget Extensions'),
            Container(
              padding: 8.0.toAll,
              color: Colors.orange,
              child: const Text(
                'Tap Me',
              ).onTap(() => 'Tapped!'.log(tag: 'WIDGET')).withPaddingAll(8),
            ),

            20.spacingY(),
            _sectionTitle('🛠 Utility Extensions'),
            ElevatedButton(
              onPressed: () {
                'Logged from Mplix'.log(tag: 'DEBUG');
              },
              child: const Text('Log to Debug Console'),
            ),

            20.spacingY(),
            _sectionTitle('🪪 asCard() Demo'),
            Row(
              children: [
                const Icon(Icons.lightbulb_outline, color: Colors.deepPurple),
                8.spacingX(),
                const Text('This is inside a card'),
              ],
            ).asCard(
              color: Colors.deepPurple[50]!,
              radius: 16,
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.symmetric(vertical: 8),
            ),

            20.spacingY(),
            _sectionTitle('🖼 clipRounded() + onImageTapPreview()'),
            Image.network('https://picsum.photos/300/200', fit: BoxFit.cover)
                .clipRounded(16)
                .onImageTapPreview(
                  context,
                  imageProvider: NetworkImage('https://picsum.photos/300/200'),
                ),

            20.spacingY(),
            _sectionTitle('🎞️ Animation & Effects Extensions'),

            Text('This fades in nicely').fadeIn().withPaddingAll(8).asCard(),

            10.spacingY(),

            Icon(
              CupertinoIcons.heart_fill,
              color: Colors.red,
              size: 80,
            ).tapScale(onTap: () => '❤️ Liked!'.log()),

            10.spacingY(),

            Stack(
              children: [
                Image.network(
                  'https://picsum.photos/400/250',
                  width: double.infinity,
                  height: 200,
                  fit: BoxFit.cover,
                ),
                Positioned.fill(
                  child: Container(
                    alignment: Alignment.center,
                    color: Colors.white.withValues(alpha: 0.1),
                    child: Text(
                      'Blurred Overlay Text',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ).blurred(sigma: 8),
                  ),
                ),
              ],
            ).clipRounded(12).withPaddingAll(8),

            10.spacingY(),
            Text(
              'Beautiful Glass Card',
              style: const TextStyle(fontSize: 18, color: Colors.white),
            ).asGlassCard(
              height: 300,
              width: 300,
              color: Colors.pinkAccent.withValues(alpha: 0.3),
            ),

            10.spacingY(),
            Text('Soft UI').asNeumorphic().withPaddingAll(16),

            Text('Gradient Card')
                .asGradientCard(colors: [Colors.orange, Colors.deepOrange])
                .withPaddingAll(16),

            20.spacingY(),
            _sectionTitle('🔢 Number Formatting Extensions'),

            Text('Clean: ${42.toCleanString()}'), // 42
            Text('Clean: ${42.55.toCleanString()}'), // 42.55
            Text('Compact: ${1500000.toCompact()}'), // 1.5M
            Text('Currency: ${123456.78.toCurrency()}'), // ₹1,23,456.78
            Text('Localized: ${12345678.toLocalized()}'), // 1,23,45,678
            Text('Ordinal: ${1.toOrdinal()}'), // 1st
            Text('Ordinal: ${2.toOrdinal()}'), // 2nd
            Text('Ordinal: ${3.toOrdinal()}'), // 3rd
            Text('Ordinal: ${11.toOrdinal()}'), // 11th
            Text('Ordinal: ${23.toOrdinal()}'),

            20.spacingY(),
            _sectionTitle("🧮 Math Extensions Demo"),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Square Display (5.square): ${5.square}'), // 5²
                Text('Square Value (5.squareVal): ${5.squareVal}'), // 25
                Text('Cube Display (2.cube): ${2.cube}'), // 2³
                Text('Cube Value (2.cubeVal): ${2.cubeVal}'), // 8
                Text('Power Display (2.toPower(4)): ${2.toPower(4)}'), // 2^4
                Text('Power Value (2.pow(4)): ${2.pow(4)}'), // 16
                Text(
                  'Superscript Power (2.toSuperPower(5)): ${2.toSuperPower(5)}',
                ), // 2⁵
                Text(
                  'Super Power Formula: ${2.asSuperPowerFormula(5)}',
                ), // 2⁵ = 32
                Text('Plain Power Formula: ${2.asPowerFormula(5)}'), // 2^5 = 32
                Text('Square Formula: ${3.asSquareFormula()}'), // 3² = 9
                Text('Cube Formula: ${4.asCubeFormula()}'), // 4³ = 64
                Text('Root Display (16.toRoot(2)): ${16.toRoot(2)}'), // √16
                Text(
                  'Root Formula (27.asRootFormula(3)): ${27.asRootFormula(3)}',
                ), // ³√27 = 3.0000
                Text('Log Base 2: ${8.asLogFormula(2)}'), // log₂(8) = 3.0000
                Text('LaTeX Power: ${2.toLaTeXPower(3)}'), // 2^{3}
                Text('LaTeX Root: ${16.toLaTeXRoot(2)}'), // \sqrt{16}
                Text('Markdown Log: ${8.toMarkdownLog(2)}'), // `log_{2}(8)`
                Text('Perfect Square? (16): ${16.isPerfectSquare}'), // true
                Text('Perfect Cube? (27): ${27.isPerfectCube}'), // true
                Text(
                  'Radians (180.toRadians): ${180.toRadians.toStringAsFixed(4)}',
                ), // 3.1416
                Text(
                  'Degrees (π.toDegrees): ${(3.1416).toDegrees.toStringAsFixed(2)}°',
                ), // 180.00°
                Text('Factorial (5!): ${5.factorial}'), // 120
                Text(
                  'Factorial Formula: ${5.asFactorialFormula()}',
                ), // 5! = 120
                Text('Signed Symbol (+/-): ${3.signWithSymbol}'), // +3
                Text('Sin(90): ${90.asSinFormula()}'), // sin(90) = 1.0000
                Text('Cos(180): ${180.asCosFormula()}'), // cos(180) = -1.0000
                Text('Tan(45): ${45.asTanFormula()}'), // tan(45) = 1.0000
                Text('Fraction Symbol (0.25): ${0.25.toFractionSymbol()}'), // ¼
                Text(
                  'Fraction Symbol (0.666): ${0.666.toFractionSymbol()}',
                ), // ⅔
                Text('Mixed Fraction (1.75): ${1.75.toMixedFraction()}'), // 1¾
                Text('Mixed Fraction (0.875): ${0.875.toMixedFraction()}'), // ⅞
                Text('Superscript (2023): ${2023.toSuperscript()}'), // ²⁰²³
                Text('Subscript (2023): ${2023.toSubscript()}'), // ₂₀₂₃
              ],
            ),
            20.spacingY(),
            _sectionTitle('🌀 Full-Screen Loading Demo with Icon/Image'),
            ElevatedButton(
              onPressed: () {
                // Overlay your entire Scaffold body with a loading screen
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (context) => Scaffold(
                    backgroundColor: Colors.transparent,
                    body: Container().asLoadingScreen(
                      blur: 8.0,
                      backgroundColor: Colors.black.withValues(alpha: 0.6),
                      fadeDuration: const Duration(milliseconds: 500),
                      customChild: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Optional icon or image at the top
                          const Icon(
                            Icons.cloud_download,
                            size: 60,
                            color: Colors.deepPurple,
                          ),
                          const SizedBox(height: 20),

                          // Spinner below the icon
                          SpinKitFadingCube(
                            color: Colors.deepPurpleAccent,
                            size: 50,
                          ),
                          const SizedBox(height: 20),

                          // Messages below
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
                              color: Colors.white.withValues(alpha: 0.8),
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );

                // Simulate a delay then close the loader
                Future.delayed(const Duration(seconds: 3), () {
                  Navigator.of(context).pop(); // Close the loading dialog
                  context.showSnackbar("Data loaded successfully!");
                });
              },
              child: const Text('Show Full-Screen Loader with Icon'),
            ),
            20.spacingY(),
            _sectionTitle('✨ Shimmer Demo'),
            Row(
              children: [
                Container(
                  height: 20,
                  width: 100,
                  color: Colors.grey,
                ).asShimmer(), // basic shimmer
                10.spacingX(),
                Container(
                  height: 20,
                  width: 150,
                  color: Colors.grey.shade400,
                ).asShimmer(
                  baseColor: Colors.grey.shade400,
                  highlightColor: Colors.grey.shade200,
                  period: const Duration(seconds: 1),
                ),
              ],
            ),


          ],
        ),
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    );
  }
}
