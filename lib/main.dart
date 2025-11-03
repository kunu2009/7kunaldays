import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:timezone/data/latest.dart' as tz;

import 'models/daily_log.dart';
import 'models/nutrition_entry.dart';
import 'screens/home_screen.dart';
import 'core/theme.dart';
import 'services/notification_service.dart';
import 'providers/theme_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Hive
  await Hive.initFlutter();
  
  // Register Hive Adapters
  Hive.registerAdapter(DailyLogAdapter());
  Hive.registerAdapter(MetricsAdapter());
  Hive.registerAdapter(NutritionEntryAdapter());
  Hive.registerAdapter(MentalRatingsAdapter());
  Hive.registerAdapter(SevenKActionAdapter());
  
  // Open Boxes
  await Hive.openBox<DailyLog>('daily_logs');
  await Hive.openBox('settings');
  
  // Initialize timezone for notifications
  tz.initializeTimeZones();
  
  // Initialize notifications
  await NotificationService.initialize();
  
  runApp(
    const ProviderScope(
      child: KunalEvolutionApp(),
    ),
  );
}

class KunalEvolutionApp extends ConsumerWidget {
  const KunalEvolutionApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentTheme = ref.watch(themeProvider);
    
    return MaterialApp(
      title: "Kunal's Evolution",
      debugShowCheckedModeBanner: false,
      theme: AppTheme.getTheme(currentTheme),
      home: const HomeScreen(),
    );
  }
}
