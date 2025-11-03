import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

enum AppThemeMode { light, dark, dracula }

class AppTheme {
  // Light Mode - Timberwolf Colors
  static const Color lightTimberwolf = Color(0xFFDAD4C3);
  static const Color lightWhite = Color(0xFFFFFFFF);
  static const Color lightGrey = Color(0xFF9E9E9E);
  static const Color lightDarkGrey = Color(0xFF616161);
  static const Color lightAccent = Color(0xFF00ACC1);
  static const Color lightBackground = Color(0xFFF5F5F5);
  static const Color lightCardBg = Color(0xFFFFFFFF);
  
  // Dark Mode - 7K Colors  
  static const Color primaryTeal = Color(0xFF00FFC8);
  static const Color darkBackground = Color(0xFF0A0E1A);
  static const Color cardBackground = Color(0xFF1A1F2E);
  static const Color studyColor = Color(0xFF6366F1);
  static const Color fitnessColor = Color(0xFFEC4899);
  static const Color brandColor = Color(0xFFFBBF24);
  static const Color confidenceColor = Color(0xFF8B5CF6);
  
  // Dracula Colors
  static const Color draculaBackground = Color(0xFF282a36);
  static const Color draculaCurrentLine = Color(0xFF44475a);
  static const Color draculaForeground = Color(0xFFf8f8f2);
  static const Color draculaComment = Color(0xFF6272a4);
  static const Color draculaCyan = Color(0xFF8be9fd);
  static const Color draculaGreen = Color(0xFF50fa7b);
  static const Color draculaOrange = Color(0xFFffb86c);
  static const Color draculaPink = Color(0xFFff79c6);
  static const Color draculaPurple = Color(0xFFbd93f9);
  static const Color draculaRed = Color(0xFFff5555);
  static const Color draculaYellow = Color(0xFFf1fa8c);

  static ThemeData getLightTheme() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: ColorScheme.light(
        primary: lightAccent,
        secondary: lightTimberwolf,
        surface: lightWhite,
        background: lightBackground,
      ),
      scaffoldBackgroundColor: lightBackground,
      
