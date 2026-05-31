import 'package:flutter/material.dart';

import '../../../../app/router/app_router.dart';
import '../../../../app/theme/app_theme.dart';
import '../../../../shared/widgets/app_scaffold.dart';
import '../../../../shared/widgets/unify_badge.dart';
import '../../../../shared/widgets/unify_card.dart';

class CommunitiesPage extends StatelessWidget {
  const CommunitiesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      currentRouteName: AppRouteNames.communities,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _Header(),
          const SizedBox(height: 24),
          const _CommunityList(),
        ],
      ),
    );
  }
}

class _Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final unify = theme.extension<UnifyThemeColors>()!;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Communities'.toUpperCase(),
                style: theme.textTheme.labelSmall?.copyWith(
                      letterSpacing: 1.4,
                      fontWeight: FontWeight.w700,
                      color: theme.colorScheme.primary,
                    ) ??
                    TextStyle(
                      letterSpacing: 1.4,
                      fontWeight: FontWeight.w700,
                      color: theme.colorScheme.primary,
                    ),
              ),
              const SizedBox(height: 6),
              Text(
                'Your memberships and follows',
                style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w700,
                    ) ??
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
              ),
            ],
          ),
        ),
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          ),
          child: const Text('Discover more'),
        ),
      ],
    );
  }
}

class _CommunityList extends StatelessWidget {
  const _CommunityList();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        _FeaturedCommunityCard(),
        SizedBox(height: 16),
        _CommunityCard(
          badgeLabel: 'Member',
          badgeColor: Color(0xFFE7F4F1),
          badgeTextColor: Color(0xFF2E6F6C),
          badgeBorderColor: Color(0xFFC5E2DC),
          title: 'Campus Volunteers',
          description:
              'Volunteer crews planning local care, garden, and donation drives.',
          accent: Color(0xFF2E6F6C),
          accentShape: BoxShape.circle,
          actionLabel: 'View workspace',
          tasks: [
            'Review volunteer map',
            'Pack donation kits',
          ],
        ),
        SizedBox(height: 16),
        _CommunityCard(
          badgeLabel: 'Following',
          badgeColor: Color(0xFFFFF4E0),
          badgeTextColor: Color(0xFFB27A18),
          badgeBorderColor: Color(0xFFF1D7A6),
          title: 'Indie Film Club',
          description:
              'Public screenings and film conversations from independent creators.',
          accent: Color(0xFFD9A441),
          accentShape: BoxShape.rectangle,
          actionLabel: 'Public page',
          tasks: [
            'No internal access',
            '2 public events upcoming',
          ],
        ),
      ],
    );
  }
}

class _FeaturedCommunityCard extends StatelessWidget {
  const _FeaturedCommunityCard();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final unify = theme.extension<UnifyThemeColors>()!;

