# 🚀 Quick Start Guide - Kunal's Evolution App

## 📱 Installation Steps

### Option 1: Build from Source (Recommended)

1. **Install Flutter**
   - Download from https://flutter.dev/docs/get-started/install/windows
   - Add Flutter to PATH
   - Run `flutter doctor` to verify installation

2. **Open Project**
   ```powershell
   cd "c:\Desktop\be the best app\kunal_evolution_app"
   ```

3. **Install Dependencies**
   ```powershell
   flutter pub get
   ```

4. **Generate Hive Type Adapters**
   ```powershell
   flutter pub run build_runner build --delete-conflicting-outputs
   ```

5. **Connect Android Device or Start Emulator**
   - Enable USB Debugging on your phone
   - OR start Android Emulator

6. **Run the App**
   ```powershell
   flutter run
   ```

7. **Build Release APK**
   ```powershell
   flutter build apk --release
   ```
   APK location: `build\app\outputs\flutter-apk\app-release.apk`

---

## 📋 First-Time Setup

### After Installing the App

1. **Grant Permissions**
   - Allow notification permissions when prompted
   - This enables daily reminders (6 AM, 11:45 AM, 10:15 PM)

2. **Explore Today's Log**
   - App auto-creates today's daily log
   - Set your mood emoji (🧠 / 💪 / ⚙️ / 😌)
   - Enter sleep hours
   - Choose theme (Focus / Consistency / Growth)

3. **Complete Morning Section**
   - Check off tasks as you complete them
   - Add morning wins reflection

4. **Navigate the App**
   - **Today** (Home) - Daily log & checklists
   - **Dashboard** - Streaks & charts
   - **Planner** - Timeline view (coming soon)
   - **Analytics** - Monthly insights (coming soon)

5. **Enable Notifications**
   - Go to Settings → Notifications
   - Toggle "Daily Reminders" ON
   - Confirm notification permissions

---

## 🎯 Daily Usage Flow

### Morning Routine (6:00 AM)
```
1. Receive notification "Rise & Focus"
2. Open app → Auto-loads today
3. Set mood & sleep hours
4. Complete morning checklist:
   ☐ Wake up + water + wash
   ☐ Workout
   ☐ Bath + hygiene
   ☐ Study Block 1
   ☐ MHCET Practice
   ☐ Breakfast
5. Log study hours in metrics
```

### College Time (11:55 AM)
```
1. Notification reminder
2. Quick check: Add any observations
3. Track lectures attended
```

### Evening Block (6:30 PM)
```
1. Complete evening tasks
2. Log 7K actions (posted video, edited reel, etc.)
3. Update study hours
4. Add fitness minutes
5. Log nutrition (meals eaten)
6. Update water intake
```

### Night Closure (10:15 PM)
```
1. Notification: "Night Reflection"
2. Fill reflection prompts:
   - 1 great thing today
   - 1 improvement tomorrow
   - Gratitude
   - What slowed me down
   - Lesson learned
3. Rate mental performance (1-10):
   - Focus
   - Energy
   - Mood
   - Confidence
   - Self-Control
4. Check completion percentage
5. Read night affirmation
```

---

## 📊 Understanding the Dashboard

### Streaks
- **Study Streak** 🔥: Days with 2+ study hours
- **Fitness Streak** 💪: Days with 30+ workout minutes
- **Journal Streak** 🧘: Days with completed reflection

### Charts
- **Study Hours**: 7-day line chart
- **Fitness Minutes**: Bar chart showing workout consistency
- **Sleep Hours**: Track sleep patterns
- **Mental Performance**: Average ratings across dimensions

---

## 💡 Pro Tips

### Maximize Efficiency
1. **Use "Copy Yesterday"** - Carries over unfinished tasks
2. **Quick Toggle** - Tap checkboxes instantly (auto-saves)
3. **Dashboard Check** - Review weekly at 10 PM Sunday
4. **Streak Protection** - Never break study/fitness chains

### Data Management
- Export weekly as Markdown backup
- Review monthly analytics for patterns
- Adjust goals based on performance trends

### Habit Stacking
```
Morning: Wake → Water → Open App → Check Mood → Workout → Log
Evening: 7K Work → Log Action → Study → Reflect → Sleep Setup
```

---

## 🔧 Troubleshooting

### App Won't Open
```powershell
# Reinstall dependencies
flutter clean
flutter pub get
flutter pub run build_runner build
flutter run
```

### Notifications Not Working
- Settings → Apps → Evolution → Notifications → Allow All
- Settings (in-app) → Toggle Daily Reminders OFF/ON

### Data Not Saving
- Check storage permissions
- Ensure app not force-stopped
- Restart app

### Build Errors
```powershell
# Delete build folder
flutter clean
# Reinstall
flutter pub get
flutter pub run build_runner build --delete-conflicting-outputs
```

---

## 📱 Transfer APK to Phone

### Method 1: USB Cable
1. Copy `app-release.apk` from build folder
2. Connect phone via USB
3. Transfer to phone's Downloads
4. Open file → Install

### Method 2: Google Drive
1. Upload APK to Drive
2. Download on phone
3. Install

### Method 3: Direct Install
```powershell
# Phone connected via USB
flutter install
```

---

## 🎨 Customization

### Change Theme Colors
Edit `lib/core/theme.dart`:
```dart
static const Color primaryTeal = Color(0xFF00FFC8); // Your color
```

### Modify Checklists
Edit default tasks in `lib/models/daily_log.dart`:
```dart
static Map<String, bool> _defaultMorningChecklist() {
  return {
    'Your custom task': false,
    // Add more...
  };
}
```

### Adjust Notification Times
Edit `lib/services/notification_service.dart`:
```dart
await _scheduleNotification(
  hour: 6,  // Change time
  minute: 30,
);
```

---

## 📈 Recommended Workflow

### Week 1: Foundation
- Focus on completing all daily checklists
- Build habit of opening app 3x/day
- Start tracking study hours accurately

### Week 2: Optimization
- Analyze Dashboard weekly
- Identify weak areas
- Adjust checklist based on reality

### Week 3: Momentum
- Protect streaks
- Use reflections to improve
- Export first weekly summary

### Week 4: Mastery
- App becomes second nature
- Review monthly analytics
- Set higher goals

---

## 🚀 Next Steps

1. **Complete Today's Log** - Check off every task
2. **Build Your First Streak** - 7 days of consistent journaling
3. **Review Dashboard Weekly** - Sunday 10 PM ritual
4. **Export Monthly Backup** - Keep data safe

---

## 💪 Mantras

> "Focus. Consistency. Growth."

> "Tomorrow, I rise 1% better — quietly, relentlessly."

> "Every check, every reflection, every day = Evolution."

---

## 📞 Support

For issues or questions:
1. Check README.md for detailed docs
2. Review code comments in source files
3. Rebuild with `flutter clean` + `flutter pub get`

---

**Remember**: This app is not about perfection.  
**It's about showing up every single day.**

🔥 **Let's build consistency. Let's evolve.** 🔥
