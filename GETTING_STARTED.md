# 🚀 GETTING STARTED - Quick Installation Guide

## ⚡ Fastest Path to Running the App

### **Option 1: Run on Emulator (Recommended for Testing)**

1. **Open Android Studio**
   - Start → Android Studio
   - Tools → AVD Manager
   - Click "Play" on any device (Pixel 5 recommended)

2. **Open Terminal in VS Code**
   ```powershell
   cd "c:\Desktop\be the best app\kunal_evolution_app"
   ```

3. **Install Dependencies**
   ```powershell
   flutter pub get
   ```

4. **Run the App**
   ```powershell
   flutter run
   ```
   
   ✅ App will launch on emulator in ~2 minutes

---

### **Option 2: Build APK for Real Phone**

1. **Open Terminal**
   ```powershell
   cd "c:\Desktop\be the best app\kunal_evolution_app"
   ```

2. **Run Build Script**
   ```powershell
   .\build.ps1
   ```

3. **Find Your APK**
   - Location: `build\app\outputs\flutter-apk\app-release.apk`
   - Size: ~20-30 MB

4. **Transfer to Phone**
   - **Method 1**: USB cable → Copy to Downloads
   - **Method 2**: Upload to Google Drive → Download on phone
   - **Method 3**: Email to yourself → Download attachment

5. **Install on Phone**
   - Open APK file
   - Settings → Allow installs from this source
   - Install
   - Grant notification permissions

---

## 🔧 Troubleshooting

### **Error: "Flutter SDK not found"**
```powershell
# Install Flutter
# Download from: https://flutter.dev/docs/get-started/install/windows
# Extract to C:\flutter
# Add to PATH: C:\flutter\bin

# Verify
flutter doctor
```

### **Error: "No devices connected"**
```powershell
# Check devices
flutter devices

# If empty:
# - Start Android Emulator (Android Studio → AVD Manager)
# OR
# - Connect phone via USB + Enable USB Debugging
```

### **Error: "Build failed"**
```powershell
# Clean and rebuild
flutter clean
flutter pub get
flutter run
```

### **Hive Adapter Errors**
```powershell
# The .g.dart files are already created, but if you get errors:
flutter pub run build_runner build --delete-conflicting-outputs
```

---

## 📱 First Launch Checklist

After installing the app:

1. ✅ Grant notification permissions
2. ✅ Set your mood emoji
3. ✅ Enter sleep hours
4. ✅ Choose theme (Focus/Consistency/Growth)
5. ✅ Check off your first morning task
6. ✅ Explore Dashboard (bottom nav)
7. ✅ Go to Settings → Enable daily reminders

---

## 🎯 Daily Usage (30 seconds per check-in)

### **Morning (6:00 AM)**
- Open app
- Set mood + sleep
- Check off completed tasks
- Close app

### **Throughout Day**
- Open when task done
- Tap checkbox
- Close app

### **Night (10:15 PM)**
- Open app
- Fill reflections (2-3 mins)
- Rate mental performance
- Check completion %
- Close app

**That's it!** The app auto-saves everything.

---

## 📊 Understanding Your Data

### **Where is data stored?**
- All data: Local Hive database
- Location: `/Android/data/com.kunal.evolutionapp/`
- Format: Binary (fast, secure)
- Backup: Export to Markdown/JSON (coming soon)

### **What gets tracked?**
- ✅ All checklist completions
- ✅ Reflections and notes
- ✅ Study/fitness/water metrics
- ✅ Mental performance ratings
- ✅ Streaks (study/fitness/journal)
- ✅ Constitution progress

---

## 🔥 Pro Tips

1. **Enable Notifications**
   - Settings → Daily Reminders → ON
   - Never miss a check-in

2. **Use "Copy Yesterday"**
   - Transfers unfinished tasks
   - Saves time on recurring items

3. **Check Dashboard Weekly**
   - Sunday 10 PM ritual
   - Review streaks and charts
   - Plan next week adjustments

4. **Protect Your Streaks**
   - Study: 2+ hours = streak continues
   - Fitness: 30+ mins = streak continues
   - Journal: Complete reflection = streak continues

5. **Track Constitution Progress**
   - Update after each revision session
   - Goal: 51/51 articles mastered

---

## 🎨 Customization

### **Change Mood Emoji**
- Home screen → Tap mood emoji
- Select: 🧠 (Brain) / 💪 (Power) / ⚙️ (System) / 😌 (Calm)

### **Adjust Sleep Hours**
- Home screen → Tap sleep hours
- Drag slider or type exact value

### **Edit Theme**
- Home screen → Tap theme name
- Choose: Focus / Consistency / Growth

---

## 📈 Progress Tracking

### **Daily**
- Completion % on home screen
- Quick metrics card (study/fitness/water/constitution)

### **Weekly**
- Dashboard → View 7-day charts
- Study hours trend
- Fitness consistency
- Sleep pattern

### **Monthly**
- Analytics screen (coming in Phase 2)
- Average mental performance
- Goal achievement rate

---

## 🛡️ Data Safety

### **Backup Strategy**
1. **Manual Export** (when feature added)
   - Settings → Export All Data
   - Save as `evolution-backup-2025-11-01.json`

2. **Cloud Sync** (future)
   - Settings → Google Drive Sync
   - Auto-backup daily

3. **Keep Phone Safe**
   - All data is local
   - Losing phone = losing data (until cloud sync)

---

## 🚀 What's Next?

### **Phase 1** (Current - Fully Functional)
- ✅ Daily log system
- ✅ Performance dashboard
- ✅ Reflections
- ✅ Notifications
- ✅ Streaks

### **Phase 2** (Coming Soon)
- [ ] Markdown export
- [ ] Nutrition detailed tracker
- [ ] 7K action archive
- [ ] Planner timeline

### **Phase 3** (Future)
- [ ] Google Drive sync
- [ ] Voice reflections
- [ ] AI insights
- [ ] Weekly PDF reports

---

## 💬 Understanding the Philosophy

**This app is not about:**
- ❌ Gamification
- ❌ Social features
- ❌ Dopamine hits
- ❌ Perfectionism

**This app IS about:**
- ✅ Consistency
- ✅ Self-reflection
- ✅ Data-driven improvement
- ✅ Quiet discipline

> "Tomorrow, I rise 1% better — quietly, relentlessly."

---

## 🎯 Success Metrics

### **Week 1 Goal**
- Open app 3x/day minimum
- Complete 70%+ of daily tasks
- Start study streak

### **Week 2 Goal**
- Build 7-day study streak
- Fill all reflections
- Review dashboard once

### **Week 3 Goal**
- Maintain 80%+ completion
- Add 7K actions daily
- Track Constitution progress

### **Week 4 Goal**
- Complete first month
- Analyze trends
- Adjust goals based on data

---

## 📞 Need Help?

1. Check `README.md` for detailed docs
2. Review `SETUP_GUIDE.md` for step-by-step
3. Read `PROJECT_SUMMARY.md` for technical details

---

## 🎓 Remember

**Building habits takes time.**

- Week 1: Feels like effort
- Week 2: Becomes routine
- Week 3: Feels natural
- Week 4: Can't imagine without it

**Trust the process. Stay consistent. Evolve daily.**

---

## ✅ Final Checklist

Before you start:
- [ ] App installed on phone
- [ ] Notifications enabled
- [ ] First log created
- [ ] Understand daily workflow
- [ ] Know where to find streaks
- [ ] Committed to 30-day trial

---

**You're ready. Start today. Build your evolution.** 🔥

*"Focus. Consistency. Growth."*
