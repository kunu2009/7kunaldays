# 📁 Project File Structure

```
kunal_evolution_app/
│
├── 📱 android/                          # Android-specific configuration
│   └── app/
│       └── src/
│           └── main/
│               └── AndroidManifest.xml  # Permissions & app config
│
├── 📦 lib/                              # Main application code
│   │
│   ├── main.dart                        # 🚀 App entry point
│   │                                    # - Initializes Hive
│   │                                    # - Registers adapters
│   │                                    # - Sets up notifications
│   │                                    # - Launches app
│   │
│   ├── 🎨 core/
│   │   └── theme.dart                   # App theme & colors
│   │                                    # - Dark background (#0A0E1A)
│   │                                    # - 7K accent colors
│   │                                    # - Typography (Montserrat/Inter)
│   │                                    # - Material 3 components
│   │
│   ├── 📊 models/                       # Data models
│   │   ├── daily_log.dart               # DailyLog + Metrics + MentalRatings
│   │   ├── daily_log.g.dart             # Generated Hive adapters
│   │   ├── nutrition_entry.dart         # Nutrition tracking model
│   │   └── nutrition_entry.g.dart       # Generated adapter
│   │
│   ├── 🔧 providers/                    # State management (Riverpod)
│   │   └── daily_log_provider.dart      # 
│   │                                    # - DailyLogRepository (CRUD)
│   │                                    # - TodayLogNotifier (state)
│   │                                    # - Streak providers
│   │                                    # - Analytics providers
│   │
│   ├── 🖥️ screens/                      # Full-page screens
│   │   ├── home_screen.dart             # Today's log (main screen)
│   │   │                                # - 4 time sections
│   │   │                                # - Quick metrics
│   │   │                                # - Reflections
│   │   │                                # - Bottom navigation
│   │   │
│   │   ├── dashboard_screen.dart        # Performance dashboard
│   │   │                                # - Streak counters (🔥)
│   │   │                                # - Study hours chart
│   │   │                                # - Fitness bar chart
│   │   │                                # - Sleep trend
│   │   │                                # - Mental performance
│   │   │
│   │   ├── planner_screen.dart          # Timeline planner (stub)
│   │   ├── analytics_screen.dart        # Monthly insights (stub)
│   │   │
│   │   └── settings_screen.dart         # App settings
│   │                                    # - Notification toggle
│   │                                    # - Export/import
│   │                                    # - Theme (future)
│   │
│   ├── 🧩 widgets/                      # Reusable UI components
│   │   ├── daily_section_card.dart      # Checklist section widget
│   │   │                                # - Morning/College/Evening/Night
│   │   │                                # - Progress bar
│   │   │                                # - Checkboxes
│   │   │                                # - Reflection input
│   │   │
│   │   ├── quick_metrics_card.dart      # Metrics display
│   │   │                                # - Study/Fitness/Water/Constitution
│   │   │                                # - Color-coded boxes
│   │   │
│   │   └── reflection_card.dart         # End-of-day reflection
│   │                                    # - Text inputs for prompts
│   │                                    # - Mental rating sliders
│   │
│   └── ⚡ services/
│       └── notification_service.dart    # Push notifications
│                                        # - Daily reminders (3x)
│                                        # - Streak alerts
│                                        # - Timezone scheduling
│
├── 📄 Documentation Files
│   ├── README.md                        # 📖 Main documentation
│   ├── SETUP_GUIDE.md                   # 🛠️ Installation & usage
│   ├── PROJECT_SUMMARY.md               # 📊 Technical overview
│   ├── GETTING_STARTED.md               # 🚀 Quick start guide
│   └── FILE_STRUCTURE.md                # 📁 This file
│
├── ⚙️ Configuration Files
│   ├── pubspec.yaml                     # Dependencies & metadata
│   ├── analysis_options.yaml            # Linting rules
│   └── build.ps1                        # Build automation script
│
└── 🏗️ Build Output (generated)
    └── build/
        └── app/
            └── outputs/
                └── flutter-apk/
                    └── app-release.apk  # 📱 Final APK file

```

---

## 🔍 File Purposes Quick Reference

### **Entry Point**
- `main.dart` → Start here, initializes everything

### **UI Screens** (5 files)
- `home_screen.dart` → Today's daily log ⭐ **Most Important**
- `dashboard_screen.dart` → Charts & streaks
- `planner_screen.dart` → Timeline (stub)
- `analytics_screen.dart` → Monthly analysis (stub)
- `settings_screen.dart` → App configuration

### **Reusable Widgets** (3 files)
- `daily_section_card.dart` → Morning/College/Evening/Night sections
- `quick_metrics_card.dart` → Study/Fitness/Water/Constitution display
- `reflection_card.dart` → End-of-day prompts & ratings

