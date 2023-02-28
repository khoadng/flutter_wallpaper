import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'flutter_wallpaper_android_platform_interface.dart';

/// An implementation of [FlutterWallpaperAndroidPlatform] that uses method channels.
class MethodChannelFlutterWallpaperAndroid
    extends FlutterWallpaperAndroidPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('flutter_wallpaper_android');

  @override
  Future<String?> getPlatformVersion() async {
    final version =
        await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }

  @override
  Future<bool> setWallpaperFromUrl(String url) {
    return methodChannel.invokeMethod<bool>(
      'setWallpaperFromUrl',
      <String, Object>{'url': url},
    ).then((bool? value) => value ?? false);
  }
}
