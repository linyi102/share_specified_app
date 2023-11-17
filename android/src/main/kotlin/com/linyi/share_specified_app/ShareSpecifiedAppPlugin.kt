package com.linyi.share_specified_app

import android.content.Context
import android.content.Intent
import android.content.pm.PackageManager
import android.os.Build
import androidx.core.content.ContextCompat.startActivity
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import java.io.File

/** ShareSpecifiedAppPlugin */
class ShareSpecifiedAppPlugin: FlutterPlugin, MethodCallHandler {
  private lateinit var channel: MethodChannel
  private lateinit var context: Context

  override fun onAttachedToEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    context = binding.applicationContext
    channel = MethodChannel(binding.binaryMessenger, "share_specified_app")
    channel.setMethodCallHandler(this)
  }

  override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }

  override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
    if (call.method == "shareFile") {
      shareFile(
        call.argument<String>("path")!!,
        call.argument<String>("packageName")!!,
        call.argument<String>("title")!!,
        result,
      )
    } else {
      result.notImplemented()
    }
  }

  private fun shareFile(
    path: String,
    packageName: String,
    title: String,
    result: MethodChannel.Result
  ) {
    val file = File(path)
    var shareIntent = Intent()
    val uri = FileUtils.getUriForFile(context, file)

    shareIntent.apply {
      action = Intent.ACTION_SEND
      type = "*/*"
      putExtra(Intent.EXTRA_STREAM, uri)
      addFlags(Intent.FLAG_GRANT_READ_URI_PERMISSION)
      setPackage(packageName)
    }

    // 获取该intent可匹配的应用列表
    val flagValue = PackageManager.GET_ACTIVITIES
    val appList = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.TIRAMISU) {
      context.packageManager.queryIntentActivities(
        shareIntent,
        PackageManager.ResolveInfoFlags.of(flagValue.toLong())
      )
    } else {
      context.packageManager.queryIntentActivities(shareIntent, flagValue)
    }

    if (appList.isEmpty()) {
      result.error("UNAVAILABLE", "没有找到${packageName}对应的App", null)
      return
    }

    shareIntent = Intent.createChooser(shareIntent, title)

    // 在创建chooser之后，再添加flag：FLAG_ACTIVITY_NEW_TASK，否则提示：
    // android.util.AndroidRuntimeException: Calling startActivity() from outside of an Activity  context requires the FLAG_ACTIVITY_NEW_TASK flag. Is this really what you want?
    shareIntent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)

    startActivity(context, shareIntent, null)
    result.success(null)
  }
}