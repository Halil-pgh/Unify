import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../../../app/router/app_router.dart';
import '../../../../app/theme/app_theme.dart';
import '../../../../shared/widgets/app_scaffold.dart';
import '../../../../shared/widgets/unify_badge.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      currentRouteName: AppRouteNames.welcome,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isWide = constraints.maxWidth >= 900;
          return Column(
            children: [
              _HeroSection(isWide: isWide),
              const SizedBox(height: 32),
              const Divider(height: 48),
              const SizedBox(height: 16),
              _FeaturesSection(isWide: isWide),
            ],
          );
        },
      ),
    );
  }
}

class _HeroSection extends StatelessWidget {
  const _HeroSection({required this.isWide});

  final bool isWide;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final unify = theme.extension<UnifyThemeColors>()!;
    final textTheme = theme.textTheme;
    final textAlign = isWide ? TextAlign.left : TextAlign.center;
    final crossAxisAlignment =
        isWide ? CrossAxisAlignment.start : CrossAxisAlignment.center;

    final content = Column(
      crossAxisAlignment: crossAxisAlignment,
      children: [
        Text(
          'Community work, made playable',
          textAlign: textAlign,
          style: textTheme.labelSmall?.copyWith(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                letterSpacing: 2.2,
                color: colorScheme.primary,
              ) ??
              TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                letterSpacing: 2.2,
                color: colorScheme.primary,
              ),
        ),
        const SizedBox(height: 12),
        Text(
          'Unify helps communities coordinate tasks, events, and growth.',
          textAlign: textAlign,
          style: textTheme.displayMedium?.copyWith(
                fontSize: isWide ? 58 : 42,
                fontWeight: FontWeight.w600,
                height: 1.05,
                letterSpacing: -0.6,
              ) ??
              TextStyle(
                fontSize: isWide ? 58 : 42,
                fontWeight: FontWeight.w600,
                height: 1.05,
                letterSpacing: -0.6,
              ),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.only(left: 16),
          decoration: BoxDecoration(
            border: Border(
              left: BorderSide(color: colorScheme.primary, width: 4),
            ),
          ),
          child: Text(
            'Unify: where communities gather, work, and grow together.',
            textAlign: textAlign,
            style: textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: unify.mutedForeground,
                  fontStyle: FontStyle.italic,
                  height: 1.4,
                ) ??
                TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: unify.mutedForeground,
                  fontStyle: FontStyle.italic,
                  height: 1.4,
                ),
          ),
        ),
        const SizedBox(height: 16),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600),
          child: Text(
            'Build a shared workspace for members, publish public events for '
            'everyone, and let each community companion grow as people complete '
            'real work together.',
            textAlign: textAlign,
            style: textTheme.bodyLarge?.copyWith(
                  color: unify.mutedForeground,
                  height: 1.6,
                ) ??
                TextStyle(
                  fontSize: 18,
                  color: unify.mutedForeground,
                  height: 1.6,
                ),
          ),
        ),
        const SizedBox(height: 24),
        Wrap(
          alignment: isWide ? WrapAlignment.start : WrapAlignment.center,
          spacing: 16,
          runSpacing: 12,
          children: [
            ElevatedButton(
              onPressed: () {},
              child: const Text('Start with Unify'),
            ),
            OutlinedButton(
              onPressed: () {},
              child: const Text('Explore public events'),
            ),
          ],
        ),
        const SizedBox(height: 24),
        Wrap(
          alignment: isWide ? WrapAlignment.start : WrapAlignment.center,
          spacing: 16,
          runSpacing: 12,
          children: const [
            _StoreButton(
              tagline: 'Download on',
              store: 'App Store',
            ),
            _StoreButton(
              tagline: 'Get it on',
              store: 'Google Play',
            ),
          ],
        ),
      ],
    );

    if (!isWide) {
      return Column(
        children: [
          content,
          const SizedBox(height: 32),
          const _PreviewPanel(),
        ],
      );
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: content),
        const SizedBox(width: 32),
        const Expanded(child: _PreviewPanel()),
      ],
    );
  }
}

