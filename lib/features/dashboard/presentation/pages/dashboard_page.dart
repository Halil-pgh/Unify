import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../../../app/router/app_router.dart';
import '../../../../app/theme/app_theme.dart';
import '../../../../shared/widgets/app_scaffold.dart';
import '../../../../shared/widgets/unify_badge.dart';
import '../../../../shared/widgets/unify_card.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  String _timeRange = '90d';
  String _selectedView = 'outline';

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      currentRouteName: AppRouteNames.dashboard,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _DashboardHeader(),
          const SizedBox(height: 24),
          _SectionCards(),
          const SizedBox(height: 24),
          _TrafficCard(
            timeRange: _timeRange,
            onTimeRangeChanged: (value) => setState(() => _timeRange = value),
          ),
          const SizedBox(height: 24),
          _TableHeader(
            selectedView: _selectedView,
            onViewChanged: (value) => setState(() => _selectedView = value),
          ),
          const SizedBox(height: 16),
          _DocumentsTable(),
        ],
      ),
    );
  }
}

class _DashboardHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final unify = theme.extension<UnifyThemeColors>()!;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: unify.border.withOpacity(0.7)),
      ),
      child: Row(
        children: [
          Text(
            'Documents',
            style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                ) ??
                const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
          ),
          const Spacer(),
          OutlinedButton(
            onPressed: () {},
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            ),
            child: const Text('GitHub'),
          ),
        ],
      ),
    );
  }
}

class _SectionCards extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final columns = width >= 1100 ? 4 : width >= 720 ? 2 : 1;
        final cardWidth = (width - (columns - 1) * 16) / columns;

        return Wrap(
          spacing: 16,
          runSpacing: 16,
          children: _statCards
              .map(
                (stat) => SizedBox(
                  width: cardWidth,
                  child: UnifyCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          stat.title,
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: Theme.of(context)
                                    .extension<UnifyThemeColors>()!
                                    .mutedForeground,
                              ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          stat.value,
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                fontWeight: FontWeight.w700,
                              ) ??
                              const TextStyle(fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(height: 8),
                        UnifyBadge(
                          label: stat.delta,
                          backgroundColor: stat.badgeBackground,
                          textColor: stat.badgeTextColor,
                        ),
                        const SizedBox(height: 12),
                        Text(
                          stat.caption,
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: Theme.of(context)
                                    .extension<UnifyThemeColors>()!
                                    .mutedForeground,
                              ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
              .toList(),
        );
      },
    );
  }
}

class _TrafficCard extends StatelessWidget {
  const _TrafficCard({
    required this.timeRange,
    required this.onTimeRangeChanged,
  });

  final String timeRange;
  final ValueChanged<String> onTimeRangeChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final unify = theme.extension<UnifyThemeColors>()!;
    final filtered = _filterTraffic(timeRange);

