import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

class UnifyThemeColors extends ThemeExtension<UnifyThemeColors> {
  const UnifyThemeColors({
    required this.border,
    required this.mutedForeground,
    required this.surfaceMuted,
    required this.accentDeep,
    required this.moss,
  });

  final Color border;
  final Color mutedForeground;
  final Color surfaceMuted;
  final Color accentDeep;
  final Color moss;

  @override
  UnifyThemeColors copyWith({
    Color? border,
    Color? mutedForeground,
    Color? surfaceMuted,
    Color? accentDeep,
    Color? moss,
  }) {
    return UnifyThemeColors(
      border: border ?? this.border,
      mutedForeground: mutedForeground ?? this.mutedForeground,
      surfaceMuted: surfaceMuted ?? this.surfaceMuted,
      accentDeep: accentDeep ?? this.accentDeep,
      moss: moss ?? this.moss,
    );
  }

  @override
  UnifyThemeColors lerp(ThemeExtension<UnifyThemeColors>? other, double t) {
    if (other is! UnifyThemeColors) {
      return this;
    }

    return UnifyThemeColors(
      border: Color.lerp(border, other.border, t) ?? border,
      mutedForeground:
          Color.lerp(mutedForeground, other.mutedForeground, t) ??
              mutedForeground,
      surfaceMuted:
          Color.lerp(surfaceMuted, other.surfaceMuted, t) ?? surfaceMuted,
      accentDeep: Color.lerp(accentDeep, other.accentDeep, t) ?? accentDeep,
      moss: Color.lerp(moss, other.moss, t) ?? moss,
    );
  }
}

class AppTheme {
  const AppTheme._();

  static ThemeData light() {
    const unifyColors = UnifyThemeColors(
      border: AppColors.border,
      mutedForeground: AppColors.inkMuted,
      surfaceMuted: AppColors.surfaceMuted,
      accentDeep: AppColors.accentDeep,
      moss: AppColors.moss,
    );

    final colorScheme = ColorScheme.fromSeed(
      seedColor: AppColors.accent,
      brightness: Brightness.light,
    ).copyWith(
      primary: AppColors.accent,
      onPrimary: Colors.white,
      secondary: AppColors.surfaceMuted,
      onSecondary: AppColors.ink,
      surface: AppColors.surface,
      onSurface: AppColors.ink,
      error: Colors.redAccent,
      onError: Colors.white,
    );

    final baseTextTheme = GoogleFonts.albertSansTextTheme();
    final displayTextTheme = GoogleFonts.cormorantGaramondTextTheme();
    final textTheme = baseTextTheme
        .copyWith(
          displayLarge: displayTextTheme.displayLarge,
          displayMedium: displayTextTheme.displayMedium,
          displaySmall: displayTextTheme.displaySmall,
          headlineLarge: displayTextTheme.headlineLarge,
          headlineMedium: displayTextTheme.headlineMedium,
          headlineSmall: displayTextTheme.headlineSmall,
          titleLarge: displayTextTheme.titleLarge,
          titleMedium: displayTextTheme.titleMedium,
          titleSmall: displayTextTheme.titleSmall,
        )
        .apply(bodyColor: AppColors.ink, displayColor: AppColors.ink);

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: AppColors.parchment,
      textTheme: textTheme,
      dividerTheme: const DividerThemeData(color: AppColors.border),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.accent,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          elevation: 0,
          shape: const StadiumBorder(),
          textStyle: GoogleFonts.albertSans(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.2,
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.ink,
          side: const BorderSide(color: AppColors.accentDeep, width: 1.2),
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          shape: const StadiumBorder(),
          textStyle: GoogleFonts.albertSans(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.2,
          ),
        ),
      ),
      extensions: const [unifyColors],
    );
  }
}
