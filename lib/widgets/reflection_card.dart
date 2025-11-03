import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/daily_log.dart';
import '../core/theme.dart';
import '../providers/daily_log_provider.dart';

class ReflectionCard extends ConsumerWidget {
  final DailyLog log;

  const ReflectionCard({super.key, required this.log});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '🔁 END-OF-DAY REFLECTION',
              style: Theme.of(context).textTheme.displaySmall,
            ),
            const SizedBox(height: 20),

            _ReflectionField(
              label: '1 Thing I did great today:',
              value: log.oneGreatThing,
              onChanged: (value) {
                ref.read(todayLogProvider.notifier)
                    .updateReflection('oneGreatThing', value);
              },
            ),
            const SizedBox(height: 16),

            _ReflectionField(
              label: '1 Thing I\'ll improve tomorrow:',
              value: log.oneImprovement,
              onChanged: (value) {
                ref.read(todayLogProvider.notifier)
                    .updateReflection('oneImprovement', value);
              },
            ),
            const SizedBox(height: 16),

            _ReflectionField(
              label: 'Gratitude 🙏:',
              value: log.gratitude,
              onChanged: (value) {
                ref.read(todayLogProvider.notifier)
                    .updateReflection('gratitude', value);
              },
            ),
            const SizedBox(height: 16),

            _ReflectionField(
              label: '⚠️ What slowed me down:',
              value: log.whatSlowedDown,
              onChanged: (value) {
                ref.read(todayLogProvider.notifier)
                    .updateReflection('whatSlowedDown', value);
              },
            ),
            const SizedBox(height: 16),

            _ReflectionField(
              label: '💭 Lesson of the day:',
              value: log.lessonOfTheDay,
              onChanged: (value) {
                ref.read(todayLogProvider.notifier)
                    .updateReflection('lessonOfTheDay', value);
              },
            ),
            const SizedBox(height: 24),

            // Mental Performance Ratings
            Text(
              '🧩 MENTAL PERFORMANCE',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 16),

            _RatingSlider(
              label: 'Focus',
              value: log.mentalRatings.focus,
              onChanged: (value) {
                ref.read(todayLogProvider.notifier)
                    .updateMentalRating('focus', value.round());
              },
            ),

            _RatingSlider(
              label: 'Energy',
              value: log.mentalRatings.energy,
              onChanged: (value) {
                ref.read(todayLogProvider.notifier)
                    .updateMentalRating('energy', value.round());
              },
            ),

            _RatingSlider(
              label: 'Mood',
              value: log.mentalRatings.mood,
              onChanged: (value) {
                ref.read(todayLogProvider.notifier)
                    .updateMentalRating('mood', value.round());
              },
            ),

            _RatingSlider(
              label: 'Confidence',
              value: log.mentalRatings.confidence,
              onChanged: (value) {
                ref.read(todayLogProvider.notifier)
                    .updateMentalRating('confidence', value.round());
              },
            ),

            _RatingSlider(
              label: 'Self-Control',
              value: log.mentalRatings.selfControl,
              onChanged: (value) {
                ref.read(todayLogProvider.notifier)
                    .updateMentalRating('selfControl', value.round());
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _ReflectionField extends StatelessWidget {
  final String label;
  final String? value;
  final Function(String) onChanged;

  const _ReflectionField({
    required this.label,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),
        const SizedBox(height: 8),
        TextField(
          decoration: InputDecoration(
            hintText: 'Write here...',
            filled: true,
            fillColor: AppTheme.darkBackground,
          ),
          controller: TextEditingController(text: value),
          onChanged: onChanged,
          maxLines: 2,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }
}

class _RatingSlider extends StatelessWidget {
  final String label;
  final int value;
  final Function(double) onChanged;

  const _RatingSlider({
    required this.label,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            Text(
              value.toString(),
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppTheme.primaryTeal,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ],
        ),
        Slider(
          value: value.toDouble(),
          min: 1,
          max: 10,
          divisions: 9,
          activeColor: AppTheme.primaryTeal,
          inactiveColor: Colors.white24,
          onChanged: onChanged,
        ),
      ],
    );
  }
}
