import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../app/router/app_router.dart';
import '../../app/theme/app_theme.dart';

class AppSidebar extends StatelessWidget {
  const AppSidebar({
    super.key,
    required this.currentRouteName,
    this.isDrawer = false,
  });

  final String currentRouteName;
  final bool isDrawer;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final unify = theme.extension<UnifyThemeColors>()!;

    return Container(
      width: 280,
      color: theme.colorScheme.surface,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Row(
                children: [
                  Container(
                    width: 28,
                    height: 28,
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primary.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: unify.border.withOpacity(0.6)),
                    ),
                    child: Icon(
                      Icons.layers_rounded,
                      size: 16,
                      color: theme.colorScheme.primary,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    'Unify',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.add_circle, size: 18),
                      label: const Text('Quick Create'),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.all(12),
                      minimumSize: const Size(44, 44),
                      shape: const CircleBorder(),
                    ),
                    child: const Icon(Icons.mail_outline, size: 18),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _NavGroup(
                      items: _mainNavigation,
                      currentRouteName: currentRouteName,
                      isDrawer: isDrawer,
                    ),
                    const SizedBox(height: 20),
                    _CommunitiesGroup(isDrawer: isDrawer),
                    const SizedBox(height: 20),
                    _NavGroup(
                      title: 'Secondary',
                      items: _secondaryNavigation,
                      currentRouteName: currentRouteName,
                      isDrawer: isDrawer,
                      enableNavigation: false,
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: _UserCard(isDrawer: isDrawer),
            ),
          ],
        ),
      ),
    );
  }
}

class _NavGroup extends StatelessWidget {
  const _NavGroup({
    required this.items,
    required this.currentRouteName,
    required this.isDrawer,
    this.title,
    this.enableNavigation = true,
  });

  final String? title;
  final List<_NavItem> items;
  final String currentRouteName;
  final bool isDrawer;
  final bool enableNavigation;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: Text(
              title!,
              style: theme.textTheme.labelSmall?.copyWith(
                fontWeight: FontWeight.w700,
                letterSpacing: 1.2,
                color: theme.textTheme.bodySmall?.color?.withOpacity(0.6),
              ),
            ),
          ),
        ...items.map(
          (item) => _NavItemTile(
            item: item,
            isSelected: currentRouteName == item.routeName,
            isDrawer: isDrawer,
            enableNavigation: enableNavigation,
          ),
        ),
      ],
    );
  }
}

class _NavItemTile extends StatelessWidget {
  const _NavItemTile({
    required this.item,
    required this.isSelected,
    required this.isDrawer,
    required this.enableNavigation,
  });

  final _NavItem item;
  final bool isSelected;
  final bool isDrawer;
  final bool enableNavigation;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final selectedColor = theme.colorScheme.primary.withOpacity(0.15);

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(
        color: isSelected ? selectedColor : Colors.transparent,
        borderRadius: BorderRadius.circular(14),
      ),
      child: ListTile(
        dense: true,
        leading: Icon(item.icon, size: 20),
        title: Text(
          item.label,
          style: theme.textTheme.bodyMedium?.copyWith(
            fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
          ),
        ),
        onTap: enableNavigation
            ? () {
                if (isDrawer) {
                  Navigator.of(context).pop();
                }
                context.goNamed(item.routeName);
              }
            : null,
        trailing: item.trailing,
        minLeadingWidth: 20,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        selected: isSelected,
      ),
    );
  }
}

class _CommunitiesGroup extends StatelessWidget {
  const _CommunitiesGroup({required this.isDrawer});

