import 'dart:ui';

extension ColorOpacityExtension on Color {
  Color withOpacityValue(double opacity) {
    return withAlpha((opacity * 255).round());
  }
}
