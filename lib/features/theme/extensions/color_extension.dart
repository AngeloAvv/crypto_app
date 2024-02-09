import 'package:flutter/material.dart';

extension ColorBuildContextExtension on BuildContext {
  ColorExtension? get colors => Theme.of(this).extension<ColorExtension>();
}

class ColorExtension extends ThemeExtension<ColorExtension> {
  final Color? rising;
  final Color? falling;
  final Color? neutral;

  const ColorExtension({
    required this.rising,
    required this.falling,
    this.neutral,
  });

  @override
  ThemeExtension<ColorExtension> copyWith() => ColorExtension(
        rising: rising,
        falling: falling,
        neutral: neutral,
      );

  @override
  ThemeExtension<ColorExtension> lerp(
    covariant ThemeExtension<ColorExtension>? other,
    double t,
  ) {
    if (other is! ColorExtension) {
      return this;
    }

    return ColorExtension(
      rising: Color.lerp(rising, other.rising, t),
      falling: Color.lerp(falling, other.falling, t),
      neutral: Color.lerp(neutral, other.neutral, t),
    );
  }
}
