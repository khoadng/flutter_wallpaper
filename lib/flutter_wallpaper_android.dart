import 'package:flutter_wallpaper_android/src/types.dart';

import 'flutter_wallpaper_android_platform_interface.dart';

class FlutterWallpaperAndroid {
  Future<bool> setWallpaperFromImagePath(
      String url, PreferredWallpaperType type) {
    return FlutterWallpaperPlatform.instance.setWallpaperFromImagePath(
      url,
      type,
    );
  }

  Future<String?> getPlatformVersion() {
    return FlutterWallpaperPlatform.instance.getPlatformVersion();
  }
}