      textTheme: GoogleFonts.interTextTheme().copyWith(
        displayLarge: GoogleFonts.montserrat(fontSize: 32, fontWeight: FontWeight.bold, color: lightDarkGrey),
        displayMedium: GoogleFonts.montserrat(fontSize: 24, fontWeight: FontWeight.bold, color: lightDarkGrey),
        displaySmall: GoogleFonts.montserrat(fontSize: 20, fontWeight: FontWeight.w600, color: lightDarkGrey),
        headlineMedium: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.w600, color: lightDarkGrey),
        bodyLarge: GoogleFonts.inter(fontSize: 16, color: lightDarkGrey),
        bodyMedium: GoogleFonts.inter(fontSize: 14, color: lightGrey),
        labelLarge: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w500, color: lightAccent),
      ),
      
      appBarTheme: AppBarTheme(
        backgroundColor: lightWhite,
        foregroundColor: lightDarkGrey,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: GoogleFonts.montserrat(fontSize: 20, fontWeight: FontWeight.bold, color: lightDarkGrey),
        iconTheme: IconThemeData(color: lightAccent),
      ),
      
      cardTheme: CardThemeData(
        color: lightCardBg,
        elevation: 2,
        shadowColor: Colors.black12,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: lightWhite,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: lightGrey)),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: lightAccent, width: 2)),
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        hintStyle: GoogleFonts.inter(color: lightGrey, fontSize: 14),
      ),
      
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: lightAccent,
          foregroundColor: lightWhite,
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          textStyle: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),
      
      checkboxTheme: CheckboxThemeData(
        fillColor: MaterialStateProperty.resolveWith((states) => states.contains(MaterialState.selected) ? lightAccent : lightGrey.withOpacity(0.3)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      ),
      
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: lightWhite,
        selectedItemColor: lightAccent,
        unselectedItemColor: lightGrey,
        type: BottomNavigationBarType.fixed,
        elevation: 8,
      ),
    );
  }

  static ThemeData getDarkTheme() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: darkBackground,
      primaryColor: primaryTeal,
      colorScheme: ColorScheme.dark(
        primary: primaryTeal,
        secondary: studyColor,
        surface: cardBackground,
        background: darkBackground,
      ),
      
      textTheme: TextTheme(
        displayLarge: GoogleFonts.montserrat(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white),
        displayMedium: GoogleFonts.montserrat(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
        displaySmall: GoogleFonts.montserrat(fontSize: 20, fontWeight: FontWeight.w600, color: Colors.white),
        headlineMedium: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.white),
        bodyLarge: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.normal, color: Colors.white70),
        bodyMedium: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.normal, color: Colors.white60),
        labelLarge: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w500, color: primaryTeal),
      ),
      
      cardTheme: CardThemeData(
        color: cardBackground,
        elevation: 4,
        shadowColor: Colors.black45,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      
      appBarTheme: AppBarTheme(
        backgroundColor: darkBackground,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: GoogleFonts.montserrat(fontSize: 20, fontWeight: FontWeight.bold, color: primaryTeal),
        iconTheme: IconThemeData(color: primaryTeal),
      ),
      
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: cardBackground,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: primaryTeal, width: 2)),
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        hintStyle: GoogleFonts.inter(color: Colors.white38, fontSize: 14),
      ),
      
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryTeal,
          foregroundColor: darkBackground,
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          textStyle: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),
      
      checkboxTheme: CheckboxThemeData(
        fillColor: MaterialStateProperty.resolveWith((states) => states.contains(MaterialState.selected) ? primaryTeal : Colors.white24),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      ),
      
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: cardBackground,
        selectedItemColor: primaryTeal,
        unselectedItemColor: Colors.white38,
        type: BottomNavigationBarType.fixed,
        elevation: 8,
      ),
    );
  }

  static ThemeData getDraculaTheme() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: draculaBackground,
      primaryColor: draculaPurple,
      colorScheme: ColorScheme.dark(
        primary: draculaPurple,
        secondary: draculaPink,
        surface: draculaCurrentLine,
        background: draculaBackground,
      ),
      
      textTheme: TextTheme(
        displayLarge: GoogleFonts.montserrat(fontSize: 32, fontWeight: FontWeight.bold, color: draculaForeground),
        displayMedium: GoogleFonts.montserrat(fontSize: 24, fontWeight: FontWeight.bold, color: draculaForeground),
        displaySmall: GoogleFonts.montserrat(fontSize: 20, fontWeight: FontWeight.w600, color: draculaForeground),
        headlineMedium: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.w600, color: draculaForeground),
        bodyLarge: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.normal, color: draculaForeground),
        bodyMedium: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.normal, color: draculaComment),
        labelLarge: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w500, color: draculaPurple),
      ),
      
      cardTheme: CardThemeData(
        color: draculaCurrentLine,
        elevation: 4,
        shadowColor: Colors.black54,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      
      appBarTheme: AppBarTheme(
        backgroundColor: draculaBackground,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: GoogleFonts.montserrat(fontSize: 20, fontWeight: FontWeight.bold, color: draculaPurple),
        iconTheme: IconThemeData(color: draculaPurple),
      ),
      
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: draculaCurrentLine,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: draculaPurple, width: 2)),
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        hintStyle: GoogleFonts.inter(color: draculaComment, fontSize: 14),
      ),
      
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: draculaPurple,
          foregroundColor: draculaBackground,
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          textStyle: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),
      
      checkboxTheme: CheckboxThemeData(
        fillColor: MaterialStateProperty.resolveWith((states) => states.contains(MaterialState.selected) ? draculaPurple : draculaComment.withOpacity(0.3)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      ),
      
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: draculaCurrentLine,
        selectedItemColor: draculaPurple,
        unselectedItemColor: draculaComment,
        type: BottomNavigationBarType.fixed,
        elevation: 8,
      ),
    );
  }
  
  // Helper methods for context-aware colors
  static Color getStudyColor(AppThemeMode mode) {
    switch (mode) {
      case AppThemeMode.light: return Color(0xFF5E35B1);
      case AppThemeMode.dark: return studyColor;
      case AppThemeMode.dracula: return draculaPurple;
    }
  }
  
  static Color getFitnessColor(AppThemeMode mode) {
    switch (mode) {
      case AppThemeMode.light: return Color(0xFFD81B60);
      case AppThemeMode.dark: return fitnessColor;
      case AppThemeMode.dracula: return draculaPink;
    }
  }
  
  static Color getBrandColor(AppThemeMode mode) {
    switch (mode) {
      case AppThemeMode.light: return Color(0xFFFFA000);
      case AppThemeMode.dark: return brandColor;
      case AppThemeMode.dracula: return draculaYellow;
    }
  }
  
  static Color getConfidenceColor(AppThemeMode mode) {
    switch (mode) {
      case AppThemeMode.light: return Color(0xFF7E57C2);
      case AppThemeMode.dark: return confidenceColor;
      case AppThemeMode.dracula: return draculaCyan;
    }
  }
  
  static ThemeData getTheme(AppThemeMode mode) {
    switch (mode) {
      case AppThemeMode.light: return getLightTheme();
      case AppThemeMode.dark: return getDarkTheme();
      case AppThemeMode.dracula: return getDraculaTheme();
    }
  }
}
