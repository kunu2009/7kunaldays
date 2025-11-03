import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/theme.dart';
import '../services/notification_service.dart';
import '../providers/theme_provider.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  bool notificationsEnabled = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SETTINGS'),
      ),
      body: ListView(
        children: [
          const SizedBox(height: 16),
          
          // Notifications
          _SettingSection(
            title: '🔔 NOTIFICATIONS',
            children: [
              SwitchListTile(
                title: const Text('Daily Reminders'),
                subtitle: const Text('Morning, College, Night notifications'),
                value: notificationsEnabled,
                activeColor: AppTheme.primaryTeal,
                onChanged: (value) async {
                  setState(() => notificationsEnabled = value);
                  if (value) {
                    await NotificationService.scheduleDailyReminders();
                    if (mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('✅ Daily reminders enabled'),
                        ),
                      );
                    }
                  } else {
                    await NotificationService.cancelAll();
                  }
                },
              ),
            ],
          ),

          // Theme
          _SettingSection(
            title: '🎨 THEME',
            children: [
              ListTile(
                title: const Text('App Theme'),
                subtitle: Text(_getThemeName(ref.watch(themeProvider))),
                trailing: const Icon(Icons.palette),
                onTap: () {
                  _showThemeDialog(context, ref);
                },
              ),
            ],
          ),

          // Data Management
          _SettingSection(
            title: '💾 DATA MANAGEMENT',
            children: [
              ListTile(
                title: const Text('Export All Data'),
                subtitle: const Text('Download as Markdown'),
                leading: const Icon(Icons.file_download),
                onTap: () {
                  // TODO: Implement export
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('📄 Export feature coming soon...'),
                    ),
                  );
                },
              ),
              ListTile(
                title: const Text('Import Data'),
                subtitle: const Text('Restore from JSON'),
                leading: const Icon(Icons.file_upload),
                onTap: () {
                  // TODO: Implement import
                },
              ),
            ],
          ),

          // About
          _SettingSection(
            title: 'ℹ️ ABOUT',
            children: [
              ListTile(
                title: const Text('App Version'),
                subtitle: const Text('1.0.0 - Evolution Edition'),
              ),
              ListTile(
                title: const Text('Developer'),
                subtitle: const Text('Built for Kunal\'s High-Performance Journey'),
              ),
            ],
          ),

          const SizedBox(height: 32),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Text(
              '"Focus. Consistency. Growth."',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.normal,
                color: AppTheme.primaryTeal,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  String _getThemeName(AppThemeMode mode) {
    switch (mode) {
      case AppThemeMode.light:
        return 'Light (Timberwolf)';
      case AppThemeMode.dark:
        return 'Dark (7K Minimal)';
      case AppThemeMode.dracula:
        return 'Dracula';
    }
  }
  
  void _showThemeDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Choose Theme'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _ThemeOption(
              title: 'Light (Timberwolf)',
              subtitle: 'White, grey, timberwolf accents',
              icon: Icons.wb_sunny,
              isSelected: ref.watch(themeProvider) == AppThemeMode.light,
              onTap: () {
                ref.read(themeProvider.notifier).setTheme(AppThemeMode.light);
                Navigator.pop(context);
              },
            ),
            const SizedBox(height: 8),
            _ThemeOption(
              title: 'Dark (7K Minimal)',
              subtitle: 'Dark with teal accents',
              icon: Icons.nights_stay,
              isSelected: ref.watch(themeProvider) == AppThemeMode.dark,
              onTap: () {
                ref.read(themeProvider.notifier).setTheme(AppThemeMode.dark);
                Navigator.pop(context);
              },
            ),
            const SizedBox(height: 8),
            _ThemeOption(
              title: 'Dracula',
              subtitle: 'Purple, pink, cyan vibes',
              icon: Icons.dark_mode,
              isSelected: ref.watch(themeProvider) == AppThemeMode.dracula,
              onTap: () {
                ref.read(themeProvider.notifier).setTheme(AppThemeMode.dracula);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _SettingSection extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const _SettingSection({
    required this.title,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
          child: Text(
            title,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontSize: 16,
                  color: AppTheme.primaryTeal,
                ),
          ),
        ),
        Card(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(children: children),
        ),
        const SizedBox(height: 8),
      ],
    );
  }
  
  String _getThemeName(AppThemeMode mode) {
    switch (mode) {
      case AppThemeMode.light:
        return 'Light (Timberwolf)';
      case AppThemeMode.dark:
        return 'Dark (7K Minimal)';
      case AppThemeMode.dracula:
        return 'Dracula';
    }
  }
  
  void _showThemeDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Choose Theme'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _ThemeOption(
              title: 'Light (Timberwolf)',
              subtitle: 'White, grey, timberwolf accents',
              icon: Icons.wb_sunny,
              isSelected: ref.watch(themeProvider) == AppThemeMode.light,
              onTap: () {
                ref.read(themeProvider.notifier).setTheme(AppThemeMode.light);
                Navigator.pop(context);
              },
            ),
            _ThemeOption(
              title: 'Dark (7K Minimal)',
              subtitle: 'Dark with teal accents',
              icon: Icons.nights_stay,
              isSelected: ref.watch(themeProvider) == AppThemeMode.dark,
              onTap: () {
                ref.read(themeProvider.notifier).setTheme(AppThemeMode.dark);
                Navigator.pop(context);
              },
            ),
            _ThemeOption(
              title: 'Dracula',
              subtitle: 'Purple, pink, cyan vibes',
              icon: Icons.dark_mode,
              isSelected: ref.watch(themeProvider) == AppThemeMode.dracula,
              onTap: () {
                ref.read(themeProvider.notifier).setTheme(AppThemeMode.dracula);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _ThemeOption extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  const _ThemeOption({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: isSelected ? Theme.of(context).colorScheme.primary : null),
      title: Text(title, style: TextStyle(fontWeight: isSelected ? FontWeight.bold : FontWeight.normal)),
      subtitle: Text(subtitle),
      trailing: isSelected ? Icon(Icons.check, color: Theme.of(context).colorScheme.primary) : null,
      onTap: onTap,
    );
  }
}
