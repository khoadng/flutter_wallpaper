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
        "setWallpaperFromImagePath" -> {
          val path: String? = call.argument("path")
          val typeInt: Int = call.argument("type") ?: throw Exception("Type is null")
          val type = when (typeInt) {
              0 -> WallpaperType.HOME
              1 -> WallpaperType.LOCK
              else -> WallpaperType.HOME
          }

          val success = setWallpaperFromImagePath(path, type)

          return if (success) {
            result.success(true)
          } else {
            result.success(false)
          }
        }
        else -> {
          result.notImplemented()
        }
    }
  }

  enum class WallpaperType {
    HOME,
    LOCK,
  }

  private fun setWallpaperFromImagePath(path: String?, type: WallpaperType): Boolean {
     try {
      if (path == null)
        throw NullPointerException()

       return if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.N) {
         setWallpaper(path, type)
       } else {
         false;
       }

    } catch (e: Exception) {
      throw e
    }
  }


  @RequiresApi(Build.VERSION_CODES.N)
  fun setWallpaper(filePath: String, type: WallpaperType) : Boolean {
    val wallpaperManager = WallpaperManager.getInstance(context)
    val wallpaperFile = File(filePath)


    return if (wallpaperFile.exists()) {
      val bitmap = BitmapFactory.decodeFile(wallpaperFile.absolutePath)

      val wallpaperType = when (type) {
        WallpaperType.HOME -> WallpaperManager.FLAG_SYSTEM
        WallpaperType.LOCK -> WallpaperManager.FLAG_LOCK
      }

      wallpaperManager.setBitmap(bitmap, null, true, wallpaperType)

      true;
    } else {
      throw FileNotFoundException("Wallpaper file not found")
    }
  }

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }
}
