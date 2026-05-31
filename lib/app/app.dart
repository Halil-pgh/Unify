import 'package:flutter/material.dart';

import 'router/app_router.dart';
import 'theme/app_theme.dart';

class UnifyApp extends StatelessWidget {
  const UnifyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Unify',
      theme: AppTheme.light(),
      routerConfig: AppRouter.router,
    );
  }
}
