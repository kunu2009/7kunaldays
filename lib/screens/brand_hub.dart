import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/theme.dart';

class BrandHub extends ConsumerStatefulWidget {
  const BrandHub({super.key});

  @override
  ConsumerState<BrandHub> createState() => _BrandHubState();
}

class _BrandHubState extends ConsumerState<BrandHub> {
  int _selectedPillarIndex = 0;

  final List<String> _contentPillars = [
    'Self-Improvement',
    'Discipline & Focus',
    'Fitness & Aesthetics',
    'Academic Mindset',
    'Lifestyle Philosophy',
  ];

  final List<Map<String, dynamic>> _weeklySchedule = [];

  final List<Map<String, dynamic>> _contentIdeas = [
    {'title': 'How I structure a 2-hour deep study block', 'status': 'Ready to script', 'pillar': 'Academic Mindset'},
    {'title': 'Budget breakfast for study + muscle gain', 'status': 'Planning', 'pillar': 'Fitness & Aesthetics'},
    {'title': 'Mirror talk — build speaking confidence in 3 minutes', 'status': 'Ready', 'pillar': 'Self-Improvement'},
    {'title': 'Post-mock test analysis — 5 step fix', 'status': 'Scripting', 'pillar': 'Academic Mindset'},
  ];

  final Map<String, int> _metrics = {
    'Instagram Followers': 0,
    'YouTube Subscribers': 0,
    'Total Views': 0,
    'Engagement': 0,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('🎬 7K BRAND HUB'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Metrics Dashboard
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '📊 Growth Metrics',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 16),
                  GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    childAspectRatio: 2.5,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                    children: _metrics.entries.map((entry) {
                      return Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: AppTheme.darkBackground,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              entry.key,
                              style: const TextStyle(
                                fontSize: 11,
                                color: Colors.white70,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              _formatNumber(entry.value),
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: AppTheme.brandColor,
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Weekly Schedule
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '📅 Weekly Content Schedule',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 16),
                  ..._weeklySchedule.map((item) => Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: item['completed'] ? AppTheme.brandColor.withOpacity(0.2) : AppTheme.darkBackground,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: item['completed'] ? AppTheme.brandColor : Colors.white24,
                          ),
                        ),
                        child: Row(
                          children: [
                            Checkbox(
                              value: item['completed'],
                              onChanged: (value) {
                                setState(() {
                                  item['completed'] = value ?? false;
                                });
                              },
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${item['day']} - ${item['type']}',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 15,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    '${item['topic']} • ${item['platform']}',
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: Colors.white.withOpacity(0.7),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Content Idea Vault
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '💡 Content Idea Vault',
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      IconButton(
                        icon: const Icon(Icons.add_circle, color: AppTheme.primaryTeal),
                        onPressed: () {
                          _showAddIdeaDialog();
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  // Pillar Filter
                  SizedBox(
                    height: 40,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: _contentPillars.length,
                      itemBuilder: (context, index) {
                        final isSelected = _selectedPillarIndex == index;
                        return Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: ChoiceChip(
                            label: Text(_contentPillars[index]),
                            selected: isSelected,
                            onSelected: (selected) {
                              setState(() => _selectedPillarIndex = index);
                            },
                            selectedColor: AppTheme.brandColor,
                            backgroundColor: AppTheme.darkBackground,
                            labelStyle: TextStyle(
                              color: isSelected ? Colors.black : Colors.white70,
                              fontSize: 12,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Ideas List
                  ..._contentIdeas.map((idea) => Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: AppTheme.darkBackground,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: _getStatusColor(idea['status'])),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    idea['title'],
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    idea['pillar'],
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.white.withOpacity(0.6),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                              decoration: BoxDecoration(
                                color: _getStatusColor(idea['status']).withOpacity(0.2),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                idea['status'],
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                  color: _getStatusColor(idea['status']),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),

          // AI Caption Assistant
          Card(
            color: AppTheme.cardBackground,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.auto_awesome, color: AppTheme.primaryTeal),
                      const SizedBox(width: 12),
                      Text(
                        'AI Caption Assistant',
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Generate captions for your content:',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    decoration: InputDecoration(
                      hintText: 'Enter content topic...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.send, color: AppTheme.primaryTeal),
                        onPressed: () {
                          _generateCaption();
                        },
                      ),
                    ),
                    maxLines: 2,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Quick Actions
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {
                    // Analytics view
                  },
                  icon: const Icon(Icons.trending_up),
                  label: const Text('Analytics'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.brandColor,
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {
                    // Content calendar
                  },
                  icon: const Icon(Icons.calendar_month),
                  label: const Text('Calendar'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.cardBackground,
                    foregroundColor: AppTheme.primaryTeal,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Completed':
        return AppTheme.primaryTeal;
      case 'In Progress':
        return AppTheme.brandColor;
      case 'Planned':
        return AppTheme.studyColor;
      default:
        return Colors.white54;
    }
  }

  String _formatNumber(int number) {
    if (number >= 1000) {
      return '${(number / 1000).toStringAsFixed(1)}K';
    }
    return number.toString();
  }

  void _showAddIdeaDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('💡 New Content Idea'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration: const InputDecoration(
                labelText: 'Title',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              decoration: const InputDecoration(
                labelText: 'Description',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('✅ Idea saved to vault!')),
              );
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  void _generateCaption() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('🤖 AI Generated Caption'),
        content: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppTheme.darkBackground,
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Text(
            'Silent grind. Daily discipline. 1% better.\n\n'
            'While others talk, I execute.\n'
            'While others sleep, I build.\n\n'
            '📚 4 hrs study ✓\n'
            '💪 Morning workout ✓\n'
            '🧠 100% focus ✓\n\n'
            '#7K #Evolution #Discipline',
            style: TextStyle(height: 1.5),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Regenerate'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('📋 Caption copied!')),
              );
            },
            child: const Text('Copy'),
          ),
        ],
      ),
    );
  }
}
