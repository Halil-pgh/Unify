import 'package:flutter/material.dart';

import '../../../../app/router/app_router.dart';
import '../../../../app/theme/app_theme.dart';
import '../../../../shared/widgets/app_scaffold.dart';
import '../../../../shared/widgets/unify_badge.dart';
import '../../../../shared/widgets/unify_card.dart';

class ExplorePage extends StatelessWidget {
  const ExplorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      currentRouteName: AppRouteNames.explore,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _PageHeader(
            eyebrow: 'Global event feed',
            title: 'Explore public events',
            actions: [
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                ),
                child: const Text('All'),
              ),
              OutlinedButton(
                onPressed: () {},
                child: const Text('This week'),
              ),
              OutlinedButton(
                onPressed: () {},
                child: const Text('Online'),
              ),
              OutlinedButton(
                onPressed: () {},
                child: const Text('Near campus'),
              ),
            ],
          ),
          const SizedBox(height: 24),
          LayoutBuilder(
            builder: (context, constraints) {
              final width = constraints.maxWidth;
              final columns = width >= 960 ? 3 : width >= 640 ? 2 : 1;
              final cardWidth = (width - (columns - 1) * 16) / columns;

              return Wrap(
                spacing: 16,
                runSpacing: 16,
                children: _exploreEvents
                    .map(
                      (event) => SizedBox(
                        width: cardWidth,
                        child: _ExploreCard(event: event),
                      ),
                    )
                    .toList(),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _PageHeader extends StatelessWidget {
  const _PageHeader({
    required this.eyebrow,
    required this.title,
    required this.actions,
  });

  final String eyebrow;
  final String title;
  final List<Widget> actions;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final unify = theme.extension<UnifyThemeColors>()!;

    return Column(
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
              const TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 12),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: actions
                .map(
                  (action) => Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: action,
                  ),
                )
                .toList(),
          ),
        ),
      ],
    );
  }
}

class _ExploreCard extends StatelessWidget {
  const _ExploreCard({required this.event});

  final _ExploreEvent event;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final unify = theme.extension<UnifyThemeColors>()!;

    return UnifyCard(
      padding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 120,
            width: double.infinity,
            decoration: BoxDecoration(
              color: event.bannerColor,
              borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: Center(
              child: Text(
                event.initials,
                style: theme.textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.w800,
                      color: event.bannerTextColor,
                    ) ??
                    TextStyle(
                      fontWeight: FontWeight.w800,
                      color: event.bannerTextColor,
                    ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                UnifyBadge(
                  label: event.community,
                  backgroundColor: event.badgeColor,
                  textColor: event.badgeTextColor,
                ),
                const SizedBox(height: 10),
                Text(
                  event.title,
                  style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      ) ??
                      const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 8),
                Text(
                  event.description,
                  style: theme.textTheme.bodySmall?.copyWith(
                        color: unify.mutedForeground,
                        height: 1.5,
                      ) ??
                      TextStyle(color: unify.mutedForeground, height: 1.5),
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      event.dateTime,
                      style: theme.textTheme.labelMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    Text(
                      event.capacity,
                      style: theme.textTheme.labelSmall?.copyWith(
                            color: event.capacityColor ?? unify.mutedForeground,
                          ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: const Text('Register'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ExploreEvent {
  const _ExploreEvent({
    required this.community,
    required this.initials,
    required this.title,
    required this.description,
    required this.dateTime,
    required this.capacity,
    required this.bannerColor,
    required this.bannerTextColor,
    required this.badgeColor,
    required this.badgeTextColor,
    this.capacityColor,
  });

  final String community;
  final String initials;
  final String title;
  final String description;
  final String dateTime;
  final String capacity;
  final Color bannerColor;
  final Color bannerTextColor;
  final Color badgeColor;
  final Color badgeTextColor;
  final Color? capacityColor;
}

const _exploreEvents = [
  _ExploreEvent(
    community: 'Design Circle',
    initials: 'DC',
    title: 'Portfolio Crit Night',
    description: 'Bring one project and leave with concrete peer feedback.',
    dateTime: 'May 22, 18:30',
    capacity: '38 / 50 joined',
    bannerColor: Color(0xFFFDE2E2),
    bannerTextColor: Color(0xFFD7727A),
    badgeColor: Color(0xFFEADBC8),
    badgeTextColor: Color(0xFF8C4B2C),
  ),
  _ExploreEvent(
    community: 'Green Steps',
    initials: 'GS',
    title: 'Repair Cafe Weekend',
    description: 'A public workshop for fixing small household objects together.',
    dateTime: 'May 25, 12:00',
    capacity: 'Open capacity',
    bannerColor: Color(0xFFDDF4EC),
    bannerTextColor: Color(0xFF3E8E7E),
    badgeColor: Color(0xFFE7F4F1),
    badgeTextColor: Color(0xFF2E6F6C),
    capacityColor: Color(0xFF2E6F6C),
  ),
  _ExploreEvent(
    community: 'Indie Film Club',
    initials: 'IF',
    title: 'Short Film Open Screening',
    description: 'Public screening followed by a moderated filmmaker Q&A.',
    dateTime: 'May 28, 19:00',
    capacity: '71 / 90 joined',
    bannerColor: Color(0xFFFFF0D6),
    bannerTextColor: Color(0xFFB77A1A),
    badgeColor: Color(0xFFFFF4E0),
    badgeTextColor: Color(0xFFB27A18),
  ),
];
