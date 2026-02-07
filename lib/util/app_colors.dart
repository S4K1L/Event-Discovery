import 'package:flutter/material.dart';

class AppColors {
  // Basic
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);

  // ===================== BLUE =====================
  static const Map<int, Color> blue = {
    25: Color(0xFFEFF6FF),
    50: Color(0xFFD8EAFE),
    100: Color(0xFFBFD8FE),
    200: Color(0xFF93C5FD),
    300: Color(0xFF60A5FA),
    400: Color(0xFF3B82F6),
    500: Color(0xFF2563EB),
    600: Color(0xFF1D4ED8),
    700: Color(0xFF1E40AF),
    800: Color(0xFF153A8A),
    900: Color(0xFF172554),
  };

  // ===================== GREEN =====================
  static const Map<int, Color> green = {
    25: Color(0xFFF0FDF4),
    50: Color(0xFFDCFCE7),
    100: Color(0xFFBBF7D0),
    200: Color(0xFF86EFAC),
    300: Color(0xFF4ADE80),
    400: Color(0xFF22C55E),
    500: Color(0xFF16A34A),
    600: Color(0xFF15803D),
    700: Color(0xFF166534),
    800: Color(0xFF14532D),
    900: Color(0xFF052E16),
  };

  // ===================== YELLOW / AMBER =====================
  static const Map<int, Color> yellow = {
    25: Color(0xFFFFFECB),
    50: Color(0xFFFFF9C3),
    100: Color(0xFFFFF08A),
    200: Color(0xFFFDE047),
    300: Color(0xFFFACC15),
    400: Color(0xFFEAB308),
    500: Color(0xFFCA8A04),
    600: Color(0xFFA16207),
    700: Color(0xFF854D0E),
    800: Color(0xFF713F12),
    900: Color(0xFF422006),
  };

  // ===================== RED =====================
  static const Map<int, Color> red = {
    25: Color(0xFFFFF2F2),
    50: Color(0xFFFEE2E2),
    100: Color(0xFFFECACA),
    200: Color(0xFFFCA5A5),
    300: Color(0xFFF87171),
    400: Color(0xFFEF4444),
    500: Color(0xFFDC2626),
    600: Color(0xFFB91C1C),
    700: Color(0xFF991B1B),
    800: Color(0xFF7F1D1D),
    900: Color(0xFF450A0A),
  };

  // ===================== GRAY =====================
  static const Map<int, Color> grey = {
    25: Color(0xFFF9FAFB),
    50: Color(0xFFF3F4F6),
    100: Color(0xFFE5E7EB),
    200: Color(0xFFD1D5DB),
    300: Color(0xFF9CA3AF),
    400: Color(0xFF6B7280),
    500: Color(0xFF4B5563),
    600: Color(0xFF374151),
    700: Color(0xFF1F2937),
    800: Color(0xFF111827),
    900: Color(0xFF030712),
  };

  // ===================== SEMANTIC USAGE =====================
  static Color get primary => blue[500]!;
  static Color get primaryLight => blue[100]!;
  static Color get primaryDark => blue[700]!;

  static Color get success => green[500]!;
  static Color get warning => yellow[400]!;
  static Color get error => red[500]!;

  static Color get background => blue[25]!;
  static Color get surface => white;
  static Color get border => grey[200]!;

  static Color get textPrimary => grey[900]!;
  static Color get textSecondary => grey[600]!;
  static Color get hint => grey[400]!;

  static const BoxShadow cardShadow = BoxShadow(
    color: Color(0x1A000000),
    blurRadius: 8,
    offset: Offset(0, 4),
  );
}
