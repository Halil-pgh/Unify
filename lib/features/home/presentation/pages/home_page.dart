import 'package:flutter/material.dart';

import '../../../../app/router/app_router.dart';
import '../../../../app/theme/app_theme.dart';
import '../../../../shared/widgets/app_scaffold.dart';
import '../../../../shared/widgets/unify_badge.dart';
import '../../../../shared/widgets/unify_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      currentRouteName: AppRouteNames.home,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isWide = constraints.maxWidth >= 980;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _SectionHeader(
                eyebrow: 'Your communities',
                title: 'Different roles, one personal home',
                action: TextButton(
                  onPressed: () {},
                  child: const Text('Manage all'),
                ),
              ),
              const SizedBox(height: 16),
              _CommunityGrid(isWide: isWide),
              const SizedBox(height: 32),
              _SectionHeader(
                eyebrow: 'My feed',
                title: 'Upcoming from your communities',
                action: TextButton(
                  onPressed: () {},
                  child: const Text('View all'),
                ),
              ),
              const SizedBox(height: 16),
              if (isWide)
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(child: _FeedList()),
                    const SizedBox(width: 24),
                    const Expanded(child: _FocusQueue()),
                  ],
                )
              else
                Column(
                  children: [
                    _FeedList(),
                    const SizedBox(height: 24),
                    const _FocusQueue(),
                  ],
                ),
            ],
          );
        },
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({
    required this.eyebrow,
    required this.title,
    this.action,
  });

  final String eyebrow;
  final String title;
  final Widget? action;

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
                eyebrow.toUpperCase(),
                style: theme.textTheme.labelSmall?.copyWith(
                      letterSpacing: 1.4,
                      fontWeight: FontWeight.w700,
                      color: unify.mutedForeground,
                    ) ??
                    TextStyle(
                      letterSpacing: 1.4,
                      fontWeight: FontWeight.w700,
                      color: unify.mutedForeground,
                    ),
              ),
              const SizedBox(height: 6),
              Text(
                title,
                style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w700,
                    ) ??
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
              ),
            ],
          ),
        ),
        if (action != null) action!,
      ],
    );
  }
}

class _CommunityGrid extends StatelessWidget {
  const _CommunityGrid({required this.isWide});

  final bool isWide;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final columns = isWide ? 3 : 1;
        final width = constraints.maxWidth;
        final cardWidth = (width - (columns - 1) * 16) / columns;

        return Wrap(
          spacing: 16,
          runSpacing: 16,
          children: _communityCards
              .map(
                (card) => SizedBox(
                  width: isWide ? cardWidth : double.infinity,
                  child: _CommunityCard(card: card),
                ),
              )
              .toList(),
        );
      },
    );
  }
}

class _CommunityCard extends StatelessWidget {
  const _CommunityCard({required this.card});

  final _CommunityCardData card;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final unify = theme.extension<UnifyThemeColors>()!;

    return UnifyCard(
      onTap: () {},
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: card.accent.withOpacity(0.15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Container(
                width: 18,
                height: 18,
                decoration: BoxDecoration(
                  color: card.accent.withOpacity(0.5),
                  shape: card.shape,
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          UnifyBadge(
            label: card.role,
            backgroundColor: card.badgeBackground,
            textColor: card.badgeTextColor,
            borderColor: card.badgeBorderColor,
          ),
          const SizedBox(height: 8),
          Text(
            card.title,
            style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                ) ??
                const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 6),
          Text(
            card.subtitle,
            style: theme.textTheme.bodySmall?.copyWith(
                  color: unify.mutedForeground,
                ) ??
                TextStyle(color: unify.mutedForeground),
          ),
        ],
      ),
    );
  }
}

class _FeedList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: _feedItems
          .map(
            (item) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: UnifyCard(
                padding: const EdgeInsets.all(16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _DatePill(date: item.date, time: item.time),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item.title,
                            style: Theme.of(context)
                                    .textTheme
                                    .titleSmall
                                    ?.copyWith(
                                      fontWeight: FontWeight.w700,
                                    ) ??
                                const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            item.description,
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  color: Theme.of(context)
                                      .extension<UnifyThemeColors>()!
                                      .mutedForeground,
                                ),
                          ),
                          const SizedBox(height: 8),
                          UnifyBadge(
                            label: item.community,
                            backgroundColor: item.badgeColor,
                            textColor: item.badgeTextColor,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),
                    OutlinedButton(
                      onPressed: () {},
                      child: const Text('Join'),
                    ),
                  ],
                ),
              ),
            ),
          )
          .toList(),
    );
  }
}

class _DatePill extends StatelessWidget {
  const _DatePill({required this.date, required this.time});

  final String date;
  final String time;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final unify = theme.extension<UnifyThemeColors>()!;

    return Container(
      width: 76,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
      decoration: BoxDecoration(
        color: unify.surfaceMuted.withOpacity(0.5),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        children: [
          Text(
            date.toUpperCase(),
            style: theme.textTheme.labelSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: unify.mutedForeground,
                ) ??
                TextStyle(
                  fontWeight: FontWeight.w700,
                  color: unify.mutedForeground,
                ),
          ),
          const SizedBox(height: 4),
          Text(
            time,
            style: theme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                ) ??
                const TextStyle(fontWeight: FontWeight.w700),
          ),
        ],
      ),
    );
  }
}

