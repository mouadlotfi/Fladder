import 'package:flutter/material.dart';

class MediaQueryScaler extends StatelessWidget {
  final Widget child;
  final bool enable;
  final double leanBackScale;
  final double uiScale;

  const MediaQueryScaler({
    required this.child,
    required this.enable,
    this.leanBackScale = 1.3,
    this.uiScale = 1.0,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveScale = (enable ? leanBackScale : 1.0) * uiScale;
    if (effectiveScale == 1.0) return child;

    final mediaQuery = MediaQuery.of(context);
    final screenSize = MediaQuery.sizeOf(context) * effectiveScale;

    final scaledMedia = mediaQuery.copyWith(
      size: screenSize,
      padding: mediaQuery.padding * effectiveScale,
      viewInsets: mediaQuery.viewInsets * effectiveScale,
      viewPadding: mediaQuery.viewPadding * effectiveScale,
      devicePixelRatio: mediaQuery.devicePixelRatio * effectiveScale,
    );

    return FittedBox(
      alignment: Alignment.center,
      child: SizedBox(
        width: screenSize.width,
        height: screenSize.height,
        child: MediaQuery(data: scaledMedia, child: child),
      ),
    );
  }
}
