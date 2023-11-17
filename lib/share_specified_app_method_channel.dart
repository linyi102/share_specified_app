import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'share_specified_app_platform_interface.dart';

/// An implementation of [ShareSpecifiedAppPlatform] that uses method channels.
class MethodChannelShareSpecifiedApp extends ShareSpecifiedAppPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('share_specified_app');

  @override
  Future<void> shareFile({
    required String path,
    required String packageName,
    String title = "分享",
    void Function()? whenNotFoundApp,
  }) async {
    try {
      await methodChannel.invokeMethod('shareFile', {
        'path': path,
        'packageName': packageName,
        'title': title,
      });
    } on PlatformException catch (e) {
      if (e.code == 'UNAVAILABLE') whenNotFoundApp?.call();
    }
  }
}
