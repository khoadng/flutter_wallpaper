import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'flutter_wallpaper_android_method_channel.dart';
import 'src/types.dart';

abstract class FlutterWallpaperPlatform extends PlatformInterface {
  /// Constructs a FlutterWallpaperAndroidPlatform.
  FlutterWallpaperPlatform() : super(token: _token);

  static final Object _token = Object();

  static FlutterWallpaperPlatform _instance =
      MethodChannelFlutterWallpaperAndroid();

  /// The default instance of [FlutterWallpaperPlatform] to use.
  ///
  /// Defaults to [MethodChannelFlutterWallpaperAndroid].
  static FlutterWallpaperPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [FlutterWallpaperPlatform] when
  /// they register themselves.
  static set instance(FlutterWallpaperPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  Future<bool> setWallpaperFromImagePath(
      String path, PreferredWallpaperType type) {
    throw UnimplementedError(
        'setWallpaperFromImagePath() has not been implemented.');
  }
}
