import 'package:flutter/material.dart';

import 'package:flutter_wallpaper_android/flutter_wallpaper.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _picker = ImagePicker();
  final _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Column(
          children: [
            ElevatedButton(
              onPressed: () async {
                final platform = Theme.of(context).platform;
                final image =
                    await _picker.pickImage(source: ImageSource.gallery);
                if (image != null) {
                  await setWallpaperFromImagePath(
                    path: image.path,
                    type: PreferredWallpaperType.home,
                    platform: platform,
                  );
                }
              },
              child: const Text('Set wallpaper from a file'),
            ),
            const Divider(),
            TextField(
              controller: _textEditingController,
            ),
            ElevatedButton(
              onPressed: () async {
                final url = _textEditingController.text;
                final platform = Theme.of(context).platform;

                await setWallpaperFromNetworkImage(
                  imageUrl: url,
                  type: PreferredWallpaperType.home,
                  platform: platform,
                );
              },
              child: const Text('Set wallpaper from URL'),
            ),
          ],
        ),
      ),
    );
  }
}
