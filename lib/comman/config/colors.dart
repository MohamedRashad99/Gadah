import 'package:flutter/material.dart';

class AppColors {
  static const superLightGreen = Color(0xFF9EF6FC);
  static const superLightGreenAccent = Color(0xFFBED9C1);
  static const fancyGreen = Color(0xFF00CCAA);
  static const lightTextGreen = Color(0xFFE6FF00);
  static const lightDarkGreen = Color(0xFFACFA05);
  static const lightGreenAccent = Color(0xFF97ED12);
  static const lightGreenAccent2 = Color(0xFF9046F3);
  static const boldLightGreen = Color(0xFF5DC400);
  static const lightGreenAccent3 = Color(0xFFC839CB);
  static const lightGreen = Color(0xFFaa7bed);
  static const paleLightGreen = Color(0xFF317F44);
  static const darkGreen = Color(0xFF2E8BA2);
  static const darkGreenAccent = Color(0xFF691975);
  static const greyeshDarkGreen = Color(0xFF2591B1);
  static const palehDarkGreen = Color(0xFF2B8869);
  static const bloodRed = Color(0xFFFF0000);
  static const coldBloodRed = Color(0xFFDC3130);
  static const lightBlack = Color(0xFFABABAB);
  static const boldBlackAccent = Color(0xFF606060);
  static const boldBlack = Color(0xFF302F2F);
  static const lightBlue = Color(0xFF4A189B);
  static const lightBlueAccent = Color(0xFF057477);
  static const darkBlue = Color(0xFF02323D);
  static const veryLightTransparentBlue = Color(0xFF033436);
  static const darkWhite = Color(0xFFEDEAE6);
  static const darkWhiteAccent = Color(0xFFF5F5F5);
  static const white = Colors.white;
  static const transparent = Colors.transparent;

  static LinearGradient famousGradient({
    AlignmentGeometry begin = Alignment.centerRight,
    AlignmentGeometry end = Alignment.centerLeft,
    GradientTransform? transform,
    TileMode tileMode = TileMode.clamp,
  }) {
    return LinearGradient(
      colors: const [
        Color(0xff9B4DF4),
        Color(0xff412582),
      ],
      begin: begin,
      end: end,
      transform: transform,
      tileMode: tileMode,
    );
  }

  static LinearGradient chatBubbleGradient({
    AlignmentGeometry begin = Alignment.topCenter,
    AlignmentGeometry end = Alignment.bottomCenter,
    GradientTransform? transform,
    TileMode tileMode = TileMode.clamp,
  }) {
    return LinearGradient(
      colors: const [
        Color(0xff12A5AA),
        Color(0xff06797C),
      ],
      begin: begin,
      end: end,
      transform: transform,
      tileMode: tileMode,
    );
  }

  static LinearGradient famousGradientOrder({
    AlignmentGeometry begin = Alignment.centerRight,
    AlignmentGeometry end = Alignment.centerLeft,
    GradientTransform? transform,
    TileMode tileMode = TileMode.clamp,
  }) {
    return LinearGradient(
      colors: const [
        Color(0xffF3CCF6),
        Color(0xffD8E4F8),
      ],
      begin: begin,
      end: end,
      transform: transform,
      tileMode: tileMode,
    );
  }

  static LinearGradient famousGradientLinearProgressIndicator({
    AlignmentGeometry begin = Alignment.centerRight,
    AlignmentGeometry end = Alignment.centerLeft,
    GradientTransform? transform,
    TileMode tileMode = TileMode.clamp,
  }) {
    return LinearGradient(
      colors: const [
        superLightGreen,
        Color(0xff35A8B5),
      ],
      begin: begin,
      end: end,
      transform: transform,
      tileMode: tileMode,
    );
  }

  static LinearGradient famousGradientLinearProgressIndicatorBackground({
    AlignmentGeometry begin = Alignment.topCenter,
    AlignmentGeometry end = Alignment.bottomCenter,
    GradientTransform? transform,
    TileMode tileMode = TileMode.clamp,
  }) {
    return LinearGradient(
      colors: const [
        Color(0xffDBDBDB),
        Color(0xffBDBDBD),
      ],
      begin: begin,
      end: end,
      transform: transform,
      tileMode: tileMode,
    );
  }
}