    return UnifyCard(
      padding: EdgeInsets.zero,
      shadow: true,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isWide = constraints.maxWidth >= 640;
          return Column(
            children: [
              Row(
                children: [
                  Container(
                    width: isWide ? 140 : 100,
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primary.withOpacity(0.05),
                      border: Border(
                        right: BorderSide(color: unify.border.withOpacity(0.6)),
                        bottom: isWide
                            ? BorderSide.none
                            : BorderSide(color: unify.border.withOpacity(0.6)),
                      ),
                    ),
                    child: Center(
                      child: Container(
                        width: 64,
                        height: 64,
                        decoration: BoxDecoration(
                          color: theme.colorScheme.primary.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              _Dot(),
                              SizedBox(width: 6),
                              _Dot(),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          UnifyBadge(
                            label: 'Moderator',
                            backgroundColor: theme.colorScheme.surface,
                            textColor: unify.mutedForeground,
                            borderColor: unify.border,
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'Design Circle',
                            style: theme.textTheme.titleLarge?.copyWith(
                                  fontWeight: FontWeight.w700,
                                ) ??
                                const TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w700,
                                ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Creative students coordinating critique nights, exhibitions, '
                            'and shared design resources.',
                            style: theme.textTheme.bodySmall?.copyWith(
                                  color: unify.mutedForeground,
                                ) ??
                                TextStyle(color: unify.mutedForeground),
                          ),
                          const SizedBox(height: 16),
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: unify.surfaceMuted.withOpacity(0.4),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Assigned',
                                  style: theme.textTheme.labelSmall?.copyWith(
                                        fontWeight: FontWeight.w700,
                                        color: unify.mutedForeground,
                                      ),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  'Finalize event poster',
                                  style: theme.textTheme.bodyMedium?.copyWith(
                                        fontWeight: FontWeight.w600,
                                      ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  'Confirm critique mentors',
                                  style: theme.textTheme.bodySmall?.copyWith(
                                        color: unify.mutedForeground,
                                      ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 16),
                          Wrap(
                            spacing: 12,
                            runSpacing: 6,
                            children: [
                              Text(
                                '18 members',
                                style: theme.textTheme.labelSmall?.copyWith(
                                      color: unify.mutedForeground,
                                      fontWeight: FontWeight.w700,
                                    ),
                              ),
                              _SeparatorDot(color: unify.border),
                              Text(
                                '24 tasks',
                                style: theme.textTheme.labelSmall?.copyWith(
                                      color: unify.mutedForeground,
                                      fontWeight: FontWeight.w700,
                                    ),
                              ),
                              _SeparatorDot(color: unify.border),
                              Text(
                                'Level 7 companion',
                                style: theme.textTheme.labelSmall?.copyWith(
                                      color: theme.colorScheme.primary,
                                      fontWeight: FontWeight.w700,
                                    ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Align(
                            alignment: Alignment.centerRight,
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 12,
                                ),
                              ),
                              child: const Text('Open workspace'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}

class _CommunityCard extends StatelessWidget {
  const _CommunityCard({
    required this.badgeLabel,
    required this.badgeColor,
    required this.badgeTextColor,
    required this.badgeBorderColor,
    required this.title,
    required this.description,
    required this.accent,
    required this.accentShape,
    required this.actionLabel,
    required this.tasks,
  });

  final String badgeLabel;
  final Color badgeColor;
  final Color badgeTextColor;
  final Color badgeBorderColor;
  final String title;
  final String description;
  final Color accent;
  final BoxShape accentShape;
  final String actionLabel;
  final List<String> tasks;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final unify = theme.extension<UnifyThemeColors>()!;

    return UnifyCard(
      padding: EdgeInsets.zero,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isWide = constraints.maxWidth >= 640;

          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: isWide ? 140 : 100,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: accent.withOpacity(0.05),
                  border: Border(
                    right: BorderSide(color: unify.border.withOpacity(0.6)),
                    bottom: isWide
                        ? BorderSide.none
                        : BorderSide(color: unify.border.withOpacity(0.6)),
                  ),
                ),
                child: Center(
                  child: Container(
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(
                      color: accent.withOpacity(0.2),
                      shape: accentShape,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      UnifyBadge(
                        label: badgeLabel,
                        backgroundColor: badgeColor,
                        textColor: badgeTextColor,
                        borderColor: badgeBorderColor,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        title,
                        style: theme.textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.w700,
                            ) ??
                            const TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        description,
                        style: theme.textTheme.bodySmall?.copyWith(
                              color: unify.mutedForeground,
                            ) ??
                            TextStyle(color: unify.mutedForeground),
                      ),
                      const SizedBox(height: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: tasks
                            .map(
                              (task) => Padding(
                                padding: const EdgeInsets.only(bottom: 6),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 6,
                                      height: 6,
                                      decoration: BoxDecoration(
                                        color: unify.mutedForeground,
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: Text(
                                        task,
                                        style: theme.textTheme.bodySmall?.copyWith(
                                              color: unify.mutedForeground,
                                            ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                            .toList(),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: OutlinedButton(
                          onPressed: () {},
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 12,
                            ),
                          ),
                          child: Text(actionLabel),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _SeparatorDot extends StatelessWidget {
  const _SeparatorDot({required this.color});

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 4,
      height: 4,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }
}

class _Dot extends StatelessWidget {
  const _Dot();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 10,
      height: 10,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary.withOpacity(0.8),
        shape: BoxShape.circle,
      ),
    );
  }
}
