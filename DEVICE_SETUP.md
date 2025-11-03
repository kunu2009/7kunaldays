# 🔧 DEVICE SETUP - Getting the App Running

## ⚠️ Current Issue
**No Android devices connected** - You need either:
- An Android emulator (virtual device)
- A physical Android phone with USB debugging

---

## ✅ SOLUTION 1: Use Android Emulator (Recommended)

### **Step 1: Check if Android Studio is installed**
```powershell
# Open Android Studio
# Start Menu → Type "Android Studio" → Open
```

### **Step 2: Open AVD Manager**
1. Open Android Studio
2. Click **"More Actions"** (3 dots)
3. Select **"Virtual Device Manager"** (or AVD Manager)

### **Step 3: Create/Start an Emulator**

#### **If you already have an emulator:**
- Click the **▶️ Play** button next to any device
- Wait 1-2 minutes for it to boot

#### **If you need to create one:**
1. Click **"Create Virtual Device"**
2. Select **Phone** → **Pixel 5** → **Next**
3. Download a system image (recommended: **Tiramisu API 33**)
4. Click **Next** → **Finish**
5. Click **▶️ Play** to start it

### **Step 4: Run the App**
```powershell
# Wait for emulator to fully boot (you'll see the Android home screen)
# Then run:
flutter run
```

---

## ✅ SOLUTION 2: Use Physical Android Phone

### **Step 1: Enable Developer Mode**
1. Go to **Settings** → **About Phone**
2. Tap **"Build Number"** 7 times
3. You'll see "You are now a developer!"

### **Step 2: Enable USB Debugging**
1. Go to **Settings** → **System** → **Developer Options**
2. Turn on **"USB Debugging"**
3. Turn on **"Install via USB"** (if available)

### **Step 3: Connect Phone**
1. Connect phone to PC via USB cable
2. On phone, tap **"Allow USB Debugging"** when prompted
3. Check "Always allow from this computer"

### **Step 4: Verify Connection**
```powershell
flutter devices
```

You should see your phone listed!

### **Step 5: Run the App**
```powershell
flutter run
```

---

## 🚀 ALTERNATIVE: Build APK Directly (Skip Testing)

If you want to skip emulator/device testing and just build the APK:

```powershell
# This builds the release APK without running it
flutter build apk --release
```

**Output location:**
```
build\app\outputs\flutter-apk\app-release.apk
```

Then transfer this APK to your phone:
1. Copy `app-release.apk` to phone's Downloads folder
2. Open the APK file on phone
3. Allow installation from unknown sources
4. Install and use!

---

## 🔍 Troubleshooting

### **"No devices found"**
```powershell
# Check what Flutter sees
flutter devices

# If empty, restart ADB server:
flutter doctor
adb kill-server
adb start-server
flutter devices
```

### **Emulator won't start**
- Make sure you have at least 8GB RAM available
- Close other programs
- Restart Android Studio
- Try a different emulator (create a new one)

### **Phone not detected**
- Try a different USB cable
- Try a different USB port
- Restart phone
- Reinstall USB drivers
- Check that USB Debugging is ON

### **Build errors**
```powershell
flutter clean
flutter pub get
flutter run
```

---

## ⚡ FASTEST PATH TO RUNNING APP

### **If you have Android Studio installed:**
1. Open Android Studio
2. AVD Manager → Click ▶️ on any device
3. Wait 2 minutes for emulator to boot
4. In VS Code terminal:
   ```powershell
   flutter run
   ```

### **If you DON'T have Android Studio:**
**Option A: Install Android Studio** (1-2 hours)
- Download from: https://developer.android.com/studio
- Install with default settings
- Open → Tools → AVD Manager → Create device
- Then follow steps above

**Option B: Use your phone** (5 minutes)
- Enable Developer Mode (tap Build Number 7 times)
- Enable USB Debugging
- Connect via USB
- Allow USB debugging
- Run `flutter run`

**Option C: Just build APK** (2 minutes)
- Run `flutter build apk --release`
- Transfer APK to phone
- Install directly

---

## 💡 RECOMMENDATION

**For testing and development:**
→ Use Android Emulator (Pixel 5 with API 33)

**For final version:**
→ Build APK and test on real phone

**Fastest right now:**
→ If you have a phone nearby, use Option B (USB debugging)
→ Otherwise, build APK directly with Option C

---

## 🎯 NEXT COMMAND

### **If you're setting up emulator:**
```powershell
# Wait for emulator to boot, then:
flutter run
```

### **If you're using phone:**
```powershell
# After enabling USB debugging and connecting:
flutter devices
flutter run
```

### **If you just want the APK:**
```powershell
flutter build apk --release
```

---

## ✅ After Successful Run

Once the app is running, you'll see:
- Flutter logo splash screen
- Today's date with mood selection
- Morning/College/Evening/Night sections
- Bottom navigation (Today/Dashboard/Planner/Analytics)

**Then you can:**
- Check off tasks
- Set mood and sleep hours
- View dashboard with charts
- Test notifications in settings

---

**Choose your path and let me know if you need help with any step!** 🚀
