import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'flutter_wallpaper_android_method_channel.dart';

abstract class FlutterWallpaperAndroidPlatform extends PlatformInterface {
  /// Constructs a FlutterWallpaperAndroidPlatform.
  FlutterWallpaperAndroidPlatform() : super(token: _token);

  static final Object _token = Object();

  static FlutterWallpaperAndroidPlatform _instance =
      MethodChannelFlutterWallpaperAndroid();

  /// The default instance of [FlutterWallpaperAndroidPlatform] to use.
  ///
  /// Defaults to [MethodChannelFlutterWallpaperAndroid].
  static FlutterWallpaperAndroidPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [FlutterWallpaperAndroidPlatform] when
  /// they register themselves.
  static set instance(FlutterWallpaperAndroidPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  Future<bool> setWallpaperFromUrl(String url) {
    throw UnimplementedError('setWallpaperFromUrl() has not been implemented.');
  }
}
