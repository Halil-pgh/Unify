import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../app/router/app_router.dart';
import '../../app/theme/app_theme.dart';
import '../../core/extensions/color_extensions.dart';
import 'app_sidebar.dart';

class AppScaffold extends StatelessWidget {
  const AppScaffold({
    super.key,
    required this.currentRouteName,
    required this.child,
  });

  final String currentRouteName;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth >= 1024;
        final horizontalPadding = isWide ? 32.0 : 16.0;
        final verticalPadding = isWide ? 32.0 : 24.0;

        return Scaffold(
          drawer: isWide
              ? null
              : Drawer(
                  child: AppSidebar(
                    currentRouteName: currentRouteName,
                    isDrawer: true,
                  ),
                ),
          body: Row(
            children: [
              if (isWide)
                AppSidebar(
                  currentRouteName: currentRouteName,
                ),
              Expanded(
                child: Column(
                  children: [
                    _TopBar(isWide: isWide),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Center(
                          child: ConstrainedBox(
                            constraints: const BoxConstraints(maxWidth: 1152),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: horizontalPadding,
                                vertical: verticalPadding,
                              ),
                              child: child,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _TopBar extends StatelessWidget {
  const _TopBar({required this.isWide});

  final bool isWide;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final unify = theme.extension<UnifyThemeColors>()!;

    return Container(
      height: 56,
      decoration: BoxDecoration(
        color: theme.colorScheme.surface.withOpacityValue(0.96),
        border: Border(
          bottom: BorderSide(color: unify.border.withOpacityValue(0.7)),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          if (!isWide)
            Builder(
              builder: (context) => IconButton(
                onPressed: () => Scaffold.of(context).openDrawer(),
                icon: const Icon(Icons.menu),
              ),
            ),
          const Spacer(),
          if (!isWide)
            InkWell(
              borderRadius: BorderRadius.circular(20),
              onTap: () => context.goNamed(AppRouteNames.profile),
              child: CircleAvatar(
                radius: 16,
                backgroundColor: theme.colorScheme.primary.withOpacityValue(0.2),
                child: Text(
                  'MY',
                  style: theme.textTheme.labelMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
