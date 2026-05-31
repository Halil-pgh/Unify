import 'package:flutter/material.dart';

import '../../core/extensions/color_extensions.dart';

class UnifyBadge extends StatelessWidget {
  const UnifyBadge({
    super.key,
    required this.label,
    this.backgroundColor,
    this.textColor,
    this.borderColor,
    this.padding = const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
  });

  final String label;
  final Color? backgroundColor;
  final Color? textColor;
  final Color? borderColor;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final style = theme.textTheme.labelSmall?.copyWith(
      fontWeight: FontWeight.w700,
      letterSpacing: 0.4,
      color: textColor ?? theme.colorScheme.onSurface,
    );

    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: backgroundColor ?? theme.colorScheme.secondary.withOpacityValue(0.4),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(
          color: borderColor ?? Colors.transparent,
        ),
      ),
      child: Text(label, style: style),
    );
  }
}
