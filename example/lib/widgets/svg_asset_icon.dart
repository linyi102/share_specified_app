import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SvgAssetIcon extends StatelessWidget {
  final String assetPath;
  final double? size;
  final Color? color;
  final bool banColor;

  const SvgAssetIcon({
    super.key,
    required this.assetPath,
    this.size,
    this.color,
    this.banColor = false,
  });

  @override
  Widget build(BuildContext context) {
    var size = this.size ?? Theme.of(context).iconTheme.size ?? 24;

    return SvgPicture.asset(
      assetPath,
      height: size,
      width: size,
      // 夜间模式若不指定colorFilter，则看不清图标，因此color默认是iconTheme中的color
      color: banColor
          ? null
          : color ??
              Theme.of(context).iconTheme.color ??
              Theme.of(context).primaryColor,
    );
  }
}
