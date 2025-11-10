import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../core.dart';

class ImageController extends StatelessWidget {
  final String? path;
  final String? pathErrorAsset;
  final Color? shimmer;
  final Alignment? alignment;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final Color? svgColor;
  final Color? background;
  final double? height;
  final double? width;
  final BoxFit? fit;

  const ImageController(
    this.path, {
    super.key,
    this.svgColor,
    this.background,
    this.alignment,
    this.height,
    this.width,
    this.fit,
    this.padding,
    this.margin,
    this.shimmer,
    this.pathErrorAsset,
  });

  @override
  Widget build(BuildContext context) {
    final String resolvedPath = (path ?? '').trim();

    if (resolvedPath.isEmpty) return const SizedBox.shrink();

    return Container(
      padding: padding ?? EdgeInsets.zero,
      margin: margin ?? EdgeInsets.zero,
      color: background ?? Colors.transparent,
      child: _buildImage(resolvedPath),
    );
  }

  Widget _buildImage(String resolvedPath) {
    if (resolvedPath.contains('.svg')) {
      return resolvedPath.contains('https')
          ? SvgPicture.network(
            resolvedPath,
            color: svgColor ?? Colors.transparent,
            width: width,
            height: height,
            fit: fit ?? BoxFit.contain,
            placeholderBuilder:
                (_) => LoadingShimmer(
                  color: shimmer ?? Colors.grey.shade300,
                  child: SizedBox(width: width, height: height),
                ),
          )
          : SvgPicture.asset(
            resolvedPath,
            colorFilter:
                svgColor != null
                    ? ColorFilter.mode(svgColor!, BlendMode.srcIn)
                    : null,
            width: width,
            height: height,
            fit: fit ?? BoxFit.contain,
            allowDrawingOutsideViewBox: true,
          );
    }

    if (resolvedPath.contains('https')) {
      return CachedNetworkImage(
        imageUrl: resolvedPath,
        width: width,
        height: height,
        color: svgColor,
        progressIndicatorBuilder:
            (_, __, ___) => LoadingShimmer(
              color: shimmer ?? Colors.grey.shade300,
              child: SizedBox(width: width, height: height),
            ),
        fit: fit ?? BoxFit.cover,
        errorWidget:
            (_, __, ___) =>
                pathErrorAsset == null
                    ? SizedBox(width: width, height: height)
                    : Image.asset(
                      pathErrorAsset!,
                      width: width,
                      height: height,
                      fit: fit ?? BoxFit.contain,
                      filterQuality: FilterQuality.none,
                    ),
      );
    }

    if (_shouldUseFile(resolvedPath)) {
      return Image.file(
        File(resolvedPath),
        width: width,
        height: height,
        fit: fit ?? BoxFit.cover,
      );
    }

    return Image.asset(
      resolvedPath,
      width: width,
      height: height,
      fit: fit ?? BoxFit.contain,
    );
  }

  bool _shouldUseFile(String path) {
    return File(path).existsSync();
  }
}