    return UnifyCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Total Visitors',
                      style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w700,
                          ) ??
                          const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _rangeLabel(timeRange),
                      style: theme.textTheme.bodySmall?.copyWith(
                            color: unify.mutedForeground,
                          ),
                    ),
                  ],
                ),
              ),
              LayoutBuilder(
                builder: (context, constraints) {
                  if (constraints.maxWidth >= 420) {
                    return ToggleButtons(
                      isSelected: _ranges.map((range) => range == timeRange).toList(),
                      borderRadius: BorderRadius.circular(999),
                      onPressed: (index) => onTimeRangeChanged(_ranges[index]),
                      children: _ranges
                          .map(
                            (range) => Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 6,
                              ),
                              child: Text(_rangeLabel(range)),
                            ),
                          )
                          .toList(),
                    );
                  }

                  return DropdownButton<String>(
                    value: timeRange,
                    onChanged: (value) {
                      if (value != null) {
                        onTimeRangeChanged(value);
                      }
                    },
                    items: _ranges
                        .map(
                          (range) => DropdownMenuItem(
                            value: range,
                            child: Text(_rangeLabel(range)),
                          ),
                        )
                        .toList(),
                  );
                },
              ),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 220,
            child: CustomPaint(
              painter: _TrafficChartPainter(
                data: filtered,
                color: theme.colorScheme.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TrafficChartPainter extends CustomPainter {
  _TrafficChartPainter({required this.data, required this.color});

  final List<_TrafficPoint> data;
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    if (data.length < 2) {
      return;
    }

    final maxValue = data
        .map((point) => math.max(point.desktop, point.mobile))
        .fold<double>(0, math.max);

    final desktopPath = _buildPath(size, maxValue, (point) => point.desktop);
    final mobilePath = _buildPath(size, maxValue, (point) => point.mobile);

    final desktopFill = Paint()
      ..color = color.withOpacity(0.18)
      ..style = PaintingStyle.fill;
    final mobileFill = Paint()
      ..color = color.withOpacity(0.1)
      ..style = PaintingStyle.fill;

    canvas.drawPath(_fillPath(desktopPath, size), desktopFill);
    canvas.drawPath(_fillPath(mobilePath, size), mobileFill);

    final linePaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    canvas.drawPath(desktopPath, linePaint);
    canvas.drawPath(mobilePath, linePaint..color = color.withOpacity(0.6));
  }

  Path _buildPath(
    Size size,
    double maxValue,
    double Function(_TrafficPoint) valueOf,
  ) {
    final path = Path();
    for (var i = 0; i < data.length; i++) {
      final point = data[i];
      final x = (i / (data.length - 1)) * size.width;
      final value = valueOf(point);
      final y = size.height - (value / maxValue) * size.height;
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }
    return path;
  }

  Path _fillPath(Path linePath, Size size) {
    final filled = Path.from(linePath);
    filled.lineTo(size.width, size.height);
    filled.lineTo(0, size.height);
    filled.close();
    return filled;
  }

  @override
  bool shouldRepaint(covariant _TrafficChartPainter oldDelegate) {
    return oldDelegate.data != data || oldDelegate.color != color;
  }
}

class _TableHeader extends StatelessWidget {
  const _TableHeader({required this.selectedView, required this.onViewChanged});

  final String selectedView;
  final ValueChanged<String> onViewChanged;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth >= 720;

        return Row(
          children: [
            if (!isWide)
              DropdownButton<String>(
                value: selectedView,
                onChanged: (value) {
                  if (value != null) {
                    onViewChanged(value);
                  }
                },
                items: _views
                    .map(
                      (view) => DropdownMenuItem(
                        value: view.id,
                        child: Text(view.label),
                      ),
                    )
                    .toList(),
              )
            else
              Expanded(
                child: Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: _views
                      .map(
                        (view) => ChoiceChip(
                          label: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(view.label),
                              if (view.badge > 0) ...[
                                const SizedBox(width: 6),
                                CircleAvatar(
                                  radius: 10,
                                  backgroundColor: Theme.of(context)
                                      .extension<UnifyThemeColors>()!
                                      .surfaceMuted,
                                  child: Text(
                                    view.badge.toString(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelSmall
                                        ?.copyWith(fontSize: 10),
                                  ),
                                ),
                              ],
                            ],
                          ),
                          selected: selectedView == view.id,
                          onSelected: (_) => onViewChanged(view.id),
                        ),
                      )
                      .toList(),
                ),
              ),
            const SizedBox(width: 12),
            OutlinedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.view_column_outlined, size: 18),
              label: const Text('Columns'),
            ),
            const SizedBox(width: 8),
            OutlinedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.add, size: 18),
              label: const Text('Add Section'),
            ),
          ],
        );
      },
    );
  }
}

