# 🚀 Kunal's High-Performance Evolution App

> **"Focus. Consistency. Growth."**
> 
> A personal performance operating system designed to help Kunal achieve academic excellence, build an aesthetic physique, grow the 7K brand ecosystem, and develop unshakeable confidence.

---

## 📱 Overview

**Kunal's High-Performance Evolution App** is an offline-first Flutter mobile application that digitizes and enhances the daily tracking system originally designed in Obsidian. It's not just another habit tracker—it's a complete **daily operating system** for life optimization.

### 🎯 Core Goals

1. **Academic Excellence** - Rank under 50 in MHCET 5-Year LLB + 90%+ in Maharashtra 12th Board
2. **Constitution Mastery** - Track progress through Articles 1-51
3. **Fitness & Physique** - Build an aesthetic, healthy body with structured workouts
4. **7K Ecosystem Growth** - Daily brand-building actions and digital presence
5. **Confidence Building** - Track posture, voice, eye contact, and discipline

---

## ✨ Key Features

### 🧠 **Daily Log System**
- Auto-creates structured daily logs with date-based storage
- Four time-block sections:
  - 🌅 Morning (6:00–10:45 AM) - Preparation & Study
  - 🏫 College (11:55–6 PM) - Focus & Learning
  - 🌇 Evening (6:30–10:30 PM) - 7K Work & Revision
  - 🌙 Night (10:30–1 AM) - Reflection & Sleep
- Interactive checklists with instant save
- Sectional reflections and notes
- Progress tracking with completion percentages

### 📊 **Performance Dashboard**
- **Streak Counters** - Study 🔥 / Fitness 💪 / Journal 🧘
- **Visual Charts** (powered by fl_chart):
  - Study hours trend (7-day line chart)
  - Fitness minutes (bar chart)
  - Sleep hours tracking
  - Mental performance averages
- Real-time metrics display

### 🎯 **Daily Missions**
- **Academics Module**
  - Morning focus blocks (MHCET + 12th + Constitution)
  - Practice sessions with error logging
  - Evening recall blocks
  - Night reinforcement
  - Constitution progress (0-51 articles tracker)
- **Fitness Tracking**
  - Workout duration logging
  - Water intake (target 2.5-3L)
  - Steps counter
  - Weight tracking
- **7K Ecosystem**
  - Daily micro-action logger
  - Timestamped action archive
- **Confidence Habits**
  - Self-rating system
  - Habit checklist (posture, voice, eye contact)

### 🍽 **Nutrition Tracker**
- Predefined budget-friendly meal plan
- Editable food log table
- Hydration tracking
- Affordable upgrade suggestions (₹10-15)

### 🪶 **Reflection & Mental Review**
- End-of-day journaling prompts:
  - 1 great thing today
  - 1 improvement for tomorrow
  - Gratitude log
  - Top 3 wins
  - Obstacles analysis
  - Lesson of the day
- **Mental Performance Ratings** (1-10 scale):
  - Focus
  - Energy
  - Mood
  - Confidence
  - Self-Control

### ⚡ **Automation & Intelligence**
- Smart daily reminders:
  - 6:00 AM - "Rise & Focus"
  - 11:45 AM - "College Mode"
  - 10:15 PM - "Night Reflection"
- Streak reminder notifications
- Auto-create today's log on app open
- "Copy yesterday's unfinished tasks" feature

