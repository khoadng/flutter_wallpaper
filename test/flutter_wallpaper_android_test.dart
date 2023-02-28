// import 'package:flutter_test/flutter_test.dart';
// import 'package:flutter_wallpaper_android/flutter_wallpaper_android.dart';
// import 'package:flutter_wallpaper_android/flutter_wallpaper_android_platform_interface.dart';
// import 'package:flutter_wallpaper_android/flutter_wallpaper_android_method_channel.dart';
// import 'package:plugin_platform_interface/plugin_platform_interface.dart';

// class MockFlutterWallpaperAndroidPlatform
//     with MockPlatformInterfaceMixin
//     implements FlutterWallpaperAndroidPlatform {

//   @override
//   Future<String?> getPlatformVersion() => Future.value('42');
// }

// void main() {
//   final FlutterWallpaperAndroidPlatform initialPlatform = FlutterWallpaperAndroidPlatform.instance;

//   test('$MethodChannelFlutterWallpaperAndroid is the default instance', () {
//     expect(initialPlatform, isInstanceOf<MethodChannelFlutterWallpaperAndroid>());
//   });

//   test('getPlatformVersion', () async {
//     FlutterWallpaperAndroid flutterWallpaperAndroidPlugin = FlutterWallpaperAndroid();
//     MockFlutterWallpaperAndroidPlatform fakePlatform = MockFlutterWallpaperAndroidPlatform();
//     FlutterWallpaperAndroidPlatform.instance = fakePlatform;

//     expect(await flutterWallpaperAndroidPlugin.getPlatformVersion(), '42');
//   });
// }
