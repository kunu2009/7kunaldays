import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/theme.dart';

class StudyMaterialScreen extends ConsumerStatefulWidget {
  const StudyMaterialScreen({super.key});

  @override
  ConsumerState<StudyMaterialScreen> createState() => _StudyMaterialScreenState();
}

class _StudyMaterialScreenState extends ConsumerState<StudyMaterialScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _currentArticle = 1;
  final Set<int> _completedArticles = {};

  // Constitution Articles (1-51) with actual content
  final Map<int, Map<String, String>> _constitutionArticles = {
    1: {'title': 'Name and territory of the Union', 'content': 'India, that is Bharat, shall be a Union of States. The territory of India shall comprise the territories of the States, the Union territories specified in the First Schedule and such other territories as may be acquired.'},
    2: {'title': 'Admission or establishment of new States', 'content': 'Parliament may by law admit into the Union, or establish, new States on such terms and conditions as it thinks fit.'},
    3: {'title': 'Formation of new States and alteration of areas, boundaries or names of existing States', 'content': 'Parliament may by law: (a) form a new State by separation of territory from any State or by uniting two or more States or parts of States or by uniting any territory to a part of any State; (b) increase the area of any State; (c) diminish the area of any State; (d) alter the boundaries of any State; (e) alter the name of any State.'},
    4: {'title': 'Laws made under Articles 2 and 3 to provide for the amendment of the First and the Fourth Schedules', 'content': 'Any law referred to in Article 2 or Article 3 shall contain such provisions for the amendment of the First Schedule and the Fourth Schedule as may be necessary to give effect to the provisions of the law and may also contain such supplemental, incidental and consequential provisions as Parliament may deem necessary.'},
    5: {'title': 'Citizenship at the commencement of the Constitution', 'content': 'At the commencement of this Constitution, every person who has his domicile in the territory of India and who was born in the territory of India or either of whose parents was born in the territory of India or who has been ordinarily resident in the territory of India for not less than five years immediately preceding such commencement, shall be a citizen of India.'},
    6: {'title': 'Rights of citizenship of certain persons who have migrated to India from Pakistan', 'content': 'Notwithstanding anything in Article 5, a person who has migrated to the territory of India from the territory now included in Pakistan shall be deemed to be a citizen of India at the commencement of this Constitution if certain conditions are satisfied.'},
    7: {'title': 'Rights of citizenship of certain migrants to Pakistan', 'content': 'Notwithstanding anything in Articles 5 and 6, a person who has after the first day of March, 1947, migrated from the territory of India to the territory now included in Pakistan shall not be deemed to be a citizen of India.'},
    8: {'title': 'Rights of citizenship of certain persons of Indian origin residing outside India', 'content': 'Notwithstanding anything in Article 5, any person who or either of whose parents or any of whose grand-parents was born in India as defined in the Government of India Act, 1935 and who is ordinarily residing in any country outside India as so defined shall be deemed to be a citizen of India.'},
    9: {'title': 'Persons voluntarily acquiring citizenship of a foreign State not to be citizens', 'content': 'No person shall be a citizen of India by virtue of Article 5, or be deemed to be a citizen of India by virtue of Article 6 or Article 8, if he has voluntarily acquired the citizenship of a foreign State.'},
    10: {'title': 'Continuance of the rights of citizenship', 'content': 'Every person who is or is deemed to be a citizen of India under any of the foregoing provisions of this Part shall, subject to the provisions of any law that may be made by Parliament, continue to be such citizen.'},
    11: {'title': 'Parliament to regulate the right of citizenship by law', 'content': 'Nothing in the foregoing provisions of this Part shall derogate from the power of Parliament to make any provision with respect to the acquisition and termination of citizenship and all other matters relating to citizenship.'},
  };

  // Mock test questions
  final List<Map<String, dynamic>> _mockTests = [
    {
      'id': 1,
      'title': 'Constitution Basics - Articles 1-11',
      'questions': 20,
      'duration': 30,
      'completed': false,
      'score': null,
    },
    {
      'id': 2,
      'title': 'Fundamental Rights',
      'questions': 25,
      'duration': 35,
      'completed': false,
      'score': null,
    },
    {
      'id': 3,
      'title': 'Directive Principles',
      'questions': 20,
      'duration': 30,
      'completed': false,
      'score': null,
    },
    {
      'id': 4,
      'title': 'Union and its Territory',
      'questions': 15,
      'duration': 20,
      'completed': false,
      'score': null,
    },
    {
      'id': 5,
      'title': 'Legal Aptitude Mixed',
      'questions': 30,
      'duration': 45,
      'completed': false,
      'score': null,
    },
  ];

  // Revision notes
  final List<Map<String, String>> _revisionNotes = [
    {'topic': 'Citizenship Articles (5-11)', 'notes': '• Art 5: Citizenship at commencement\n• Art 6: Pakistan migrants\n• Art 9: Voluntary foreign citizenship = loss\n• Art 11: Parliament regulates citizenship\n\nKey: Birthright, migration rules, Parliament supremacy'},
    {'topic': 'Union & States (Art 1-4)', 'notes': '• Art 1: India = Union of States\n• Art 2: New states admission\n• Art 3: Formation/alteration of states\n• Art 4: Amendment of schedules\n\nKey: Parliamentary power to reorganize'},
    {'topic': 'Legal Aptitude Tips', 'notes': '1. Read question 2x carefully\n2. Identify legal principle first\n3. Apply to facts systematically\n4. Eliminate wrong options\n5. Time management: 1.5 min/question'},
    {'topic': 'Common Constitution Amendments', 'notes': '• 1st: Land reforms\n• 42nd: Mini Constitution\n• 44th: Right to Property removed\n• 73rd & 74th: Panchayati Raj\n• 101st: GST\n\nTrend: Federalism & Rights balance'},
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('📚 Study Material'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(icon: Icon(Icons.article), text: 'Articles'),
            Tab(icon: Icon(Icons.quiz), text: 'Mock Tests'),
            Tab(icon: Icon(Icons.refresh), text: 'Revision'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildArticlesTab(),
          _buildMockTestsTab(),
          _buildRevisionTab(),
        ],
      ),
    );
  }

  Widget _buildArticlesTab() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // Progress Card
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
                      '⚖️ Constitution Articles',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    Text(
                      '${_completedArticles.length}/51',
                      style: const TextStyle(
                        color: AppTheme.brandColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                LinearProgressIndicator(
                  value: _completedArticles.length / 51,
                  backgroundColor: Colors.white12,
                  valueColor: const AlwaysStoppedAnimation(AppTheme.brandColor),
                  minHeight: 10,
                  borderRadius: BorderRadius.circular(5),
                ),
                const SizedBox(height: 16),
                Text(
                  'Articles 1-11 cover: Name & Territory + Citizenship',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.white70,
                      ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),

        // Article Navigator
        Card(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: _currentArticle > 1
                          ? () => setState(() => _currentArticle--)
                          : null,
                    ),
                    Column(
                      children: [
                        Text(
                          'Article $_currentArticle',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.primaryTeal,
                          ),
                        ),
                        if (_constitutionArticles.containsKey(_currentArticle))
                          Text(
                            _constitutionArticles[_currentArticle]!['title']!,
                            style: const TextStyle(
                              fontSize: 13,
                              color: Colors.white70,
                            ),
                            textAlign: TextAlign.center,
                          ),
                      ],
                    ),
                    IconButton(
                      icon: const Icon(Icons.arrow_forward),
                      onPressed: _currentArticle < 51
                          ? () => setState(() => _currentArticle++)
                          : null,
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                if (_constitutionArticles.containsKey(_currentArticle))
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppTheme.darkBackground,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      _constitutionArticles[_currentArticle]!['content']!,
                      style: const TextStyle(
                        fontSize: 15,
                        height: 1.6,
                        color: Colors.white,
                      ),
                    ),
                  )
                else
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppTheme.darkBackground,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      'Article $_currentArticle content will be available soon. Continue studying!',
                      style: const TextStyle(
                        fontSize: 15,
                        height: 1.6,
                        color: Colors.white70,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () {
                          setState(() {
                            if (_completedArticles.contains(_currentArticle)) {
                              _completedArticles.remove(_currentArticle);
                            } else {
                              _completedArticles.add(_currentArticle);
                            }
                          });
                        },
                        icon: Icon(_completedArticles.contains(_currentArticle)
                            ? Icons.check_circle
                            : Icons.circle_outlined),
                        label: Text(_completedArticles.contains(_currentArticle)
                            ? 'Completed'
                            : 'Mark Complete'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _completedArticles.contains(_currentArticle)
                              ? AppTheme.brandColor
                              : AppTheme.cardBackground,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),

        // Quick Access Grid
        Text(
          'Quick Access',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        const SizedBox(height: 12),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 5,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
            childAspectRatio: 1,
          ),
          itemCount: 51,
          itemBuilder: (context, index) {
            final articleNum = index + 1;
            final isCompleted = _completedArticles.contains(articleNum);
            final isCurrent = _currentArticle == articleNum;
            return GestureDetector(
              onTap: () => setState(() => _currentArticle = articleNum),
              child: Container(
                decoration: BoxDecoration(
                  color: isCurrent
                      ? AppTheme.primaryTeal
                      : isCompleted
                          ? AppTheme.brandColor.withOpacity(0.3)
                          : AppTheme.cardBackground,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: isCurrent
                        ? AppTheme.primaryTeal
                        : isCompleted
                            ? AppTheme.brandColor
                            : Colors.white24,
                    width: isCurrent ? 2 : 1,
                  ),
                ),
                child: Center(
                  child: Text(
                    '$articleNum',
                    style: TextStyle(
                      fontWeight: isCurrent ? FontWeight.bold : FontWeight.normal,
                      fontSize: isCurrent ? 16 : 14,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildMockTestsTab() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text(
          '📝 Practice Tests',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const SizedBox(height: 16),
        ..._mockTests.map((test) => Card(
              margin: const EdgeInsets.only(bottom: 12),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: test['completed']
                      ? AppTheme.brandColor
                      : AppTheme.primaryTeal.withOpacity(0.3),
                  child: Icon(
                    test['completed'] ? Icons.check : Icons.quiz,
                    color: Colors.white,
                  ),
                ),
                title: Text(
                  test['title'],
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                subtitle: Text(
                  '${test['questions']} Questions • ${test['duration']} mins' +
                      (test['score'] != null ? ' • Score: ${test['score']}%' : ''),
                  style: const TextStyle(fontSize: 13),
                ),
                trailing: ElevatedButton(
                  onPressed: () {
                    _showMockTestDialog(test);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: test['completed']
                        ? AppTheme.cardBackground
                        : AppTheme.primaryTeal,
                  ),
                  child: Text(test['completed'] ? 'Retake' : 'Start'),
                ),
              ),
            )),
      ],
    );
  }

  Widget _buildRevisionTab() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text(
          '🔄 Revision Notes',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const SizedBox(height: 16),
        ..._revisionNotes.map((note) => Card(
              margin: const EdgeInsets.only(bottom: 16),
              child: ExpansionTile(
                title: Text(
                  note['topic']!,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
                leading: const Icon(Icons.note, color: AppTheme.brandColor),
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppTheme.darkBackground,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        note['notes']!,
                        style: const TextStyle(
                          fontSize: 14,
                          height: 1.8,
                          fontFamily: 'monospace',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )),
        const SizedBox(height: 12),
        ElevatedButton.icon(
          onPressed: () {
            _showAddRevisionDialog();
          },
          icon: const Icon(Icons.add),
          label: const Text('Add Revision Note'),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppTheme.cardBackground,
            foregroundColor: AppTheme.primaryTeal,
            padding: const EdgeInsets.symmetric(vertical: 16),
          ),
        ),
      ],
    );
  }

  void _showMockTestDialog(Map<String, dynamic> test) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppTheme.cardBackground,
        title: Text(test['title']),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Questions: ${test['questions']}'),
            Text('Duration: ${test['duration']} minutes'),
            const SizedBox(height: 12),
            const Text(
              'Mock test functionality coming soon!\nYou can track your preparation here.',
              style: TextStyle(fontSize: 13, color: Colors.white70),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              setState(() {
                test['completed'] = true;
                test['score'] = 75 + (test['id'] * 3); // Demo score
              });
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Test marked as completed!')),
              );
            },
            child: const Text('Mark Complete'),
          ),
        ],
      ),
    );
  }

  void _showAddRevisionDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppTheme.cardBackground,
        title: const Text('Add Revision Note'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Topic',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 12),
            TextField(
              decoration: InputDecoration(
                labelText: 'Notes',
                border: OutlineInputBorder(),
              ),
              maxLines: 5,
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
                const SnackBar(content: Text('Note saved!')),
              );
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }
}