### 🎨 **Design Philosophy**
- **Dark minimalist aesthetic** - Deep charcoal (#0A0E1A)
- **7K accent colors** - Neon teal (#00FFC8) primary
- **Clean typography** - Montserrat (headlines) + Inter (body)
- **Calm, focused UI** - No distractions, no dopamine features
- **Smooth animations** - Fade/slide transitions only

---

## 🏗️ Architecture

### **Tech Stack**
- **Framework**: Flutter 3+
- **State Management**: Riverpod
- **Local Database**: Hive (offline-first)
- **Charts**: fl_chart
- **Notifications**: flutter_local_notifications
- **UI**: Material 3 + Custom Dark Theme
- **Export**: Markdown & JSON

### **Project Structure**
```
lib/
├── main.dart                   # App entry point
├── core/
│   └── theme.dart              # App theme & colors
├── models/
│   ├── daily_log.dart          # DailyLog + Metrics + MentalRatings
│   └── nutrition_entry.dart    # Nutrition model
├── providers/
│   └── daily_log_provider.dart # State management
├── screens/
│   ├── home_screen.dart        # Today's log + navigation
│   ├── dashboard_screen.dart   # Charts & streaks
│   ├── planner_screen.dart     # Timeline planner
│   ├── analytics_screen.dart   # Monthly insights
│   └── settings_screen.dart    # App configuration
├── widgets/
│   ├── daily_section_card.dart # Section checklist widget
│   ├── quick_metrics_card.dart # Metrics display
│   └── reflection_card.dart    # Reflection inputs
└── services/
    └── notification_service.dart # Push notifications
```

---

## 📦 Installation

### **Prerequisites**
- Flutter SDK 3.0+
- Android Studio / VS Code
- Android device or emulator (Android 8.0+)

### **Setup Steps**

1. **Clone or download the project**
```powershell
cd "c:\Desktop\be the best app\kunal_evolution_app"
```

2. **Install dependencies**
```powershell
flutter pub get
```

3. **Generate Hive adapters**
```powershell
flutter pub run build_runner build --delete-conflicting-outputs
```

4. **Run the app**
```powershell
flutter run
```

5. **Build APK for release**
```powershell
flutter build apk --release
```

The APK will be generated at:
`build\app\outputs\flutter-apk\app-release.apk`

---

## 💾 Data Structure

### **DailyLog Model**
```dart
{
  date: String (YYYY-MM-DD)
  mood: String (emoji/text)
  sleepHours: double
  theme: String (Focus/Consistency/Growth)
  
  // Checklists
  morningChecklist: Map<String, bool>
  collegeChecklist: Map<String, bool>
  eveningChecklist: Map<String, bool>
  nightChecklist: Map<String, bool>
  
  // Reflections
  morningWins: String
  collegeInteractions: String
  eveningIdeas: String
  oneGreatThing: String
  oneImprovement: String
  gratitude: String
  topThreeWins: List<String>
  whatSlowedDown: String
  lessonOfTheDay: String
  
  // Metrics
  metrics: {
    studyHours: double
    fitnessMinutes: int
    screenTime: double
    steps: int
    weight: double
  }
  
  // Mental Ratings (1-10)
  mentalRatings: {
    focus: int
    energy: int
    mood: int
    confidence: int
    selfControl: int
  }
  
  // Additional
  sevenKActions: List<SevenKAction>
  constitutionProgress: int (0-51)
  nutritionLog: List<NutritionEntry>
  waterIntake: double
  
  // Night Closure
  timeslept: String
  phoneUseAfter11PM: bool
  journalDone: bool
  nextDayPrioritySet: bool
}
```

---

## 🔧 Usage Guide

### **Daily Workflow**

1. **Morning (6:00 AM)**
   - Open app → Auto-loads today's log
   - Set mood emoji & sleep hours
   - Check off morning routine items
   - Log first study session

2. **Throughout Day**
   - Toggle completed tasks in real-time
   - Add 7K actions as they happen
   - Log meals and water intake
   - Update Constitution progress

3. **Evening (6:30 PM)**
   - Review college checklist
   - Complete evening tasks
   - Add reflections and ideas

4. **Night (10:15 PM)**
   - Fill reflection prompts
   - Rate mental performance (1-10)
   - Review day's completion %
   - Set next day priority

### **Dashboard Analysis**
- View study/fitness/journal streaks
- Analyze 7-day trends
- Track mental performance averages
- Identify patterns and improvements

### **Export & Backup**
- Export daily logs as Markdown (Template.md format)
- Export as JSON for backup/restore
- Optional Google Drive sync (future)

---

## 🎨 Color Scheme

| Element | Color | Hex Code |
|---------|-------|----------|
| Background | Deep Charcoal | `#0A0E1A` |
| Cards | Dark Blue-Grey | `#1A1F2E` |
| Primary Accent | Neon Teal | `#00FFC8` |
| Study | Teal | `#00FFC8` |
| Fitness | Orange | `#FF6B35` |
| Brand | Blue | `#4A90E2` |
| Confidence | Amber | `#FFC107` |

---

## 🔒 Privacy & Performance

- **100% Offline** - All data stored locally in Hive
- **No Tracking** - Zero analytics, ads, or telemetry
- **Lightweight** - Target APK size <40MB
- **Fast** - Instant load times, reactive UI
- **Secure** - Data stored in app-specific directory

---

## 🚧 Future Roadmap

### **Phase 2 Features**
- [ ] Pomodoro timer integration in Planner
- [ ] Visual timeline with drag-drop tasks
- [ ] Height/weight growth charts
- [ ] Voice-based reflection input
- [ ] Weekly PDF summary reports
- [ ] Constitution article flashcards

### **Phase 3 Enhancements**
- [ ] Google Drive auto-sync
- [ ] Home screen widgets (quick workout log)
- [ ] Health Connect integration (steps/sleep)
- [ ] AI-powered insights & pattern detection
- [ ] Multi-language support (Marathi/Hindi)
- [ ] Dark/Light/Custom themes

---

## 🛠️ Development Notes

### **To Generate Hive Adapters**
```powershell
flutter pub run build_runner build
```

### **To Watch for Changes**
```powershell
flutter pub run build_runner watch
```

### **Clean Build**
```powershell
flutter clean
flutter pub get
flutter pub run build_runner build --delete-conflicting-outputs
```

---

## 📝 Template Integration

The app preserves the exact structure of the original `Template.md` used in Obsidian:

- **Daily Sections** → Interactive checklists
- **Reflection Prompts** → Text input fields
- **Metrics Table** → Real-time tracking
- **Night Affirmation** → Displayed on home screen
- **Markdown Export** → Generates Template.md format for backup

---

## 💡 Philosophy

> This app embodies Kunal's philosophy:
> **"Tomorrow, I rise 1% better — quietly, relentlessly."**

Every feature is designed to:
- **Eliminate friction** in daily tracking
- **Visualize progress** to maintain motivation
- **Build discipline** through consistent reflection
- **Optimize time** for maximum productivity

This isn't about perfection—it's about **consistent evolution**.

---

## 👨‍💻 Credits

**Designed for**: Kunal's High-Performance Journey  
**Purpose**: Academic excellence, fitness, 7K brand growth, and self-mastery  
**Inspiration**: Obsidian Template.md daily framework  
**Built with**: Flutter, Riverpod, Hive, fl_chart  

---

## 📄 License

This project is built as a personal tool for Kunal's evolution journey.  
Feel free to adapt for your own high-performance system.

---

## 🔥 Final Note

**This is not a habit tracker.**  
**This is a performance operating system.**

Every tap, every check, every reflection is a brick in the foundation of excellence.

**Rise. Execute. Evolve.** 🚀

---

*Version 1.0.0 - Evolution Edition*  
*Built with focus, designed for growth.*
