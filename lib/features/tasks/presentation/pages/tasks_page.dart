import 'package:flutter/material.dart';

import '../../../../app/router/app_router.dart';
import '../../../../app/theme/app_theme.dart';
import '../../../../shared/widgets/app_scaffold.dart';
import '../../../../shared/widgets/unify_badge.dart';
import '../../../../shared/widgets/unify_card.dart';

class TasksPage extends StatelessWidget {
  const TasksPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      currentRouteName: AppRouteNames.tasks,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _Header(),
          const SizedBox(height: 24),
          UnifyCard(
            padding: EdgeInsets.zero,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                headingRowColor: MaterialStateProperty.all(
                  Theme.of(context).extension<UnifyThemeColors>()!.surfaceMuted.withOpacity(0.4),
                ),
                columns: const [
                  DataColumn(label: Text('Task')),
                  DataColumn(label: Text('Community')),
                  DataColumn(label: Text('Status')),
                  DataColumn(label: Text('Deadline')),
                  DataColumn(label: Text('Dependencies')),
                ],
                rows: _taskRows.map((task) {
                  return DataRow(
                    cells: [
                      DataCell(
                        Row(
                          children: [
                            Container(
                              width: 8,
                              height: 8,
                              decoration: BoxDecoration(
                                color: task.statusColor,
                                shape: BoxShape.circle,
                                border: task.outlined
                                    ? Border.all(
                                        color: Theme.of(context)
                                            .extension<UnifyThemeColors>()!
                                            .mutedForeground,
                                      )
                                    : null,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              task.title,
                              style: task.isCompleted
                                  ? Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(
                                        decoration: TextDecoration.lineThrough,
                                        color: Theme.of(context)
                                            .extension<UnifyThemeColors>()!
                                            .mutedForeground,
                                      )
                                  : null,
                            ),
                          ],
                        ),
                      ),
                      DataCell(Text(task.community)),
                      DataCell(
                        UnifyBadge(
                          label: task.statusLabel,
                          backgroundColor: task.badgeColor,
                          textColor: task.badgeTextColor,
                          borderColor: task.badgeBorderColor,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                        ),
                      ),
                      DataCell(Text(task.deadline)),
                      DataCell(Text(task.dependencies)),
                    ],
                  );
                }).toList(),
              ),
            ),
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
          'My tasks'.toUpperCase(),
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
          'All assigned work across communities',
          style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w700,
              ) ??
              const TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 16),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                ),
                child: const Text('All'),
              ),
              const SizedBox(width: 8),
              OutlinedButton(onPressed: () {}, child: const Text('In Progress')),
              const SizedBox(width: 8),
              OutlinedButton(onPressed: () {}, child: const Text('In Review')),
              const SizedBox(width: 8),
              OutlinedButton(onPressed: () {}, child: const Text('Due soon')),
            ],
          ),
        ),
      ],
    );
  }
}

class _TaskRow {
  const _TaskRow({
    required this.title,
    required this.community,
    required this.statusLabel,
    required this.statusColor,
    required this.badgeColor,
    required this.badgeTextColor,
    required this.badgeBorderColor,
    required this.deadline,
    required this.dependencies,
    this.isCompleted = false,
    this.outlined = false,
  });

  final String title;
  final String community;
  final String statusLabel;
  final Color statusColor;
  final Color badgeColor;
  final Color badgeTextColor;
  final Color badgeBorderColor;
  final String deadline;
  final String dependencies;
  final bool isCompleted;
  final bool outlined;
}

const _taskRows = [
  _TaskRow(
    title: 'Finalize event poster',
    community: 'Design Circle',
    statusLabel: 'In Progress',
    statusColor: Color(0xFF3B82F6),
    badgeColor: Color(0xFFDBEAFE),
    badgeTextColor: Color(0xFF1D4ED8),
    badgeBorderColor: Color(0xFFBFDBFE),
    deadline: 'May 21',
    dependencies: 'Venue confirmed',
  ),
  _TaskRow(
    title: 'Review volunteer map',
    community: 'Campus Volunteers',
    statusLabel: 'In Review',
    statusColor: Color(0xFFF59E0B),
    badgeColor: Color(0xFFFEF3C7),
    badgeTextColor: Color(0xFFB45309),
    badgeBorderColor: Color(0xFFFDE68A),
    deadline: 'May 23',
    dependencies: 'None',
  ),
  _TaskRow(
    title: 'Prepare mentor notes',
    community: 'Code Bloom',
    statusLabel: 'To Be Assigned',
    statusColor: Color(0xFFD1D5DB),
    badgeColor: Color(0xFFF4F4F5),
    badgeTextColor: Color(0xFF6B7280),
    badgeBorderColor: Color(0xFFE5E7EB),
    deadline: 'May 27',
    dependencies: 'Mentor list',
    outlined: true,
  ),
  _TaskRow(
    title: 'Publish event recap',
    community: 'Design Circle',
    statusLabel: 'Done',
    statusColor: Color(0xFF10B981),
    badgeColor: Color(0xFFD1FAE5),
    badgeTextColor: Color(0xFF047857),
    badgeBorderColor: Color(0xFFA7F3D0),
    deadline: 'May 18',
    dependencies: 'Photos uploaded',
    isCompleted: true,
  ),
];
