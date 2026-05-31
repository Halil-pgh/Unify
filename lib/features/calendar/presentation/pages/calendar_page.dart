import 'package:flutter/material.dart';

import '../../../../app/router/app_router.dart';
import '../../../../app/theme/app_theme.dart';
import '../../../../shared/widgets/app_scaffold.dart';
import '../../../../shared/widgets/unify_card.dart';

class CalendarPage extends StatelessWidget {
  const CalendarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      currentRouteName: AppRouteNames.calendar,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _Header(),
          const SizedBox(height: 24),
          LayoutBuilder(
            builder: (context, constraints) {
              final isWide = constraints.maxWidth >= 960;
              if (isWide) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Expanded(flex: 2, child: _CalendarGrid()),
                    SizedBox(width: 24),
                    Expanded(child: _SelectedDay()),
                  ],
                );
              }

              return const Column(
                children: [
                  _CalendarGrid(),
                  SizedBox(height: 24),
                  _SelectedDay(),
                ],
              );
            },
          ),
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

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Personal calendar'.toUpperCase(),
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
        Row(
          children: [
            Expanded(
              child: Text(
                'Tasks and joined events',
                style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w700,
                    ) ??
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
              ),
            ),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
              ),
              child: const Text('Week'),
            ),
            const SizedBox(width: 8),
            OutlinedButton(onPressed: () {}, child: const Text('Month')),
          ],
        ),
      ],
    );
  }
}

class _CalendarGrid extends StatelessWidget {
  const _CalendarGrid();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final unify = theme.extension<UnifyThemeColors>()!;

    return UnifyCard(
      padding: EdgeInsets.zero,
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: unify.surfaceMuted.withOpacity(0.3),
              borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: Row(
              children: _days
                  .map(
                    (day) => Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          border: Border(
                            right: BorderSide(
                              color: unify.border.withOpacity(0.6),
                            ),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            day,
                            style: theme.textTheme.labelMedium?.copyWith(
                                  fontWeight: FontWeight.w700,
                                ) ??
                                const TextStyle(fontWeight: FontWeight.w700),
                          ),
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
          SizedBox(
            height: 320,
            child: Row(
              children: List.generate(
                _calendarColumns.length,
                (index) => Expanded(
                  child: _CalendarColumn(
                    column: _calendarColumns[index],
                    isActive: index == 2,
                    isWeekend: index >= 5,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CalendarColumn extends StatelessWidget {
  const _CalendarColumn({
    required this.column,
    required this.isActive,
    required this.isWeekend,
  });

  final _CalendarColumnData column;
  final bool isActive;
  final bool isWeekend;

  @override
  Widget build(BuildContext context) {
    final unify = Theme.of(context).extension<UnifyThemeColors>()!;

    return Container(
      decoration: BoxDecoration(
        color: isWeekend ? unify.surfaceMuted.withOpacity(0.12) : Colors.transparent,
        border: Border(
          right: BorderSide(color: unify.border.withOpacity(0.6)),
        ),
      ),
      child: Stack(
        children: [
          if (isActive)
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.06),
                  border: Border.all(
                    color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
                  ),
                ),
              ),
            ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: column.items
                  .map(
                    (item) => Container(
                      margin: const EdgeInsets.only(bottom: 8),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: item.backgroundColor,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: item.borderColor),
                      ),
                      child: Text(
                        item.label,
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: item.textColor,
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class _SelectedDay extends StatelessWidget {
  const _SelectedDay();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final unify = theme.extension<UnifyThemeColors>()!;

    return UnifyCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Selected day'.toUpperCase(),
            style: theme.textTheme.labelSmall?.copyWith(
                  letterSpacing: 1.2,
                  fontWeight: FontWeight.w700,
                  color: unify.mutedForeground,
                ) ??
                TextStyle(
                  letterSpacing: 1.2,
                  fontWeight: FontWeight.w700,
                  color: unify.mutedForeground,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            'Wednesday, May 22',
            style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                ) ??
                const TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 16),
          ..._selectedDayItems.map(
            (item) => Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: unify.border.withOpacity(0.6)),
              ),
              child: Row(
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: item.color,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Column(
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
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CalendarItem {
  const _CalendarItem({
    required this.label,
    required this.backgroundColor,
    required this.borderColor,
    required this.textColor,
  });

  final String label;
  final Color backgroundColor;
  final Color borderColor;
  final Color textColor;
}

class _CalendarColumnData {
  const _CalendarColumnData({required this.items});

  final List<_CalendarItem> items;
}

class _SelectedDayItem {
  const _SelectedDayItem({
    required this.title,
    required this.subtitle,
    required this.color,
  });

  final String title;
  final String subtitle;
  final Color color;
}

const _days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

const _calendarColumns = [
  _CalendarColumnData(
    items: [
      _CalendarItem(
        label: 'Poster draft',
        backgroundColor: Color(0xFFDBEAFE),
        borderColor: Color(0xFFBFDBFE),
        textColor: Color(0xFF1D4ED8),
      ),
    ],
  ),
  _CalendarColumnData(
    items: [
      _CalendarItem(
        label: 'Mentor notes',
        backgroundColor: Color(0xFFDBEAFE),
        borderColor: Color(0xFFBFDBFE),
        textColor: Color(0xFF1D4ED8),
      ),
    ],
  ),
  _CalendarColumnData(
    items: [
      _CalendarItem(
        label: 'Crit Night',
        backgroundColor: Color(0xFFFEE2E2),
        borderColor: Color(0xFFFECACA),
        textColor: Color(0xFFB91C1C),
      ),
      _CalendarItem(
        label: 'Review copy',
        backgroundColor: Color(0xFFDBEAFE),
        borderColor: Color(0xFFBFDBFE),
        textColor: Color(0xFF1D4ED8),
      ),
    ],
  ),
  _CalendarColumnData(
    items: [
      _CalendarItem(
        label: 'Garden Reset',
        backgroundColor: Color(0xFFFEE2E2),
        borderColor: Color(0xFFFECACA),
        textColor: Color(0xFFB91C1C),
      ),
    ],
  ),
  _CalendarColumnData(items: []),
  _CalendarColumnData(
    items: [
      _CalendarItem(
        label: 'Repair Cafe',
        backgroundColor: Color(0xFFFEE2E2),
        borderColor: Color(0xFFFECACA),
        textColor: Color(0xFFB91C1C),
      ),
    ],
  ),
  _CalendarColumnData(items: []),
];

const _selectedDayItems = [
  _SelectedDayItem(
    title: 'Portfolio Crit Night',
    subtitle: '18:30 · Design Circle',
    color: Color(0xFFEF4444),
  ),
  _SelectedDayItem(
    title: 'Review registration copy',
    subtitle: 'Due today',
    color: Color(0xFFF59E0B),
  ),
];
