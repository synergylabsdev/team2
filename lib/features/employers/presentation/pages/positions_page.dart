import 'package:flutter/material.dart';

/// Positions/Jobs page for employers
/// Shows all job postings and allows creating new ones
class PositionsPage extends StatelessWidget {
  const PositionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Positions'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // TODO: Implement search
            },
            tooltip: 'Search positions',
          ),
        ],
      ),
      body: Column(
        children: [
          // Stats bar
          Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: colorScheme.surfaceContainerHighest,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: _QuickStat(
                    label: 'Active',
                    value: '12',
                    color: colorScheme.primary,
                  ),
                ),
                Container(
                  width: 1,
                  height: 40,
                  color: colorScheme.outline.withOpacity(0.2),
                ),
                Expanded(
                  child: _QuickStat(
                    label: 'Draft',
                    value: '3',
                    color: colorScheme.secondary,
                  ),
                ),
                Container(
                  width: 1,
                  height: 40,
                  color: colorScheme.outline.withOpacity(0.2),
                ),
                Expanded(
                  child: _QuickStat(
                    label: 'Closed',
                    value: '28',
                    color: colorScheme.tertiary,
                  ),
                ),
              ],
            ),
          ),

          // Filter chips
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  FilterChip(
                    label: const Text('All'),
                    selected: true,
                    onSelected: (selected) {},
                  ),
                  const SizedBox(width: 8),
                  FilterChip(
                    label: const Text('Active'),
                    selected: false,
                    onSelected: (selected) {},
                  ),
                  const SizedBox(width: 8),
                  FilterChip(
                    label: const Text('Draft'),
                    selected: false,
                    onSelected: (selected) {},
                  ),
                  const SizedBox(width: 8),
                  FilterChip(
                    label: const Text('Closed'),
                    selected: false,
                    onSelected: (selected) {},
                  ),
                ],
              ),
            ),
          ),

          // Jobs list
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: 8,
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.only(bottom: 12.0),
                child: _JobCard(
                  title: 'Senior Flutter Developer',
                  location: 'San Francisco, CA',
                  type: 'Full-time',
                  applicants: 24,
                  status: index % 3 == 0
                      ? JobStatus.active
                      : index % 3 == 1
                          ? JobStatus.draft
                          : JobStatus.closed,
                  postedDate: '2 days ago',
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // TODO: Navigate to create job page
        },
        icon: const Icon(Icons.add),
        label: const Text('New Position'),
      ),
    );
  }
}

enum JobStatus {
  active,
  draft,
  closed,
}

/// Quick stat widget
class _QuickStat extends StatelessWidget {
  final String label;
  final String value;
  final Color color;

  const _QuickStat({
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: [
        Text(
          value,
          style: theme.textTheme.headlineSmall?.copyWith(
            color: color,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}

/// Job card widget
class _JobCard extends StatelessWidget {
  final String title;
  final String location;
  final String type;
  final int applicants;
  final JobStatus status;
  final String postedDate;

  const _JobCard({
    required this.title,
    required this.location,
    required this.type,
    required this.applicants,
    required this.status,
    required this.postedDate,
  });

  Color _getStatusColor(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    switch (status) {
      case JobStatus.active:
        return colorScheme.primary;
      case JobStatus.draft:
        return colorScheme.secondary;
      case JobStatus.closed:
        return colorScheme.onSurfaceVariant;
    }
  }

  String _getStatusLabel() {
    switch (status) {
      case JobStatus.active:
        return 'Active';
      case JobStatus.draft:
        return 'Draft';
      case JobStatus.closed:
        return 'Closed';
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final statusColor = _getStatusColor(context);

    return Card(
      child: InkWell(
        onTap: () {
          // TODO: Navigate to job details
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header row
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: theme.textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Icon(
                              Icons.location_on,
                              size: 16,
                              color: colorScheme.onSurfaceVariant,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              location,
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: colorScheme.onSurfaceVariant,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Icon(
                              Icons.work_outline,
                              size: 16,
                              color: colorScheme.onSurfaceVariant,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              type,
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: colorScheme.onSurfaceVariant,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  // Status badge
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: statusColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: statusColor.withOpacity(0.3),
                        width: 1,
                      ),
                    ),
                    child: Text(
                      _getStatusLabel(),
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: statusColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              // Stats row
              Row(
                children: [
                  _StatBadge(
                    icon: Icons.people,
                    label: '$applicants applicants',
                    color: colorScheme.primary,
                  ),
                  const SizedBox(width: 12),
                  _StatBadge(
                    icon: Icons.access_time,
                    label: postedDate,
                    color: colorScheme.secondary,
                  ),
                ],
              ),
              const SizedBox(height: 16),
              // Action buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton.icon(
                    onPressed: () {
                      // TODO: View applicants
                    },
                    icon: const Icon(Icons.people_outline, size: 18),
                    label: const Text('View Applicants'),
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    icon: const Icon(Icons.more_vert),
                    onPressed: () {
                      // TODO: Show menu
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Stat badge widget
class _StatBadge extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;

  const _StatBadge({
    required this.icon,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: color),
          const SizedBox(width: 4),
          Text(
            label,
            style: theme.textTheme.bodySmall?.copyWith(
              color: color,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

