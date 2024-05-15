package com.lyell.brick

import android.content.Context
import android.util.Log
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

/** BrickPlugin */
class BrickPlugin : FlutterPlugin, MethodCallHandler {
    /// The MethodChannel that will the communication between Flutter and native Android
    ///
    /// This local reference serves to register the plugin with the Flutter Engine and unregister it
    /// when the Flutter Engine is detached from the Activity
    private lateinit var channel: MethodChannel

    private lateinit var applicationContext: Context

    companion object {
        const val TAG = "BrickPlugin"
    }

    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        applicationContext = flutterPluginBinding.applicationContext
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "brick_channel")
        channel.setMethodCallHandler(this)
    }

    override fun onMethodCall(call: MethodCall, result: Result) {
        when (call.method) {
            "getPlatformVersion" -> {
                result.success("Android ${android.os.Build.VERSION.RELEASE}")
            }

            "startActivityWithPackage" -> {
                val openName = call.argument<String?>("package")
                if (openName.isNullOrEmpty()) {
                    return
                }
                if (isAppInstalled(openName)) {
                    val openIntent =
                        applicationContext.packageManager.getLaunchIntentForPackage(
                            openName
                        )
                    applicationContext.startActivity(openIntent)
                } else {
                    Log.i(TAG, "onMethodCall: this package not installed")
                }
            }

            "isPackageInstalled" -> {
                val openName = call.argument<String?>("package")
                if (openName.isNullOrEmpty()) {
                    return
                }
                val installed = isAppInstalled(openName)
                result.success(installed)
            }

            else -> {
                result.notImplemented()
            }
        }

    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }

    private fun isAppInstalled(packageName: String): Boolean {
        val openIntent =
            applicationContext.packageManager.getLaunchIntentForPackage(packageName)
        return openIntent != null
    }
}
