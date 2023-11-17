import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'share_specified_app_method_channel.dart';

abstract class ShareSpecifiedAppPlatform extends PlatformInterface {
  /// Constructs a ShareSpecifiedAppPlatform.
  ShareSpecifiedAppPlatform() : super(token: _token);

  static final Object _token = Object();

  static ShareSpecifiedAppPlatform _instance = MethodChannelShareSpecifiedApp();

  /// The default instance of [ShareSpecifiedAppPlatform] to use.
  ///
  /// Defaults to [MethodChannelShareSpecifiedApp].
  static ShareSpecifiedAppPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [ShareSpecifiedAppPlatform] when
  /// they register themselves.
  static set instance(ShareSpecifiedAppPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<void> shareFile({
    required String path,
    required String packageName,
    String title = "分享",
    void Function()? whenNotFoundApp,
  }) {
    throw UnimplementedError('shareFile() has not been implemented.');
  }
}
