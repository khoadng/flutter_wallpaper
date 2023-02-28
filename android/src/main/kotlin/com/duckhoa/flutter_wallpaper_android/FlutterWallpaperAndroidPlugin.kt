package com.duckhoa.flutter_wallpaper_android

import android.app.WallpaperManager
import android.content.Context
import android.graphics.BitmapFactory
import android.os.Build
import android.util.Log
import androidx.annotation.NonNull
import androidx.annotation.RequiresApi

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import java.io.File
import java.io.FileNotFoundException

/** FlutterWallpaperAndroidPlugin */
class FlutterWallpaperAndroidPlugin: FlutterPlugin, MethodCallHandler {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private lateinit var channel : MethodChannel
  private lateinit var context: Context

  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "flutter_wallpaper_android")
    channel.setMethodCallHandler(this)
    context = flutterPluginBinding.applicationContext
  }

  override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
    when (call.method) {
        "getPlatformVersion" -> {
          result.success("Android ${Build.VERSION.RELEASE}")
        }
        "setWallpaperFromUrl" -> {
          Log.d("Flutter Wallpaper","setWallpaperFromUrl invoked");
          val url: String? = call.argument("path")
          setWallpaperFromUrl(url)
        }
        else -> {
          result.notImplemented()
        }
    }
  }

  private fun setWallpaperFromUrl(url: String?): Boolean {
    return try {
      if (url == null)
        throw NullPointerException()

      when {
        Build.VERSION.SDK_INT >= Build.VERSION_CODES.N -> setWallpaper(url, isHomeScreen = true, isLockScreen = false)
        else -> false
      }

    } catch (e: Exception) {
      return false;
    }
  }


  @RequiresApi(Build.VERSION_CODES.N)
  fun setWallpaper(filePath: String, isHomeScreen: Boolean, isLockScreen: Boolean) : Boolean {
    val wallpaperManager = WallpaperManager.getInstance(context)
    val wallpaperFile = File(filePath)

    return if (wallpaperFile.exists()) {
      val bitmap = BitmapFactory.decodeFile(wallpaperFile.absolutePath)
      val wallpaperType = when {
        isLockScreen -> WallpaperManager.FLAG_LOCK
        isHomeScreen -> WallpaperManager.FLAG_SYSTEM
        else -> WallpaperManager.FLAG_SYSTEM or WallpaperManager.FLAG_LOCK
      }
      wallpaperManager.setBitmap(bitmap, null, true, wallpaperType)

      true;
    } else {
      false;
      // throw FileNotFoundException("Wallpaper file not found")
    }
  }

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }
}