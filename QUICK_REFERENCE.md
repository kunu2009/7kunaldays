# ⚡ QUICK REFERENCE CARD

## 🚀 Build & Run Commands

```powershell
# Navigate to project
cd "c:\Desktop\be the best app\kunal_evolution_app"

# Install dependencies
flutter pub get

# Run on emulator/device
flutter run

# Build release APK
flutter build apk --release

# Or use build script
.\build.ps1

# Clean build
flutter clean
flutter pub get
flutter run
```

---

## 📁 Important File Locations

| File | Purpose |
|------|---------|
| `lib/main.dart` | App entry point |
| `lib/screens/home_screen.dart` | Today's log screen |
| `lib/screens/dashboard_screen.dart` | Charts & streaks |
| `lib/models/daily_log.dart` | Data structure |
| `lib/providers/daily_log_provider.dart` | State management |
| `lib/core/theme.dart` | Colors & styling |
| `lib/services/notification_service.dart` | Reminders |
| `build\app\outputs\flutter-apk\app-release.apk` | Final APK |

---

## 🎯 Daily Usage Shortcuts

| Time | Action | Duration |
|------|--------|----------|
| 6:00 AM | Open → Set mood/sleep → Check tasks | 30 sec |
| Throughout | Toggle completed tasks | 10 sec |
| 6:30 PM | Evening checklist + metrics | 1 min |
| 10:15 PM | Reflections + mental ratings | 3 min |

---

## 📊 Streak Requirements

| Streak | Requirement |
|--------|-------------|
| Study 🔥 | ≥2 hours of study |
| Fitness 💪 | ≥30 minutes workout |
| Journal 🧘 | Complete reflection prompts |

---

## 🎨 Color Reference

```dart
Background:    #0A0E1A  (Deep Charcoal)
Cards:         #1A1F2E  (Dark Blue-Grey)
Primary:       #00FFC8  (Neon Teal)
Study:         #00FFC8  (Teal)
Fitness:       #FF6B35  (Orange)
Brand:         #4A90E2  (Blue)
Confidence:    #FFC107  (Amber)
```

---

## 🔔 Notification Schedule

- **6:00 AM** - "Rise & Focus"
- **11:45 AM** - "College Mode"
- **10:15 PM** - "Night Reflection"

---

## 🧩 Bottom Navigation Tabs

1. **Today** - Daily log & checklists
2. **Dashboard** - Streaks & charts
3. **Planner** - Timeline (coming soon)
4. **Analytics** - Monthly stats (coming soon)

---

## 📈 Metrics Tracked

- Study hours (daily/weekly)
- Fitness minutes (daily/weekly)
- Water intake (liters)
- Constitution progress (0-51)
- Sleep hours (daily/weekly)
- Mental performance (5 dimensions, 1-10)
- Task completion (percentage)

---

## 🔧 Troubleshooting Quick Fixes

| Problem | Solution |
|---------|----------|
| App won't run | `flutter clean` → `flutter pub get` |
| No devices found | Start emulator or connect phone |
| Build errors | Run `flutter doctor` |
| Notifications not working | Settings → Allow permissions |
| Data not saving | Restart app |

---

## 📖 Documentation Guide

- **README.md** → Full project overview
- **GETTING_STARTED.md** → Quick setup (start here!)
- **SETUP_GUIDE.md** → Detailed instructions
- **FILE_STRUCTURE.md** → Code navigation
- **PROJECT_SUMMARY.md** → Technical details
- **COMPLETION_REPORT.md** → What's done & next steps

---

## 💡 Pro Tips

1. ✅ Enable notifications (Settings → Daily Reminders)
2. ✅ Use "Copy Yesterday" for recurring tasks
3. ✅ Review Dashboard every Sunday 10 PM
4. ✅ Never break your streaks
5. ✅ Track Constitution progress after each session
6. ✅ Rate mental performance honestly
7. ✅ Export data weekly (when feature available)

---

## 🎯 30-Day Challenge

| Week | Goal |
|------|------|
| Week 1 | Open app 3x/day, complete 70% tasks |
| Week 2 | Build 7-day study streak |
| Week 3 | Maintain 80%+ completion |
| Week 4 | Review monthly analytics |

---

## 🔥 Mantras

> "Focus. Consistency. Growth."

> "Tomorrow, I rise 1% better — quietly, relentlessly."

> "Every check, every reflection, every day = Evolution."

---

## 📱 APK Transfer Methods

**Method 1**: USB cable → Copy to Downloads → Install
**Method 2**: Google Drive → Upload → Download on phone
**Method 3**: `flutter install` (phone connected)

---

## ⚙️ Customization Quick Edits

| Want to Change | Edit This File | Line |
|----------------|----------------|------|
| App colors | `lib/core/theme.dart` | Lines 6-16 |
| Daily tasks | `lib/models/daily_log.dart` | Lines 120-160 |
| Notification times | `lib/services/notification_service.dart` | Lines 31-55 |
| Mood emojis | `lib/screens/home_screen.dart` | Display logic |

---

## 🚀 Version Info

- **Version**: 1.0.0 - Evolution Edition
- **Build Date**: November 1, 2025
- **Flutter**: 3.0+
- **Platform**: Android (iOS-ready)
- **Status**: Production-ready

---

## 📞 Emergency Commands

```powershell
# Nuclear option (fixes most issues)
flutter clean
flutter pub get
flutter pub run build_runner build --delete-conflicting-outputs
flutter run

# Check Flutter health
flutter doctor

# List connected devices
flutter devices

# Upgrade Flutter
flutter upgrade
```

---

## ✅ Pre-Launch Checklist

- [ ] Dependencies installed (`flutter pub get`)
- [ ] App runs on emulator (`flutter run`)
- [ ] APK built successfully (`flutter build apk`)
- [ ] APK transferred to phone
- [ ] App installed on device
- [ ] Notifications permissions granted
- [ ] First daily log created
- [ ] Settings configured

---

## 🎓 Remember

**This app works IF you work.**

Consistency > Intensity
Daily > Perfect
Done > Planned

**Show up. Check in. Evolve.**

---

**Keep this card bookmarked for quick reference!** ⚡
