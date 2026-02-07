import 'package:flutter/material.dart';

class AppTextStyles {
  // ---------- Helpers ----------
  static double _lh(double lineHeight, double fontSize) =>
      lineHeight / fontSize;

  static double _tracking(double fontSize) => fontSize * -0.02;

  // Font weights mapping
  static const FontWeight regular = FontWeight.w400;
  static const FontWeight medium = FontWeight.w500;
  static const FontWeight semibold = FontWeight.w600;

  // ---------- DISPLAY 2XL (72 / 88 / -2%) ----------
  static TextStyle display2xl({Color? color, FontWeight? weight}) => TextStyle(
    fontSize: 72,
    height: _lh(88, 72),
    letterSpacing: _tracking(72),
    fontWeight: weight ?? regular,
    color: color,
  );

  // ---------- DISPLAY XL (60 / 72 / -2%) ----------
  static TextStyle displayXl({Color? color, FontWeight? weight}) => TextStyle(
    fontSize: 60,
    height: _lh(72, 60),
    letterSpacing: _tracking(60),
    fontWeight: weight ?? regular,
    color: color,
  );

  // ---------- DISPLAY LG (48 / 60 / -2%) ----------
  static TextStyle displayLg({Color? color, FontWeight? weight}) => TextStyle(
    fontSize: 48,
    height: _lh(60, 48),
    letterSpacing: _tracking(48),
    fontWeight: weight ?? regular,
    color: color,
  );

  // ---------- DISPLAY MD (36 / 44 / -2%) ----------
  static TextStyle displayMd({Color? color, FontWeight? weight}) => TextStyle(
    fontSize: 36,
    height: _lh(44, 36),
    letterSpacing: _tracking(36),
    fontWeight: weight ?? regular,
    color: color,
  );

  // ---------- DISPLAY SM (30 / 36) ----------
  static TextStyle display30({Color? color, FontWeight? weight}) => TextStyle(
    fontSize: 30,
    height: _lh(36, 30),
    fontWeight: weight ?? regular,
    color: color,
  );

  // ---------- DISPLAY XS (24 / 32) ----------
  static TextStyle display24({Color? color, FontWeight? weight}) => TextStyle(
    fontSize: 24,
    height: _lh(32, 24),
    fontWeight: weight ?? regular,
    color: color,
  );

  // ---------- TEXT XL (20 / 30) ----------
  static TextStyle text20({Color? color, FontWeight? weight}) => TextStyle(
    fontSize: 20,
    height: _lh(30, 20),
    fontWeight: weight ?? regular,
    color: color,
  );

  // ---------- TEXT LG (18 / 28) ----------
  static TextStyle text18({Color? color, FontWeight? weight}) => TextStyle(
    fontSize: 18,
    height: _lh(28, 18),
    fontWeight: weight ?? regular,
    color: color,
  );

  // ---------- TEXT MD (16 / 24) ----------
  static TextStyle text16({Color? color, FontWeight? weight}) => TextStyle(
    fontSize: 16,
    height: _lh(24, 16),
    fontWeight: weight ?? regular,
    color: color,
  );

  // ---------- TEXT SM (14 / 20) ----------
  static TextStyle text14({Color? color, FontWeight? weight}) => TextStyle(
    fontSize: 14,
    height: _lh(20, 14),
    fontWeight: weight ?? regular,
    color: color,
  );

  // ---------- TEXT XS (12 / 18) ----------
  static TextStyle text12({Color? color, FontWeight? weight}) => TextStyle(
    fontSize: 12,
    height: _lh(18, 12),
    fontWeight: weight ?? regular,
    color: color,
  );
}