class _StoreButton extends StatelessWidget {
  const _StoreButton({required this.tagline, required this.store});

  final String tagline;
  final String store;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final unify = theme.extension<UnifyThemeColors>()!;
    final textTheme = theme.textTheme;

    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: unify.surfaceMuted,
        foregroundColor: theme.colorScheme.onSurface,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: unify.border),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            tagline,
            style: textTheme.labelSmall?.copyWith(
                  fontSize: 10,
                  color: unify.mutedForeground,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.1,
                ) ??
                TextStyle(
                  fontSize: 10,
                  color: unify.mutedForeground,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.1,
                ),
          ),
          const SizedBox(height: 2),
          Text(
            store,
            style: textTheme.titleSmall?.copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ) ??
                const TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
          ),
        ],
      ),
    );
  }
}

class _PreviewPanel extends StatelessWidget {
  const _PreviewPanel();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final unify = theme.extension<UnifyThemeColors>()!;

    return LayoutBuilder(
      builder: (context, constraints) {
        final cardWidth =
            math.min(240.0, math.max(200.0, constraints.maxWidth * 0.7));

        return Container(
          height: 500,
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                colorScheme.primary.withOpacity(0.18),
                unify.moss.withOpacity(0.16),
                colorScheme.surface.withOpacity(0.9),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(40),
            border: Border.all(color: unify.border),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 12,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Stack(
            children: [
              Positioned(
                top: 40,
                right: 32,
                child: Transform.rotate(
                  angle: 3 * math.pi / 180,
                  child: _EventCard(width: cardWidth),
                ),
              ),
              Positioned(
                bottom: 48,
                left: 24,
                child: Transform.rotate(
                  angle: -2 * math.pi / 180,
                  child: _XpCard(width: cardWidth),
                ),
              ),
              const Center(child: _MascotPlaceholder()),
            ],
          ),
        );
      },
    );
  }
}

class _EventCard extends StatelessWidget {
  const _EventCard({required this.width});

  final double width;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final unify = theme.extension<UnifyThemeColors>()!;
    final textTheme = theme.textTheme;

    return Container(
      width: width,
      decoration: BoxDecoration(
        color: colorScheme.surface.withOpacity(0.98),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: unify.border),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 10,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const UnifyBadge(label: 'Design Circle'),
          const SizedBox(height: 8),
          Text(
            'Portfolio Crit Night',
            style: textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                ) ??
                const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 12),
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              '38 / 50 joined',
              style: textTheme.labelMedium?.copyWith(
                    color: unify.mutedForeground,
                    fontWeight: FontWeight.w600,
                  ) ??
                  TextStyle(
                    fontSize: 12,
                    color: unify.mutedForeground,
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}

class _XpCard extends StatelessWidget {
  const _XpCard({required this.width});

  final double width;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final unify = theme.extension<UnifyThemeColors>()!;
    final textTheme = theme.textTheme;

