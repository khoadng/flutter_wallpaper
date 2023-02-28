import 'flutter_wallpaper_android_platform_interface.dart';

class FlutterWallpaperAndroid {
  Future<bool> setWallpaperFromUrl(String url) {
    return FlutterWallpaperAndroidPlatform.instance.setWallpaperFromUrl(url);
  }

  Future<String?> getPlatformVersion() {
    return FlutterWallpaperAndroidPlatform.instance.getPlatformVersion();
  }
}
