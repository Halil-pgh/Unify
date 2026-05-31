import 'package:go_router/go_router.dart';

import '../../features/calendar/presentation/pages/calendar_page.dart';
import '../../features/communities/presentation/pages/communities_page.dart';
import '../../features/dashboard/presentation/pages/dashboard_page.dart';
import '../../features/explore/presentation/pages/explore_page.dart';
import '../../features/home/presentation/pages/home_page.dart';
import '../../features/profile/presentation/pages/profile_page.dart';
import '../../features/tasks/presentation/pages/tasks_page.dart';
import '../../features/welcome/presentation/pages/welcome_page.dart';

class AppRouteNames {
  const AppRouteNames._();

  static const welcome = 'welcome';
  static const home = 'home';
  static const explore = 'explore';
  static const communities = 'communities';
  static const tasks = 'tasks';
  static const calendar = 'calendar';
  static const profile = 'profile';
  static const dashboard = 'dashboard';
}

class AppRouter {
  const AppRouter._();

  static final router = GoRouter(
    routes: [
      GoRoute(
        name: AppRouteNames.welcome,
        path: '/',
        builder: (context, state) => const WelcomePage(),
      ),
      GoRoute(
        name: AppRouteNames.home,
        path: '/home',
        builder: (context, state) => const HomePage(),
      ),
      GoRoute(
        name: AppRouteNames.explore,
        path: '/explore',
        builder: (context, state) => const ExplorePage(),
      ),
      GoRoute(
        name: AppRouteNames.communities,
        path: '/communities',
        builder: (context, state) => const CommunitiesPage(),
      ),
      GoRoute(
        name: AppRouteNames.tasks,
        path: '/tasks',
        builder: (context, state) => const TasksPage(),
      ),
      GoRoute(
        name: AppRouteNames.calendar,
        path: '/calendar',
        builder: (context, state) => const CalendarPage(),
      ),
      GoRoute(
        name: AppRouteNames.profile,
        path: '/profile',
        builder: (context, state) => const ProfilePage(),
      ),
      GoRoute(
        name: AppRouteNames.dashboard,
        path: '/dashboard',
        builder: (context, state) => const DashboardPage(),
      ),
    ],
  );
}
