import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'flutter_wallpaper_android_platform_interface.dart';
import 'src/types.dart';

/// An implementation of [FlutterWallpaperPlatform] that uses method channels.
class MethodChannelFlutterWallpaperAndroid extends FlutterWallpaperPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('flutter_wallpaper_android');

  @override
  Future<bool> setWallpaperFromImagePath(
    String path,
    PreferredWallpaperType type,
  ) {
    return methodChannel.invokeMethod<bool>(
      'setWallpaperFromImagePath',
      <String, Object>{
        'path': path,
        'type': type.index,
      },
    ).then((bool? value) => value ?? false);
  }

  @override
  Future<String?> getPlatformVersion() async {
    final version =
        await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
