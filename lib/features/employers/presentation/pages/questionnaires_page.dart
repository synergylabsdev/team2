import 'package:flutter/material.dart';

/// Questionnaires page for employers
/// Shows and manages interview questionnaires
class QuestionnairesPage extends StatelessWidget {
  const QuestionnairesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Questionnaires'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // TODO: Implement search
            },
            tooltip: 'Search questionnaires',
          ),
        ],
      ),
      body: Column(
        children: [
          // Info banner
          Container(
            margin: const EdgeInsets.all(16.0),
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.info_outline,
                  color: colorScheme.onPrimaryContainer,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Create custom questionnaires to assess candidates during interviews',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: colorScheme.onPrimaryContainer,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Questionnaires list
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              itemCount: 6,
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.only(bottom: 12.0),
                child: _QuestionnaireCard(
                  title: _getQuestionnaireTitle(index),
                  description: _getQuestionnaireDescription(index),
                  questionCount: (index + 1) * 3,
                  usageCount: (index + 1) * 5,
                  isDefault: index == 0,
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // TODO: Navigate to create questionnaire page
        },
        icon: const Icon(Icons.add),
        label: const Text('New Questionnaire'),
      ),
    );
  }

  String _getQuestionnaireTitle(int index) {
    final titles = [
      'Technical Skills Assessment',
      'Behavioral Interview',
      'Culture Fit Evaluation',
      'Problem Solving',
      'Communication Skills',
      'Leadership Assessment',
    ];
    return titles[index % titles.length];
  }

  String _getQuestionnaireDescription(int index) {
    final descriptions = [
      'Assess technical knowledge and coding abilities',
      'Evaluate soft skills and behavioral patterns',
      'Determine alignment with company culture',
      'Test analytical and problem-solving skills',
      'Measure communication and presentation skills',
      'Assess leadership and management potential',
    ];
    return descriptions[index % descriptions.length];
  }
}

/// Questionnaire card widget
class _QuestionnaireCard extends StatelessWidget {
  final String title;
  final String description;
  final int questionCount;
  final int usageCount;
  final bool isDefault;

  const _QuestionnaireCard({
    required this.title,
    required this.description,
    required this.questionCount,
    required this.usageCount,
    required this.isDefault,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Card(
      child: InkWell(
        onTap: () {
          // TODO: Navigate to questionnaire details/edit
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
                        Row(
                          children: [
                            Text(
                              title,
                              style: theme.textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            if (isDefault) ...[
                              const SizedBox(width: 8),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 6,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: colorScheme.primary,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  'Default',
                                  style: theme.textTheme.labelSmall?.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          description,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.more_vert),
                    onPressed: () {
                      // TODO: Show menu
                    },
                  ),
                ],
              ),
              const SizedBox(height: 16),
              // Stats row
              Row(
                children: [
                  _StatItem(
                    icon: Icons.help_outline,
                    label: '$questionCount questions',
                    color: colorScheme.primary,
                  ),
                  const SizedBox(width: 16),
                  _StatItem(
                    icon: Icons.assessment,
                    label: 'Used $usageCount times',
                    color: colorScheme.secondary,
                  ),
                ],
              ),
              const SizedBox(height: 16),
              // Action buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  OutlinedButton.icon(
                    onPressed: () {
                      // TODO: Preview questionnaire
                    },
                    icon: const Icon(Icons.preview, size: 18),
                    label: const Text('Preview'),
                  ),
                  const SizedBox(width: 8),
                  FilledButton.icon(
                    onPressed: () {
                      // TODO: Edit questionnaire
                    },
                    icon: const Icon(Icons.edit, size: 18),
                    label: const Text('Edit'),
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

/// Stat item widget
class _StatItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;

  const _StatItem({
    required this.icon,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      children: [
        Icon(icon, size: 18, color: color),
        const SizedBox(width: 6),
        Text(
          label,
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

