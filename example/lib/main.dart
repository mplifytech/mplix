import 'package:flutter/material.dart';
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
            ),

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
              ).onTap(() => 'Tapped!'.log(tag: 'WIDGET')).paddingAll(8),
            ),

            20.spacingY(),
            _sectionTitle('🛠 Utility Extensions'),
            ElevatedButton(
              onPressed: () {
                'Logged from Mplix'.log(tag: 'DEBUG');
              },
              child: const Text('Log to Debug Console'),
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
