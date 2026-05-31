import 'package:flutter/material.dart';

import '../../app/theme/app_theme.dart';
import '../../core/extensions/color_extensions.dart';

class UnifyCard extends StatelessWidget {
  const UnifyCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(20),
    this.backgroundColor,
    this.borderColor,
    this.borderRadius = 20,
    this.onTap,
    this.shadow = false,
  });

  final Widget child;
  final EdgeInsets padding;
  final Color? backgroundColor;
  final Color? borderColor;
  final double borderRadius;
  final VoidCallback? onTap;
  final bool shadow;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final unify = theme.extension<UnifyThemeColors>()!;
    final card = Container(
      padding: padding,
      decoration: BoxDecoration(
        color: backgroundColor ?? theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(color: borderColor ?? unify.border.withOpacityValue(0.7)),
        boxShadow: shadow
            ? [
                BoxShadow(
                  color: Colors.black.withOpacityValue(0.06),
                  blurRadius: 12,
                  offset: const Offset(0, 6),
                ),
              ]
            : null,
      ),
      child: child,
    );

    if (onTap == null) {
      return card;
    }

    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(borderRadius),
        onTap: onTap,
        child: card,
      ),
    );
  }
}