class _DocumentsTable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final unify = Theme.of(context).extension<UnifyThemeColors>()!;

    return UnifyCard(
      padding: EdgeInsets.zero,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          headingRowColor: MaterialStateProperty.all(unify.surfaceMuted.withOpacity(0.35)),
          columns: const [
            DataColumn(label: Text('Header')),
            DataColumn(label: Text('Section Type')),
            DataColumn(label: Text('Status')),
            DataColumn(label: Text('Target')),
            DataColumn(label: Text('Limit')),
            DataColumn(label: Text('Reviewer')),
          ],
          rows: _documentRows
              .map(
                (row) => DataRow(
                  cells: [
                    DataCell(Text(row.header)),
                    DataCell(
                      UnifyBadge(
                        label: row.type,
                        backgroundColor: unify.surfaceMuted.withOpacity(0.4),
                        textColor: unify.mutedForeground,
                      ),
                    ),
                    DataCell(
                      UnifyBadge(
                        label: row.status,
                        backgroundColor: row.status == 'Done'
                            ? const Color(0xFFD1FAE5)
                            : const Color(0xFFE0E7FF),
                        textColor: row.status == 'Done'
                            ? const Color(0xFF047857)
                            : const Color(0xFF4338CA),
                      ),
                    ),
                    DataCell(Text(row.target)),
                    DataCell(Text(row.limit)),
                    DataCell(Text(row.reviewer)),
                  ],
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}

String _rangeLabel(String range) {
  switch (range) {
    case '90d':
      return 'Last 3 months';
    case '30d':
      return 'Last 30 days';
    case '7d':
      return 'Last 7 days';
    default:
      return 'Last 3 months';
  }
}

List<_TrafficPoint> _filterTraffic(String range) {
  final reference = DateTime(2024, 6, 30);
  var days = 90;
  if (range == '30d') {
    days = 30;
  } else if (range == '7d') {
    days = 7;
  }

  final start = reference.subtract(Duration(days: days));
  return _trafficData.where((point) => point.date.isAfter(start)).toList();
}

class _StatCardData {
  const _StatCardData({
    required this.title,
    required this.value,
    required this.delta,
    required this.caption,
    required this.badgeBackground,
    required this.badgeTextColor,
  });

  final String title;
  final String value;
  final String delta;
  final String caption;
  final Color badgeBackground;
  final Color badgeTextColor;
}

class _ViewData {
  const _ViewData({
    required this.id,
    required this.label,
    required this.badge,
  });

  final String id;
  final String label;
  final int badge;
}

class _TrafficPoint {
  const _TrafficPoint({
    required this.date,
    required this.desktop,
    required this.mobile,
  });

  final DateTime date;
  final double desktop;
  final double mobile;
}

class _DocumentRow {
  const _DocumentRow({
    required this.header,
    required this.type,
    required this.status,
    required this.target,
    required this.limit,
    required this.reviewer,
  });

  final String header;
  final String type;
  final String status;
  final String target;
  final String limit;
  final String reviewer;
}

const _ranges = ['90d', '30d', '7d'];

const _views = [
  _ViewData(id: 'outline', label: 'Outline', badge: 0),
  _ViewData(id: 'past-performance', label: 'Past Performance', badge: 3),
  _ViewData(id: 'key-personnel', label: 'Key Personnel', badge: 2),
  _ViewData(id: 'focus-documents', label: 'Focus Documents', badge: 0),
];

const _statCards = [
  _StatCardData(
    title: 'Total Revenue',
    value: r'$1,250.00',
    delta: '+12.5%',
    caption: 'Trending up this month',
    badgeBackground: Color(0xFFD1FAE5),
    badgeTextColor: Color(0xFF047857),
  ),
  _StatCardData(
    title: 'New Customers',
    value: '1,234',
    delta: '-20%',
    caption: 'Acquisition needs attention',
    badgeBackground: Color(0xFFFEE2E2),
    badgeTextColor: Color(0xFFB91C1C),
  ),
  _StatCardData(
    title: 'Active Accounts',
    value: '45,678',
    delta: '+12.5%',
    caption: 'Strong user retention',
    badgeBackground: Color(0xFFD1FAE5),
    badgeTextColor: Color(0xFF047857),
  ),
  _StatCardData(
    title: 'Growth Rate',
    value: '4.5%',
    delta: '+4.5%',
    caption: 'Meets growth projections',
    badgeBackground: Color(0xFFD1FAE5),
    badgeTextColor: Color(0xFF047857),
  ),
];

final _trafficData = [
  _TrafficPoint(date: DateTime(2024, 4, 1), desktop: 222, mobile: 150),
  _TrafficPoint(date: DateTime(2024, 4, 2), desktop: 97, mobile: 180),
  _TrafficPoint(date: DateTime(2024, 4, 3), desktop: 167, mobile: 120),
  _TrafficPoint(date: DateTime(2024, 4, 4), desktop: 242, mobile: 260),
  _TrafficPoint(date: DateTime(2024, 4, 5), desktop: 373, mobile: 290),
  _TrafficPoint(date: DateTime(2024, 4, 6), desktop: 301, mobile: 340),
  _TrafficPoint(date: DateTime(2024, 4, 7), desktop: 245, mobile: 180),
  _TrafficPoint(date: DateTime(2024, 4, 8), desktop: 409, mobile: 320),
  _TrafficPoint(date: DateTime(2024, 4, 9), desktop: 59, mobile: 110),
  _TrafficPoint(date: DateTime(2024, 4, 10), desktop: 261, mobile: 190),
  _TrafficPoint(date: DateTime(2024, 4, 11), desktop: 327, mobile: 350),
  _TrafficPoint(date: DateTime(2024, 4, 12), desktop: 292, mobile: 210),
  _TrafficPoint(date: DateTime(2024, 4, 13), desktop: 342, mobile: 380),
  _TrafficPoint(date: DateTime(2024, 4, 14), desktop: 137, mobile: 220),
  _TrafficPoint(date: DateTime(2024, 4, 15), desktop: 120, mobile: 170),
  _TrafficPoint(date: DateTime(2024, 4, 16), desktop: 138, mobile: 190),
  _TrafficPoint(date: DateTime(2024, 4, 17), desktop: 446, mobile: 360),
  _TrafficPoint(date: DateTime(2024, 4, 18), desktop: 364, mobile: 410),
  _TrafficPoint(date: DateTime(2024, 4, 19), desktop: 243, mobile: 180),
  _TrafficPoint(date: DateTime(2024, 4, 20), desktop: 89, mobile: 150),
  _TrafficPoint(date: DateTime(2024, 4, 21), desktop: 137, mobile: 200),
  _TrafficPoint(date: DateTime(2024, 4, 22), desktop: 224, mobile: 170),
  _TrafficPoint(date: DateTime(2024, 4, 23), desktop: 138, mobile: 230),
  _TrafficPoint(date: DateTime(2024, 4, 24), desktop: 387, mobile: 290),
  _TrafficPoint(date: DateTime(2024, 4, 25), desktop: 215, mobile: 250),
  _TrafficPoint(date: DateTime(2024, 4, 26), desktop: 75, mobile: 130),
  _TrafficPoint(date: DateTime(2024, 4, 27), desktop: 383, mobile: 420),
  _TrafficPoint(date: DateTime(2024, 4, 28), desktop: 122, mobile: 180),
  _TrafficPoint(date: DateTime(2024, 4, 29), desktop: 315, mobile: 240),
  _TrafficPoint(date: DateTime(2024, 4, 30), desktop: 454, mobile: 380),
  _TrafficPoint(date: DateTime(2024, 5, 1), desktop: 165, mobile: 220),
  _TrafficPoint(date: DateTime(2024, 5, 2), desktop: 293, mobile: 310),
  _TrafficPoint(date: DateTime(2024, 5, 3), desktop: 247, mobile: 190),
  _TrafficPoint(date: DateTime(2024, 5, 4), desktop: 385, mobile: 420),
  _TrafficPoint(date: DateTime(2024, 5, 5), desktop: 481, mobile: 390),
  _TrafficPoint(date: DateTime(2024, 5, 6), desktop: 498, mobile: 520),
  _TrafficPoint(date: DateTime(2024, 5, 7), desktop: 388, mobile: 300),
  _TrafficPoint(date: DateTime(2024, 5, 8), desktop: 149, mobile: 210),
  _TrafficPoint(date: DateTime(2024, 5, 9), desktop: 227, mobile: 180),
  _TrafficPoint(date: DateTime(2024, 5, 10), desktop: 293, mobile: 330),
  _TrafficPoint(date: DateTime(2024, 5, 11), desktop: 335, mobile: 270),
  _TrafficPoint(date: DateTime(2024, 5, 12), desktop: 197, mobile: 240),
  _TrafficPoint(date: DateTime(2024, 5, 13), desktop: 197, mobile: 160),
  _TrafficPoint(date: DateTime(2024, 5, 14), desktop: 448, mobile: 490),
  _TrafficPoint(date: DateTime(2024, 5, 15), desktop: 473, mobile: 380),
  _TrafficPoint(date: DateTime(2024, 5, 16), desktop: 338, mobile: 400),
  _TrafficPoint(date: DateTime(2024, 5, 17), desktop: 499, mobile: 420),
  _TrafficPoint(date: DateTime(2024, 5, 18), desktop: 315, mobile: 350),
  _TrafficPoint(date: DateTime(2024, 5, 19), desktop: 235, mobile: 180),
  _TrafficPoint(date: DateTime(2024, 5, 20), desktop: 177, mobile: 230),
  _TrafficPoint(date: DateTime(2024, 5, 21), desktop: 82, mobile: 140),
  _TrafficPoint(date: DateTime(2024, 5, 22), desktop: 81, mobile: 120),
  _TrafficPoint(date: DateTime(2024, 5, 23), desktop: 252, mobile: 290),
  _TrafficPoint(date: DateTime(2024, 5, 24), desktop: 294, mobile: 220),
  _TrafficPoint(date: DateTime(2024, 5, 25), desktop: 201, mobile: 250),
  _TrafficPoint(date: DateTime(2024, 5, 26), desktop: 213, mobile: 170),
  _TrafficPoint(date: DateTime(2024, 5, 27), desktop: 420, mobile: 460),
  _TrafficPoint(date: DateTime(2024, 5, 28), desktop: 233, mobile: 190),
  _TrafficPoint(date: DateTime(2024, 5, 29), desktop: 78, mobile: 130),
  _TrafficPoint(date: DateTime(2024, 5, 30), desktop: 340, mobile: 280),
  _TrafficPoint(date: DateTime(2024, 5, 31), desktop: 178, mobile: 230),
  _TrafficPoint(date: DateTime(2024, 6, 1), desktop: 178, mobile: 200),
  _TrafficPoint(date: DateTime(2024, 6, 2), desktop: 470, mobile: 410),
  _TrafficPoint(date: DateTime(2024, 6, 3), desktop: 103, mobile: 160),
  _TrafficPoint(date: DateTime(2024, 6, 4), desktop: 439, mobile: 380),
  _TrafficPoint(date: DateTime(2024, 6, 5), desktop: 88, mobile: 140),
  _TrafficPoint(date: DateTime(2024, 6, 6), desktop: 294, mobile: 250),
  _TrafficPoint(date: DateTime(2024, 6, 7), desktop: 323, mobile: 370),
  _TrafficPoint(date: DateTime(2024, 6, 8), desktop: 385, mobile: 320),
  _TrafficPoint(date: DateTime(2024, 6, 9), desktop: 438, mobile: 480),
  _TrafficPoint(date: DateTime(2024, 6, 10), desktop: 155, mobile: 200),
  _TrafficPoint(date: DateTime(2024, 6, 11), desktop: 92, mobile: 150),
  _TrafficPoint(date: DateTime(2024, 6, 12), desktop: 492, mobile: 420),
  _TrafficPoint(date: DateTime(2024, 6, 13), desktop: 81, mobile: 130),
  _TrafficPoint(date: DateTime(2024, 6, 14), desktop: 426, mobile: 380),
  _TrafficPoint(date: DateTime(2024, 6, 15), desktop: 307, mobile: 350),
  _TrafficPoint(date: DateTime(2024, 6, 16), desktop: 371, mobile: 310),
  _TrafficPoint(date: DateTime(2024, 6, 17), desktop: 475, mobile: 520),
  _TrafficPoint(date: DateTime(2024, 6, 18), desktop: 107, mobile: 170),
  _TrafficPoint(date: DateTime(2024, 6, 19), desktop: 341, mobile: 290),
  _TrafficPoint(date: DateTime(2024, 6, 20), desktop: 408, mobile: 450),
  _TrafficPoint(date: DateTime(2024, 6, 21), desktop: 169, mobile: 210),
  _TrafficPoint(date: DateTime(2024, 6, 22), desktop: 317, mobile: 270),
  _TrafficPoint(date: DateTime(2024, 6, 23), desktop: 480, mobile: 530),
  _TrafficPoint(date: DateTime(2024, 6, 24), desktop: 132, mobile: 180),
  _TrafficPoint(date: DateTime(2024, 6, 25), desktop: 141, mobile: 190),
  _TrafficPoint(date: DateTime(2024, 6, 26), desktop: 434, mobile: 380),
  _TrafficPoint(date: DateTime(2024, 6, 27), desktop: 448, mobile: 490),
  _TrafficPoint(date: DateTime(2024, 6, 28), desktop: 149, mobile: 200),
  _TrafficPoint(date: DateTime(2024, 6, 29), desktop: 103, mobile: 160),
  _TrafficPoint(date: DateTime(2024, 6, 30), desktop: 446, mobile: 400),
];

const _documentRows = [
  _DocumentRow(
    header: 'Cover page',
    type: 'Cover page',
    status: 'In Process',
    target: '18',
    limit: '5',
    reviewer: 'Eddie Lake',
  ),
  _DocumentRow(
    header: 'Table of contents',
    type: 'Table of contents',
    status: 'Done',
    target: '29',
    limit: '24',
    reviewer: 'Eddie Lake',
  ),
  _DocumentRow(
    header: 'Executive summary',
    type: 'Narrative',
    status: 'Done',
    target: '10',
    limit: '13',
    reviewer: 'Eddie Lake',
  ),
  _DocumentRow(
    header: 'Technical approach',
    type: 'Narrative',
    status: 'Done',
    target: '27',
    limit: '23',
    reviewer: 'Jamik Tashpulatov',
  ),
  _DocumentRow(
    header: 'Design',
    type: 'Narrative',
    status: 'In Process',
    target: '2',
    limit: '16',
    reviewer: 'Jamik Tashpulatov',
  ),
  _DocumentRow(
    header: 'Capabilities',
    type: 'Narrative',
    status: 'In Process',
    target: '20',
    limit: '8',
    reviewer: 'Jamik Tashpulatov',
  ),
  _DocumentRow(
    header: 'Integration with existing systems',
    type: 'Narrative',
    status: 'In Process',
    target: '19',
    limit: '21',
    reviewer: 'Jamik Tashpulatov',
  ),
  _DocumentRow(
    header: 'Innovation and Advantages',
    type: 'Narrative',
    status: 'Done',
    target: '25',
    limit: '26',
    reviewer: 'Assign reviewer',
  ),
  _DocumentRow(
    header: "Overview of EMR's Innovative Solutions",
    type: 'Technical content',
    status: 'Done',
    target: '7',
    limit: '23',
    reviewer: 'Assign reviewer',
  ),
  _DocumentRow(
    header: 'Advanced Algorithms and Machine Learning',
    type: 'Narrative',
    status: 'Done',
    target: '30',
    limit: '28',
    reviewer: 'Assign reviewer',
  ),
  _DocumentRow(
    header: 'Adaptive Communication Protocols',
    type: 'Narrative',
    status: 'Done',
    target: '9',
    limit: '31',
    reviewer: 'Assign reviewer',
  ),
  _DocumentRow(
    header: 'Advantages Over Current Technologies',
    type: 'Narrative',
    status: 'Done',
    target: '12',
    limit: '0',
    reviewer: 'Assign reviewer',
  ),
  _DocumentRow(
    header: 'Past Performance',
    type: 'Narrative',
    status: 'Done',
    target: '22',
    limit: '33',
    reviewer: 'Assign reviewer',
  ),
  _DocumentRow(
    header: 'Customer Feedback and Satisfaction Levels',
    type: 'Narrative',
    status: 'Done',
    target: '15',
    limit: '34',
    reviewer: 'Assign reviewer',
  ),
  _DocumentRow(
    header: 'Implementation Challenges and Solutions',
    type: 'Narrative',
    status: 'Done',
    target: '3',
    limit: '35',
    reviewer: 'Assign reviewer',
  ),
  _DocumentRow(
    header: 'Security Measures and Data Protection Policies',
    type: 'Narrative',
    status: 'In Process',
    target: '6',
    limit: '36',
    reviewer: 'Assign reviewer',
  ),
  _DocumentRow(
    header: 'Scalability and Future Proofing',
    type: 'Narrative',
    status: 'Done',
    target: '4',
    limit: '37',
    reviewer: 'Assign reviewer',
  ),
  _DocumentRow(
    header: 'Cost-Benefit Analysis',
    type: 'Plain language',
    status: 'Done',
    target: '14',
    limit: '38',
    reviewer: 'Assign reviewer',
  ),
  _DocumentRow(
    header: 'User Training and Onboarding Experience',
    type: 'Narrative',
    status: 'Done',
    target: '17',
    limit: '39',
    reviewer: 'Assign reviewer',
  ),
  _DocumentRow(
    header: 'Future Development Roadmap',
    type: 'Narrative',
    status: 'Done',
    target: '11',
    limit: '40',
    reviewer: 'Assign reviewer',
  ),
  _DocumentRow(
    header: 'System Architecture Overview',
    type: 'Technical content',
    status: 'In Process',
    target: '24',
    limit: '18',
    reviewer: 'Maya Johnson',
  ),
  _DocumentRow(
    header: 'Risk Management Plan',
    type: 'Narrative',
    status: 'Done',
    target: '15',
    limit: '22',
    reviewer: 'Carlos Rodriguez',
  ),
  _DocumentRow(
    header: 'Compliance Documentation',
    type: 'Legal',
    status: 'In Process',
    target: '31',
    limit: '27',
    reviewer: 'Sarah Chen',
  ),
  _DocumentRow(
    header: 'API Documentation',
    type: 'Technical content',
    status: 'Done',
    target: '8',
    limit: '12',
    reviewer: 'Raj Patel',
  ),
  _DocumentRow(
    header: 'User Interface Mockups',
    type: 'Visual',
    status: 'In Process',
    target: '19',
    limit: '25',
    reviewer: 'Leila Ahmadi',
  ),
  _DocumentRow(
    header: 'Database Schema',
    type: 'Technical content',
    status: 'Done',
    target: '22',
    limit: '20',
    reviewer: 'Thomas Wilson',
  ),
  _DocumentRow(
    header: 'Testing Methodology',
    type: 'Technical content',
    status: 'In Process',
    target: '17',
    limit: '14',
    reviewer: 'Assign reviewer',
  ),
  _DocumentRow(
    header: 'Deployment Strategy',
    type: 'Narrative',
    status: 'Done',
    target: '26',
    limit: '30',
    reviewer: 'Eddie Lake',
  ),
  _DocumentRow(
    header: 'Budget Breakdown',
    type: 'Financial',
    status: 'In Process',
    target: '13',
    limit: '16',
    reviewer: 'Jamik Tashpulatov',
  ),
  _DocumentRow(
    header: 'Market Analysis',
    type: 'Research',
    status: 'Done',
    target: '29',
    limit: '32',
    reviewer: 'Sophia Martinez',
  ),
  _DocumentRow(
    header: 'Competitor Comparison',
    type: 'Research',
    status: 'In Process',
    target: '21',
    limit: '19',
    reviewer: 'Assign reviewer',
  ),
  _DocumentRow(
    header: 'Maintenance Plan',
    type: 'Technical content',
    status: 'Done',
    target: '16',
    limit: '23',
    reviewer: 'Alex Thompson',
  ),
  _DocumentRow(
    header: 'User Personas',
    type: 'Research',
    status: 'In Process',
    target: '27',
    limit: '24',
    reviewer: 'Nina Patel',
  ),
  _DocumentRow(
    header: 'Accessibility Compliance',
    type: 'Legal',
    status: 'Done',
    target: '18',
    limit: '21',
    reviewer: 'Assign reviewer',
  ),
  _DocumentRow(
    header: 'Performance Metrics',
    type: 'Technical content',
    status: 'In Process',
    target: '23',
    limit: '26',
    reviewer: 'David Kim',
  ),
  _DocumentRow(
    header: 'Disaster Recovery Plan',
    type: 'Technical content',
    status: 'Done',
    target: '14',
    limit: '17',
    reviewer: 'Jamik Tashpulatov',
  ),
  _DocumentRow(
    header: 'Third-party Integrations',
    type: 'Technical content',
    status: 'In Process',
    target: '25',
    limit: '28',
    reviewer: 'Eddie Lake',
  ),
  _DocumentRow(
    header: 'User Feedback Summary',
    type: 'Research',
    status: 'Done',
    target: '20',
    limit: '15',
    reviewer: 'Assign reviewer',
  ),
  _DocumentRow(
    header: 'Localization Strategy',
    type: 'Narrative',
    status: 'In Process',
    target: '12',
    limit: '19',
    reviewer: 'Maria Garcia',
  ),
  _DocumentRow(
    header: 'Mobile Compatibility',
    type: 'Technical content',
    status: 'Done',
    target: '28',
    limit: '31',
    reviewer: 'James Wilson',
  ),
  _DocumentRow(
    header: 'Data Migration Plan',
    type: 'Technical content',
    status: 'In Process',
    target: '19',
    limit: '22',
    reviewer: 'Assign reviewer',
  ),
  _DocumentRow(
    header: 'Quality Assurance Protocols',
    type: 'Technical content',
    status: 'Done',
    target: '30',
    limit: '33',
    reviewer: 'Priya Singh',
  ),
  _DocumentRow(
    header: 'Stakeholder Analysis',
    type: 'Research',
    status: 'In Process',
    target: '11',
    limit: '14',
    reviewer: 'Eddie Lake',
  ),
  _DocumentRow(
    header: 'Environmental Impact Assessment',
    type: 'Research',
    status: 'Done',
    target: '24',
    limit: '27',
    reviewer: 'Assign reviewer',
  ),
  _DocumentRow(
    header: 'Intellectual Property Rights',
    type: 'Legal',
    status: 'In Process',
    target: '17',
    limit: '20',
    reviewer: 'Sarah Johnson',
  ),
  _DocumentRow(
    header: 'Customer Support Framework',
    type: 'Narrative',
    status: 'Done',
    target: '22',
    limit: '25',
    reviewer: 'Jamik Tashpulatov',
  ),
  _DocumentRow(
    header: 'Version Control Strategy',
    type: 'Technical content',
    status: 'In Process',
    target: '15',
    limit: '18',
    reviewer: 'Assign reviewer',
  ),
  _DocumentRow(
    header: 'Continuous Integration Pipeline',
    type: 'Technical content',
    status: 'Done',
    target: '26',
    limit: '29',
    reviewer: 'Michael Chen',
  ),
  _DocumentRow(
    header: 'Regulatory Compliance',
    type: 'Legal',
    status: 'In Process',
    target: '13',
    limit: '16',
    reviewer: 'Assign reviewer',
  ),
  _DocumentRow(
    header: 'User Authentication System',
    type: 'Technical content',
    status: 'Done',
    target: '28',
    limit: '31',
    reviewer: 'Eddie Lake',
  ),
  _DocumentRow(
    header: 'Data Analytics Framework',
    type: 'Technical content',
    status: 'In Process',
    target: '21',
    limit: '24',
    reviewer: 'Jamik Tashpulatov',
  ),
  _DocumentRow(
    header: 'Cloud Infrastructure',
    type: 'Technical content',
    status: 'Done',
    target: '16',
    limit: '19',
    reviewer: 'Assign reviewer',
  ),
  _DocumentRow(
    header: 'Network Security Measures',
    type: 'Technical content',
    status: 'In Process',
    target: '29',
    limit: '32',
    reviewer: 'Lisa Wong',
  ),
  _DocumentRow(
    header: 'Project Timeline',
    type: 'Planning',
    status: 'Done',
    target: '14',
    limit: '17',
    reviewer: 'Eddie Lake',
  ),
  _DocumentRow(
    header: 'Resource Allocation',
    type: 'Planning',
    status: 'In Process',
    target: '27',
    limit: '30',
    reviewer: 'Assign reviewer',
  ),
  _DocumentRow(
    header: 'Team Structure and Roles',
    type: 'Planning',
    status: 'Done',
    target: '20',
    limit: '23',
    reviewer: 'Jamik Tashpulatov',
  ),
  _DocumentRow(
    header: 'Communication Protocols',
    type: 'Planning',
    status: 'In Process',
    target: '15',
    limit: '18',
    reviewer: 'Assign reviewer',
  ),
  _DocumentRow(
    header: 'Success Metrics',
    type: 'Planning',
    status: 'Done',
    target: '30',
    limit: '33',
    reviewer: 'Eddie Lake',
  ),
  _DocumentRow(
    header: 'Internationalization Support',
    type: 'Technical content',
    status: 'In Process',
    target: '23',
    limit: '26',
    reviewer: 'Jamik Tashpulatov',
  ),
  _DocumentRow(
    header: 'Backup and Recovery Procedures',
    type: 'Technical content',
    status: 'Done',
    target: '18',
    limit: '21',
    reviewer: 'Assign reviewer',
  ),
  _DocumentRow(
    header: 'Monitoring and Alerting System',
    type: 'Technical content',
    status: 'In Process',
    target: '25',
    limit: '28',
    reviewer: 'Daniel Park',
  ),
  _DocumentRow(
    header: 'Code Review Guidelines',
    type: 'Technical content',
    status: 'Done',
    target: '12',
    limit: '15',
    reviewer: 'Eddie Lake',
  ),
  _DocumentRow(
    header: 'Documentation Standards',
    type: 'Technical content',
    status: 'In Process',
    target: '27',
    limit: '30',
    reviewer: 'Jamik Tashpulatov',
  ),
  _DocumentRow(
    header: 'Release Management Process',
    type: 'Planning',
    status: 'Done',
    target: '22',
    limit: '25',
    reviewer: 'Assign reviewer',
  ),
  _DocumentRow(
    header: 'Feature Prioritization Matrix',
    type: 'Planning',
    status: 'In Process',
    target: '19',
    limit: '22',
    reviewer: 'Emma Davis',
  ),
  _DocumentRow(
    header: 'Technical Debt Assessment',
    type: 'Technical content',
    status: 'Done',
    target: '24',
    limit: '27',
    reviewer: 'Eddie Lake',
  ),
  _DocumentRow(
    header: 'Capacity Planning',
    type: 'Planning',
    status: 'In Process',
    target: '21',
    limit: '24',
    reviewer: 'Jamik Tashpulatov',
  ),
  _DocumentRow(
    header: 'Service Level Agreements',
    type: 'Legal',
    status: 'Done',
    target: '26',
    limit: '29',
    reviewer: 'Assign reviewer',
  ),
];