    return Container(
      width: width,
      decoration: BoxDecoration(
        color: colorScheme.surface.withOpacity(0.98),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: unify.border),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 10,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: unify.moss.withOpacity(0.18),
              borderRadius: BorderRadius.circular(999),
            ),
            child: Text(
              'Community XP',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: unify.moss,
              ),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            '+120 this week',
            style: textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w800,
                ) ??
                const TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(999),
            child: Container(
              height: 10,
              color: unify.surfaceMuted,
              child: FractionallySizedBox(
                widthFactor: 0.72,
                alignment: Alignment.centerLeft,
                child: Container(color: unify.moss),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MascotPlaceholder extends StatelessWidget {
  const _MascotPlaceholder();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final unify = theme.extension<UnifyThemeColors>()!;

    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: 180,
          height: 180,
          decoration: BoxDecoration(
            color: colorScheme.primary.withOpacity(0.16),
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: colorScheme.primary.withOpacity(0.12),
                blurRadius: 60,
                spreadRadius: 20,
              ),
            ],
          ),
        ),
        Transform.rotate(
          angle: 12 * math.pi / 180,
          child: Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              color: colorScheme.primary.withOpacity(0.22),
              borderRadius: BorderRadius.circular(48),
              border: Border.all(color: unify.border),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _EyeDot(),
                SizedBox(width: 12),
                _EyeDot(),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _EyeDot extends StatelessWidget {
  const _EyeDot();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      width: 12,
      height: 12,
      decoration: BoxDecoration(
        color: colorScheme.onBackground.withOpacity(0.75),
        shape: BoxShape.circle,
      ),
    );
  }
}

class _FeaturesSection extends StatelessWidget {
  const _FeaturesSection({required this.isWide});

  final bool isWide;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final unify = theme.extension<UnifyThemeColors>()!;
    final textTheme = theme.textTheme;

    final features = const [
      _Feature(
        title: 'Invite-only workspaces',
        description: 'Keep tasks, dependencies, members, and dashboards private.',
      ),
      _Feature(
        title: 'Public event pages',
        description:
            'Let anyone follow communities and register for published events.',
      ),
      _Feature(
        title: 'Unified calendar',
        description:
            'See assigned tasks and joined events without switching contexts.',
      ),
      _Feature(
        title: 'Companion growth',
        description:
            'Turn completed work into visible community progress.',
      ),
    ];

    final header = Column(
      crossAxisAlignment:
          isWide ? CrossAxisAlignment.start : CrossAxisAlignment.center,
      children: [
        Text(
          'Why Unify',
          textAlign: isWide ? TextAlign.left : TextAlign.center,
          style: textTheme.labelSmall?.copyWith(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                letterSpacing: 2.0,
                color: colorScheme.primary,
              ) ??
              TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                letterSpacing: 2.0,
                color: colorScheme.primary,
              ),
        ),
        const SizedBox(height: 8),
        Text(
          'Private coordination and public discovery live in the same product.',
          textAlign: isWide ? TextAlign.left : TextAlign.center,
          style: textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w700,
                height: 1.2,
              ) ??
              const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w700,
                height: 1.2,
              ),
        ),
      ],
    );

    if (!isWide) {
      return Column(
        children: [
          header,
          const SizedBox(height: 24),
          Column(
            children: features
                .map(
                  (feature) => Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: _FeatureCard(feature: feature),
                  ),
                )
                .toList(),
          ),
        ],
      );
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(flex: 4, child: header),
        const SizedBox(width: 32),
        Expanded(
          flex: 8,
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(child: _FeatureCard(feature: features[0])),
                  const SizedBox(width: 24),
                  Expanded(child: _FeatureCard(feature: features[1])),
                ],
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(child: _FeatureCard(feature: features[2])),
                  const SizedBox(width: 24),
                  Expanded(child: _FeatureCard(feature: features[3])),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _Feature {
  const _Feature({required this.title, required this.description});

  final String title;
  final String description;
}

class _FeatureCard extends StatelessWidget {
  const _FeatureCard({required this.feature});

  final _Feature feature;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final unify = theme.extension<UnifyThemeColors>()!;
    final textTheme = theme.textTheme;

    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surface.withOpacity(0.85),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: unify.border.withOpacity(0.7)),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            feature.title,
            style: textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                ) ??
                const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 8),
          Text(
            feature.description,
            style: textTheme.bodyMedium?.copyWith(
                  color: unify.mutedForeground,
                  height: 1.5,
                ) ??
                TextStyle(
                  fontSize: 14,
                  color: unify.mutedForeground,
                  height: 1.5,
                ),
          ),
        ],
      ),
    );
  }
}