### **Data Layer** (5 files)
- `daily_log.dart` → Main data model (DailyLog, Metrics, MentalRatings)
- `nutrition_entry.dart` → Meal logging model
- `*.g.dart` → Auto-generated Hive adapters (don't edit manually)
- `daily_log_provider.dart` → State management & database operations

### **Configuration** (4 files)
- `theme.dart` → Colors, fonts, Material 3 styling
- `notification_service.dart` → Daily reminders (6 AM, 11:45 AM, 10:15 PM)
- `pubspec.yaml` → Package dependencies
- `AndroidManifest.xml` → Android permissions

### **Documentation** (5 files)
- `README.md` → Complete project overview
- `SETUP_GUIDE.md` → Step-by-step installation
- `PROJECT_SUMMARY.md` → Technical deep dive
- `GETTING_STARTED.md` → Quick start for first-time users
- `FILE_STRUCTURE.md` → This navigation guide

---

## 🎯 Where to Start Editing

### **Want to add a new daily task?**
→ Edit `lib/models/daily_log.dart`
- Find `_defaultMorningChecklist()` (or College/Evening/Night)
- Add your task: `'New task name': false,`

### **Want to change colors?**
→ Edit `lib/core/theme.dart`
- Modify color constants at the top
- App will auto-update everywhere

### **Want to change notification times?**
→ Edit `lib/services/notification_service.dart`
- Find `scheduleDailyReminders()`
- Change `hour` and `minute` values

### **Want to add a new metric?**
→ Edit `lib/models/daily_log.dart`
- Add field to `Metrics` class
- Regenerate adapters: `flutter pub run build_runner build`

### **Want to customize the home screen?**
→ Edit `lib/screens/home_screen.dart`
- Modify `TodayLogScreen` class
- Add/remove cards, change layout

---

## 🔄 Data Flow Architecture

```
┌─────────────────────────────────────────────────────────────┐
│  User Interface (Screens + Widgets)                         │
│  - home_screen.dart                                         │
│  - daily_section_card.dart                                  │
└─────────────────┬───────────────────────────────────────────┘
                  │ (User taps checkbox)
                  ▼
┌─────────────────────────────────────────────────────────────┐
│  State Management (Riverpod Providers)                      │
│  - TodayLogNotifier.toggleTask()                            │
│  - Updates in-memory state                                  │
└─────────────────┬───────────────────────────────────────────┘
                  │ (Save to database)
                  ▼
┌─────────────────────────────────────────────────────────────┐
│  Repository Layer                                           │
│  - DailyLogRepository.saveLog()                             │
└─────────────────┬───────────────────────────────────────────┘
                  │ (Write to disk)
                  ▼
┌─────────────────────────────────────────────────────────────┐
│  Persistence (Hive Database)                                │
│  - Stores in binary format                                  │
│  - Uses type adapters (daily_log.g.dart)                    │
└─────────────────────────────────────────────────────────────┘
```

---

## 📊 Component Hierarchy

```
KunalEvolutionApp (main.dart)
│
└── ProviderScope (Riverpod)
    │
    └── MaterialApp
        │
        └── HomeScreen (bottom navigation)
            │
            ├── [Tab 1] TodayLogScreen
            │   │
            │   ├── _buildHeader() → Date, mood, sleep, completion %
            │   ├── QuickMetricsCard → Study/Fitness/Water/Constitution
            │   ├── _buildQuickActions() → Copy Yesterday, Export
            │   │
            │   ├── DailySectionCard (Morning) ──┐
            │   ├── DailySectionCard (College)   │ Repeated 4 times
            │   ├── DailySectionCard (Evening)   │ with different data
            │   ├── DailySectionCard (Night) ────┘
            │   │
            │   ├── ReflectionCard → Prompts + Mental ratings
            │   └── _buildNightAffirmation() → Motivational quote
            │
            ├── [Tab 2] DashboardScreen
            │   │
            │   ├── _StreakCard × 3 (Study/Fitness/Journal)
            │   ├── _ChartCard (Study hours) → LineChart
            │   ├── _ChartCard (Fitness minutes) → BarChart
            │   ├── _ChartCard (Sleep hours) → LineChart
            │   └── _buildMentalPerformance() → Progress bars
            │
            ├── [Tab 3] PlannerScreen (stub)
            │
            └── [Tab 4] AnalyticsScreen (stub)
```

---

## 🛠️ Development Workflow

### **Making Changes**

1. **Edit source files** in `lib/`
2. **Hot reload** (press `r` in terminal during `flutter run`)
3. **Test changes** in emulator/device
4. **Build release** when ready: `flutter build apk --release`

### **Adding New Features**

1. **Models**: Add to `lib/models/`
2. **UI**: Add to `lib/screens/` or `lib/widgets/`
3. **Logic**: Add to `lib/providers/`
4. **Services**: Add to `lib/services/`

### **Regenerating Hive Adapters**

```powershell
flutter pub run build_runner build --delete-conflicting-outputs
```

Only needed if you:
- Add new `@HiveType` classes
- Add new `@HiveField` fields
- Change field IDs

---

## 📝 Code Style Guide

### **Naming Conventions**
- Files: `snake_case.dart`
- Classes: `PascalCase`
- Variables: `camelCase`
- Constants: `camelCase` with `const`
- Private: `_leadingUnderscore`

### **Organization**
- Imports grouped: flutter → packages → local
- One class per file (except small helper classes)
- Widgets before logic
- Public before private

### **Comments**
- `//` for inline comments
- `///` for documentation comments
- Explain "why", not "what"

---

## 🎯 Essential Files for Each Task

| Task | Files to Edit |
|------|---------------|
| Add new daily task | `lib/models/daily_log.dart` |
| Change app colors | `lib/core/theme.dart` |
| Modify home screen | `lib/screens/home_screen.dart` |
| Add new metric | `lib/models/daily_log.dart` + providers |
| Change notification time | `lib/services/notification_service.dart` |
| Add new screen | `lib/screens/new_screen.dart` + `home_screen.dart` |
| Create new widget | `lib/widgets/new_widget.dart` |
| Adjust charts | `lib/screens/dashboard_screen.dart` |

---

## 🔥 Hot Tips

- **Never edit `.g.dart` files** → They're auto-generated
- **Always run `flutter pub get`** after changing `pubspec.yaml`
- **Use hot reload (`r`)** during development → Saves time
- **Build release APK** only when testing final version
- **Check `analysis_options.yaml`** for code quality rules

---

**Now you can navigate the project like a pro!** 🚀
