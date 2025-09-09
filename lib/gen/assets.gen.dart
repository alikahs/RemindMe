// dart format width=80

/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: deprecated_member_use,directives_ordering,implicit_dynamic_list_literal,unnecessary_import

import 'package:flutter/widgets.dart';

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/Group 1.png
  AssetGenImage get group1 => const AssetGenImage('assets/images/Group 1.png');

  /// File path: assets/images/cewe.png
  AssetGenImage get cewe => const AssetGenImage('assets/images/cewe.png');

  /// File path: assets/images/cowo.png
  AssetGenImage get cowo => const AssetGenImage('assets/images/cowo.png');

  /// File path: assets/images/icon_back.png
  AssetGenImage get iconBackPng =>
      const AssetGenImage('assets/images/icon_back.png');

  /// File path: assets/images/icon_back.svg
  String get iconBackSvg => 'assets/images/icon_back.svg';

  /// File path: assets/images/icon_back_white.svg
  String get iconBackWhite => 'assets/images/icon_back_white.svg';

  /// File path: assets/images/icon_date.svg
  String get iconDate => 'assets/images/icon_date.svg';

  /// File path: assets/images/icon_login.svg
  String get iconLogin => 'assets/images/icon_login.svg';

  /// File path: assets/images/icon_logout.svg
  String get iconLogout => 'assets/images/icon_logout.svg';

  /// File path: assets/images/icon_play_time.svg
  String get iconPlayTime => 'assets/images/icon_play_time.svg';

  /// File path: assets/images/icon_timer.png
  AssetGenImage get iconTimerPng =>
      const AssetGenImage('assets/images/icon_timer.png');

  /// File path: assets/images/icon_timer.svg
  String get iconTimerSvg => 'assets/images/icon_timer.svg';

  /// File path: assets/images/signin_background.png
  AssetGenImage get signinBackground =>
      const AssetGenImage('assets/images/signin_background.png');

  /// List of all assets
  List<dynamic> get values => [
    group1,
    cewe,
    cowo,
    iconBackPng,
    iconBackSvg,
    iconBackWhite,
    iconDate,
    iconLogin,
    iconLogout,
    iconPlayTime,
    iconTimerPng,
    iconTimerSvg,
    signinBackground,
  ];
}

class Assets {
  const Assets._();

  static const String aEnv = 'assets/.env';
  static const $AssetsImagesGen images = $AssetsImagesGen();

  /// List of all assets
  static List<String> get values => [aEnv];
}

class AssetGenImage {
  const AssetGenImage(
    this._assetName, {
    this.size,
    this.flavors = const {},
    this.animation,
  });

  final String _assetName;

  final Size? size;
  final Set<String> flavors;
  final AssetGenImageAnimation? animation;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = true,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.medium,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({AssetBundle? bundle, String? package}) {
    return AssetImage(_assetName, bundle: bundle, package: package);
  }

  String get path => _assetName;

  String get keyName => _assetName;
}

class AssetGenImageAnimation {
  const AssetGenImageAnimation({
    required this.isAnimation,
    required this.duration,
    required this.frames,
  });

  final bool isAnimation;
  final Duration duration;
  final int frames;
}