class _FocusQueue extends StatelessWidget {
  const _FocusQueue();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final unify = theme.extension<UnifyThemeColors>()!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Today',
          style: theme.textTheme.labelSmall?.copyWith(
                fontWeight: FontWeight.w700,
                letterSpacing: 1.4,
                color: unify.mutedForeground,
              ) ??
              TextStyle(
                fontWeight: FontWeight.w700,
                letterSpacing: 1.4,
                color: unify.mutedForeground,
              ),
        ),
        const SizedBox(height: 6),
        Text(
          'Focus queue',
          style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w700,
              ) ??
              const TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 16),
        UnifyCard(
          padding: EdgeInsets.zero,
          child: Column(
            children: _focusItems
                .map(
                  (item) => InkWell(
                    onTap: () {},
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: unify.border.withOpacity(0.6),
                          ),
                        ),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(top: 4),
                            width: 10,
                            height: 10,
                            decoration: BoxDecoration(
                              color: item.color,
                              shape: BoxShape.circle,
                              border: item.isOutlined
                                  ? Border.all(color: unify.mutedForeground)
                                  : null,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item.title,
                                  style: theme.textTheme.bodyMedium?.copyWith(
                                        fontWeight: FontWeight.w600,
                                      ) ??
                                      const TextStyle(fontWeight: FontWeight.w600),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  item.subtitle,
                                  style: theme.textTheme.bodySmall?.copyWith(
                                        color: unify.mutedForeground,
                                      ) ??
                                      TextStyle(color: unify.mutedForeground),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        ),
      ],
    );
  }
}

class _CommunityCardData {
  const _CommunityCardData({
    required this.role,
    required this.title,
    required this.subtitle,
    required this.accent,
    required this.shape,
    required this.badgeBackground,
    required this.badgeTextColor,
    required this.badgeBorderColor,
  });

  final String role;
  final String title;
  final String subtitle;
  final Color accent;
  final BoxShape shape;
  final Color badgeBackground;
  final Color badgeTextColor;
  final Color badgeBorderColor;
}

class _FeedItem {
  const _FeedItem({
    required this.date,
    required this.time,
    required this.title,
    required this.description,
    required this.community,
    required this.badgeColor,
    required this.badgeTextColor,
  });

  final String date;
  final String time;
  final String title;
  final String description;
  final String community;
  final Color badgeColor;
  final Color badgeTextColor;
}

class _FocusItem {
  const _FocusItem({
    required this.title,
    required this.subtitle,
    required this.color,
    this.isOutlined = false,
  });

  final String title;
  final String subtitle;
  final Color color;
  final bool isOutlined;
}

final _communityCards = [
  _CommunityCardData(
    role: 'Moderator',
    title: 'Design Circle',
    subtitle: 'Finalize event poster · Confirm critique mentors',
    accent: const Color(0xFFC07A4B),
    shape: BoxShape.rectangle,
    badgeBackground: const Color(0xFFFFFBF7),
    badgeTextColor: const Color(0xFF8C4B2C),
    badgeBorderColor: const Color(0xFFD9C7B4),
  ),
  _CommunityCardData(
    role: 'Member',
    title: 'Campus Volunteers',
    subtitle: 'Review volunteer map · Pack donation kits',
    accent: const Color(0xFF2E6F6C),
    shape: BoxShape.circle,
    badgeBackground: const Color(0xFFE7F4F1),
    badgeTextColor: const Color(0xFF2E6F6C),
    badgeBorderColor: const Color(0xFFC5E2DC),
  ),
  _CommunityCardData(
    role: 'Following',
    title: 'Indie Film Club',
    subtitle: 'No private tasks · 2 public events upcoming',
    accent: const Color(0xFFD9A441),
    shape: BoxShape.rectangle,
    badgeBackground: const Color(0xFFFFF4E0),
    badgeTextColor: const Color(0xFFB27A18),
    badgeBorderColor: const Color(0xFFF1D7A6),
  ),
];

const _feedItems = [
  _FeedItem(
    date: 'May 22',
    time: '18:30',
    title: 'Portfolio Crit Night',
    description: 'Design Circle hosts a peer feedback session for student portfolios.',
    community: 'Design Circle',
    badgeColor: Color(0xFFEADBC8),
    badgeTextColor: Color(0xFF8C4B2C),
  ),
  _FeedItem(
    date: 'May 24',
    time: '10:00',
    title: 'Campus Garden Reset',
    description: 'Volunteer teams prepare shared green areas for the summer term.',
    community: 'Campus Volunteers',
    badgeColor: Color(0xFFE7F4F1),
    badgeTextColor: Color(0xFF2E6F6C),
  ),
];

const _focusItems = [
  _FocusItem(
    title: 'Finalize event poster',
    subtitle: 'Design Circle · In Progress',
    color: Color(0xFF3B82F6),
  ),
  _FocusItem(
    title: 'Review volunteer map',
    subtitle: 'Campus Volunteers · In Review',
    color: Color(0xFFF59E0B),
  ),
  _FocusItem(
    title: 'Assign welcome desk',
    subtitle: 'Code Bloom · To Be Assigned',
    color: Color(0xFFE5E7EB),
    isOutlined: true,
  ),
];
