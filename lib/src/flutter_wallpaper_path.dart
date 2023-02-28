import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_wallpaper_android/flutter_wallpaper_android.dart';
import 'package:flutter_wallpaper_android/src/types.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

Future<bool> setWallpaperFromImagePath({
  required String path,
  required PreferredWallpaperType type,
  required TargetPlatform platform,
}) {
  return FlutterWallpaperAndroid().setWallpaperFromImagePath(
    path,
    type,
  );
}

Future<bool> setWallpaperFromNetworkImage({
  required String imageUrl,
  required PreferredWallpaperType type,
  required TargetPlatform platform,
}) async {
  final response = await http.get(Uri.parse(imageUrl));
  final fileName = path.basename(imageUrl);

  final documentDirectory = await getApplicationDocumentsDirectory();
  final file = File(path.join(
    documentDirectory.path,
    fileName,
  ));
  final result = await file.writeAsBytes(response.bodyBytes);

  return setWallpaperFromImagePath(
    path: result.path,
    type: type,
    platform: platform,
  );
}
