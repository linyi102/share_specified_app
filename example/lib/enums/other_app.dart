import 'package:share_specified_app_example/generated/assets.dart';

enum OtherApp {
  ali(
    title: '阿里云盘',
    packageName: 'com.alicloud.databox',
    assetPath: Assets.iconsAliyundrive,
  ),
  baidu(
    title: '百度网盘',
    packageName: 'com.baidu.netdisk',
    assetPath: Assets.iconsBaiduyunpan,
  ),
  qq(
    title: 'QQ',
    packageName: 'com.tencent.mobileqq',
    assetPath: Assets.iconsQq,
  ),
  wechat(
    title: '微信',
    packageName: 'com.tencent.mm',
    assetPath: Assets.iconsWechat,
  );

  final String title;
  final String packageName;
  final String assetPath;

  const OtherApp(
      {required this.title,
      required this.packageName,
      required this.assetPath});
}