  final bool isDrawer;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final labelStyle = theme.textTheme.labelSmall?.copyWith(
      fontWeight: FontWeight.w700,
      letterSpacing: 1.2,
      color: theme.textTheme.bodySmall?.color?.withOpacity(0.6),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          child: Text('Your Communities', style: labelStyle),
        ),
        ..._communityItems.map(
          (item) => _NavItemTile(
            item: _NavItem(
              label: item.name,
              routeName: AppRouteNames.communities,
              icon: item.icon,
              trailing: PopupMenuButton<_CommunityAction>(
                icon: const Icon(Icons.more_horiz, size: 18),
                onSelected: (_) {},
                itemBuilder: (context) => const [
                  PopupMenuItem(
                    value: _CommunityAction.view,
                    child: Text('View Details'),
                  ),
                  PopupMenuItem(
                    value: _CommunityAction.share,
                    child: Text('Share'),
                  ),
                  PopupMenuDivider(),
                  PopupMenuItem(
                    value: _CommunityAction.leave,
                    child: Text('Leave'),
                  ),
                ],
              ),
            ),
            isSelected: false,
            isDrawer: isDrawer,
            enableNavigation: true,
          ),
        ),
        _NavItemTile(
          item: _NavItem(
            label: 'More',
            routeName: AppRouteNames.communities,
            icon: Icons.more_horiz,
          ),
          isSelected: false,
          isDrawer: isDrawer,
          enableNavigation: false,
        ),
      ],
    );
  }
}

class _UserCard extends StatelessWidget {
  const _UserCard({required this.isDrawer});

  final bool isDrawer;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final unify = theme.extension<UnifyThemeColors>()!;

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: unify.surfaceMuted.withOpacity(0.3),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: unify.border.withOpacity(0.6)),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 18,
            backgroundColor: theme.colorScheme.primary.withOpacity(0.2),
            child: Text(
              'MY',
              style: theme.textTheme.labelMedium?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Mira Yilmaz',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  'user@example.com',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: unify.mutedForeground,
                  ),
                ),
              ],
            ),
          ),
          PopupMenuButton<_UserAction>(
            icon: const Icon(Icons.more_vert, size: 18),
            onSelected: (_) {},
            itemBuilder: (context) => const [
              PopupMenuItem(
                value: _UserAction.account,
                child: Text('Account'),
              ),
              PopupMenuItem(
                value: _UserAction.billing,
                child: Text('Billing'),
              ),
              PopupMenuItem(
                value: _UserAction.notifications,
                child: Text('Notifications'),
              ),
              PopupMenuDivider(),
              PopupMenuItem(
                value: _UserAction.logout,
                child: Text('Log out'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _NavItem {
  const _NavItem({
    required this.label,
    required this.routeName,
    required this.icon,
    this.trailing,
  });

  final String label;
  final String routeName;
  final IconData icon;
  final Widget? trailing;
}

class _CommunityItem {
  const _CommunityItem({required this.name, required this.icon});

  final String name;
  final IconData icon;
}

enum _CommunityAction { view, share, leave }

enum _UserAction { account, billing, notifications, logout }

const _mainNavigation = [
  _NavItem(
    label: 'Welcome',
    routeName: AppRouteNames.welcome,
    icon: Icons.auto_awesome,
  ),
  _NavItem(label: 'Home', routeName: AppRouteNames.home, icon: Icons.home),
  _NavItem(label: 'Explore', routeName: AppRouteNames.explore, icon: Icons.explore),
  _NavItem(
    label: 'Communities',
    routeName: AppRouteNames.communities,
    icon: Icons.groups,
  ),
  _NavItem(label: 'Tasks', routeName: AppRouteNames.tasks, icon: Icons.assignment),
  _NavItem(
    label: 'Calendar',
    routeName: AppRouteNames.calendar,
    icon: Icons.calendar_today,
  ),
];

const _secondaryNavigation = [
  _NavItem(label: 'Settings', routeName: AppRouteNames.profile, icon: Icons.settings),
  _NavItem(label: 'Get Help', routeName: AppRouteNames.profile, icon: Icons.help_outline),
  _NavItem(label: 'Search', routeName: AppRouteNames.profile, icon: Icons.search),
];

const _communityItems = [
  _CommunityItem(name: 'Svelte Developers', icon: Icons.star_border),
  _CommunityItem(name: 'UI/UX Design', icon: Icons.label_outline),
  _CommunityItem(name: 'Frontend Masters', icon: Icons.shield_outlined),
];
