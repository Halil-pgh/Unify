import 'package:flutter/material.dart';

import '../../../../app/router/app_router.dart';
import '../../../../app/theme/app_theme.dart';
import '../../../../shared/widgets/app_scaffold.dart';
import '../../../../shared/widgets/unify_card.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool _taskReminders = true;
  bool _eventUpdates = true;
  bool _milestones = true;
  bool _weeklySummary = false;

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      currentRouteName: AppRouteNames.profile,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _Header(),
          const SizedBox(height: 24),
          LayoutBuilder(
            builder: (context, constraints) {
              final isWide = constraints.maxWidth >= 900;
              if (isWide) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: _ProfileCard(),
                    ),
                    const SizedBox(width: 24),
                    Expanded(
                      flex: 2,
                      child: _PreferencesCard(
                        taskReminders: _taskReminders,
                        eventUpdates: _eventUpdates,
                        milestones: _milestones,
                        weeklySummary: _weeklySummary,
                        onTaskRemindersChanged: (value) =>
                            setState(() => _taskReminders = value),
                        onEventUpdatesChanged: (value) =>
                            setState(() => _eventUpdates = value),
                        onMilestonesChanged: (value) =>
                            setState(() => _milestones = value),
                        onWeeklySummaryChanged: (value) =>
                            setState(() => _weeklySummary = value),
                      ),
                    ),
                  ],
                );
              }

              return Column(
                children: [
                  const _ProfileCard(),
                  const SizedBox(height: 24),
                  _PreferencesCard(
                    taskReminders: _taskReminders,
                    eventUpdates: _eventUpdates,
                    milestones: _milestones,
                    weeklySummary: _weeklySummary,
                    onTaskRemindersChanged: (value) =>
                        setState(() => _taskReminders = value),
                    onEventUpdatesChanged: (value) =>
                        setState(() => _eventUpdates = value),
                    onMilestonesChanged: (value) =>
                        setState(() => _milestones = value),
                    onWeeklySummaryChanged: (value) =>
                        setState(() => _weeklySummary = value),
                  ),
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

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Profile & settings'.toUpperCase(),
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
          'Mira Yilmaz',
          style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w700,
              ) ??
              const TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
        ),
      ],
    );
  }
}

class _ProfileCard extends StatelessWidget {
  const _ProfileCard();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final unify = theme.extension<UnifyThemeColors>()!;

    return UnifyCard(
      child: Column(
        children: [
          CircleAvatar(
            radius: 48,
            backgroundColor: theme.colorScheme.primary.withOpacity(0.2),
            child: Text(
              'MY',
              style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Mira Yilmaz',
            style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                ) ??
                const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 8),
          Text(
            'Moderator in Design Circle\nMember in Campus Volunteers',
            textAlign: TextAlign.center,
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

class _PreferencesCard extends StatelessWidget {
  const _PreferencesCard({
    required this.taskReminders,
    required this.eventUpdates,
    required this.milestones,
    required this.weeklySummary,
    required this.onTaskRemindersChanged,
    required this.onEventUpdatesChanged,
    required this.onMilestonesChanged,
    required this.onWeeklySummaryChanged,
  });

  final bool taskReminders;
  final bool eventUpdates;
  final bool milestones;
  final bool weeklySummary;
  final ValueChanged<bool> onTaskRemindersChanged;
  final ValueChanged<bool> onEventUpdatesChanged;
  final ValueChanged<bool> onMilestonesChanged;
  final ValueChanged<bool> onWeeklySummaryChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final unify = theme.extension<UnifyThemeColors>()!;

    return UnifyCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Preferences'.toUpperCase(),
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
          const SizedBox(height: 6),
          Text(
            'Notifications',
            style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                ) ??
                const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 16),
          _PreferenceToggle(
            label: 'Task deadline reminders',
            value: taskReminders,
            onChanged: onTaskRemindersChanged,
          ),
          _PreferenceToggle(
            label: 'Joined event updates',
            value: eventUpdates,
            onChanged: onEventUpdatesChanged,
          ),
          _PreferenceToggle(
            label: 'Community companion milestones',
            value: milestones,
            onChanged: onMilestonesChanged,
          ),
          _PreferenceToggle(
            label: 'Weekly summary email',
            value: weeklySummary,
            onChanged: onWeeklySummaryChanged,
          ),
        ],
      ),
    );
  }
}

class _PreferenceToggle extends StatelessWidget {
  const _PreferenceToggle({
    required this.label,
    required this.value,
    required this.onChanged,
  });

  final String label;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    final unify = Theme.of(context).extension<UnifyThemeColors>()!;

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: unify.border.withOpacity(0.6)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ),
          Checkbox(
            value: value,
            onChanged: (value) => onChanged(value ?? false),
          ),
        ],
      ),
    );
  }
}
