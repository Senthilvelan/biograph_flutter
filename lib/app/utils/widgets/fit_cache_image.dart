import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';


class FitCacheImage extends CachedNetworkImage {
  final String imageUrl;
  final String? cacheKey;
  final ImageWidgetBuilder? imageBuilder;

  final ProgressIndicatorBuilder? progressIndicatorBuilder;

  final Duration? placeholderFadeInDuration;
  final Duration? fadeOutDuration;
  final Curve fadeOutCurve;
  final Duration fadeInDuration;

  final Curve fadeInCurve;

  final double? width;

  final double? height;

  final BoxFit? fit;

  final Alignment alignment;
  final ImageRepeat repeat;

  final bool matchTextDirection;
  final Map<String, String>? httpHeaders;
  final bool useOldImageOnUrlChange;
  final Color? color;
  final BlendMode? colorBlendMode;
  final FilterQuality filterQuality;
  final int? memCacheWidth;
  final int? memCacheHeight;
  final int? maxWidthDiskCache;
  final int? maxHeightDiskCache;

  // final PlaceholderWidgetBuilder? placeholder;
  // final LoadingErrorWidgetBuilder? errorWidget;

  FitCacheImage({
    // Key? key,
    required this.imageUrl,
    this.httpHeaders,
    this.imageBuilder,
    this.progressIndicatorBuilder,
    this.fadeOutDuration = const Duration(milliseconds: 1000),
    this.fadeOutCurve = Curves.easeOut,
    this.fadeInDuration = const Duration(milliseconds: 700),
    this.fadeInCurve = Curves.easeIn,
    this.width,
    this.height,
    this.fit,
    this.alignment = Alignment.center,
    this.repeat = ImageRepeat.noRepeat,
    this.matchTextDirection = false,
    this.useOldImageOnUrlChange = false,
    this.color,
    this.filterQuality = FilterQuality.low,
    this.colorBlendMode,
    this.placeholderFadeInDuration,
    this.memCacheWidth,
    this.memCacheHeight,
    this.cacheKey,
    this.maxWidthDiskCache,
    this.maxHeightDiskCache,
    // this.placeholder,
    // this.errorWidget,
    // this.cacheManager,
  }) : super(
          key: Key(imageUrl),
          imageUrl: imageUrl,
          httpHeaders: httpHeaders,
          imageBuilder: imageBuilder,
          progressIndicatorBuilder: progressIndicatorBuilder,
          fadeOutDuration: fadeOutDuration,
          fadeOutCurve: fadeOutCurve,
          fadeInDuration: fadeInDuration,
          fadeInCurve: fadeInCurve,
          width: width,
          height: height,
          fit: fit,
          alignment: alignment,
          repeat: repeat,
          matchTextDirection: matchTextDirection,
          useOldImageOnUrlChange: useOldImageOnUrlChange,
          color: color,
          filterQuality: filterQuality,
          colorBlendMode: colorBlendMode,
          placeholderFadeInDuration: placeholderFadeInDuration,
          memCacheWidth: memCacheWidth,
          memCacheHeight: memCacheHeight,
          cacheKey: cacheKey,
          maxWidthDiskCache: maxWidthDiskCache,
          maxHeightDiskCache: maxHeightDiskCache,

          placeholder: (context, url) =>
              CircularProgressIndicator(color: Colors.transparent),
          errorWidget: (context, url, error) => Icon(
            Icons.ac_unit,
            color: Colors.white54,
          ),
          /*   imageBuilder: (context, imageProvider) => Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: imageProvider,
                  fit: fit,
                  colorFilter:
                      ColorFilter.mode(Colors.red, BlendMode.colorBurn)),
            ),
          ),*/
          // placeholder: (context, url) => LoadingWaitImageWidget(),
          // progressIndicatorBuilder: (context, url, downloadProgress) =>
          //     CircularProgressIndicator(value: downloadProgress.progress),
        );
}
