import 'package:flutter/material.dart';

/// Spotless Office Solutions - Executive Brand Palette
/// Primary: Obsidian Black | Secondary: Metallic Silver | Accent: Imperial Gold
class AppColors {
  // 1. Primary Brand: Obsidian & Onyx Black
  static const Color primary = Color(0xFF12151A);        // Rich Onyx Black
  static const Color primaryLight = Color(0xFF232730);   // Charcoal Slate Black
  static const Color primaryDark = Color(0xFF090A0D);    // Deep Obsidian Jet Black

  // 2. Secondary Brand: Metallic Silver & Platinum
  static const Color silver = Color(0xFFCBD5E1);         // Metallic Silver
  static const Color silverLight = Color(0xFFF1F5F9);    // Polished Light Platinum
  static const Color silverDark = Color(0xFF94A3B8);     // Brushed Chrome Steel
  static const Color silverBorder = Color(0xFFE2E8F0);   // Crisp Silver Border

  // 3. 3rd Brand Accent: Imperial Metallic Gold
  static const Color accent = Color(0xFFD4AF37);         // Imperial Metallic Gold
  static const Color accentLight = Color(0xFFFCD34D);    // Radiant Warm Gold
  static const Color accentDark = Color(0xFFB48A1E);     // Deep Burnished Gold

  // Background & Surface
  static const Color background = Color(0xFFF8FAFC);     // Clean Platinum Off-White
  static const Color surface = Color(0xFFFFFFFF);        // Crisp Card White
  static const Color surfaceElevated = Color(0xFFF1F5F9);// Elevated Silver/Platinum Card
  static const Color surfaceDark = Color(0xFF1A1D24);    // Executive Dark Card

  // Text Hierarchy
  static const Color textPrimary = Color(0xFF0F172A);    // Rich Slate/Black 900
  static const Color textSecondary = Color(0xFF475569);  // Charcoal 600
  static const Color textMuted = Color(0xFF94A3B8);      // Muted Silver 400
  static const Color textInverse = Color(0xFFFFFFFF);

  // Status & Profitability Badges
  static const Color success = Color(0xFF10B981);        // Emerald Green (Healthy Margin)
  static const Color successBackground = Color(0xFFD1FAE5);
  static const Color warning = Color(0xFFD4AF37);        // Gold/Amber (Low Margin Alert)
  static const Color warningBackground = Color(0xFFFEF3C7);
  static const Color error = Color(0xFFEF4444);          // Crimson Red (Unprofitable / Deficit)
  static const Color errorBackground = Color(0xFFFEE2E2);
  static const Color info = Color(0xFF3B82F6);
  static const Color infoBackground = Color(0xFFDBEAFE);

  // Borders and Dividers
  static const Color border = Color(0xFFE2E8F0);
  static const Color borderFocused = Color(0xFFD4AF37);  // Gold Focus Border
}
