import 'package:flutter/material.dart';
import 'package:share_specified_app_example/enums/other_app.dart';
import 'package:share_specified_app_example/widgets/svg_asset_icon.dart';

class OtherAppLogo extends StatelessWidget {
  const OtherAppLogo({
    super.key,
    required this.app,
    this.size = 60,
    this.radius,
  });

  final OtherApp app;
  final double size;
  final BorderRadius? radius;

  double get logoSize => size - 8 > 0 ? size - 8 : 0;

  BorderRadius get defaultRadius => BorderRadius.circular(12);

  BorderRadius get finalRadius => radius ?? defaultRadius;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size,
      width: size,
      child: Center(
        child: Container(
          decoration: BoxDecoration(
            // 需要为百度网盘添加边框，否则和阿里云盘对比会显得图标小
            border: app == OtherApp.baidu
                ? Border.all(
                    color: Theme.of(context).hintColor.withOpacity(0.1),
                    width: 0.8)
                : null,
            borderRadius: finalRadius,
          ),
          child: ClipRRect(
            borderRadius: finalRadius,
            child: SvgAssetIcon(
              assetPath: app.assetPath,
              banColor: true,
              size: logoSize,
            ),
          ),
        ),
      ),
    );
  }
}
