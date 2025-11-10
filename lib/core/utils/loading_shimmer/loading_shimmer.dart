import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class LoadingShimmer extends StatelessWidget {
  const LoadingShimmer({
    super.key,
    required this.child,
    this.color,
    this.enable = true,
  });

  final Widget child;
  final bool enable;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Shimmer(
      enabled: enable,
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          color ?? const Color(0xFF606060),
          color ?? const Color(0xFF606060),
        ],
      ),
      child: child,
    );
  }
}
