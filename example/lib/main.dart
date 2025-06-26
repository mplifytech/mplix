import 'package:flutter/cupertino.dart';
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
            ).fadeIn()
                .paddingAll(8)
                .asCard(),

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
            Image.network(
              'https://picsum.photos/300/200',
              fit: BoxFit.cover,
            )
                .clipRounded(16)
                .onImageTapPreview(context,imageProvider: NetworkImage('https://picsum.photos/300/200')),

            20.spacingY(),
            _sectionTitle('🎞️ Animation & Effects Extensions'),

            Text('This fades in nicely')
                .fadeIn()
                .paddingAll(8)
                .asCard(),

            10.spacingY(),

            Icon(CupertinoIcons.heart_fill, color: Colors.red, size: 80)
                .tapScale(onTap: () => '❤️ Liked!'.log()),


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
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ).blurred(sigma: 8),
                  ),
                ),
              ],
            ).clipRounded(12).paddingAll(8),

            10.spacingY(),
            Text(
              'Beautiful Glass Card',
              style: const TextStyle(fontSize: 18, color: Colors.white),
            ).asGlassCard(height: 300,width: 300,color: Colors.pinkAccent.withValues(alpha: 0.3)),

            10.spacingY(),
            Text('Soft UI')
                .asNeumorphic()
                .paddingAll(16),

            Text('Gradient Card')
                .asGradientCard(colors: [Colors.orange, Colors.deepOrange])
                .paddingAll(16),


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
