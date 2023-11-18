import 'share_specified_app_platform_interface.dart';

class ShareSpecifiedApp {
  Future<void> shareFile({
    required String path,
    required String packageName,
    String title = "分享",
    void Function()? whenNotFoundApp,
  }) {
    return ShareSpecifiedAppPlatform.instance.shareFile(
        path: path,
        packageName: packageName,
        title: title,
        whenNotFoundApp: whenNotFoundApp);
  }
}
