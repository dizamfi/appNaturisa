import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._(); // Constructor privado para evitar instanciación

  // Colores primarios
  static const Color primaryBlue = Color.fromRGBO(9, 31, 72, 1);
  static const Color accentBlue = Color.fromRGBO(0, 102, 204, 1);

  // Colores neutrales
  static const Color lightGray = Color.fromRGBO(248, 249, 252, 1);
  static const Color mediumGray = Color.fromRGBO(232, 234, 240, 1);
  static const Color textDark = Color.fromRGBO(25, 30, 40, 1);

  // Colores específicos para UI
  static Color shadowColor = Colors.black.withOpacity(0.07);
  static Color borderColor = mediumGray.withOpacity(0.6);

  // ThemeData para usar en toda la app
  static ThemeData get lightTheme {
    return ThemeData(
      primaryColor: primaryBlue,
      colorScheme: ColorScheme.light(
        primary: primaryBlue,
        secondary: accentBlue,
        surface: Colors.white,
        background: Colors.white,
        error: Colors.red,
      ),
      scaffoldBackgroundColor: Colors.white,
      appBarTheme: const AppBarTheme(
        color: primaryBlue,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      textTheme: const TextTheme(
        // Define tus estilos de texto aquí
        titleLarge: TextStyle(
          color: primaryBlue,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
        bodyMedium: TextStyle(
          color: textDark,
          fontSize: 15,
          fontWeight: FontWeight.w500,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: primaryBlue,
          elevation: 1,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.symmetric(vertical: 12),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: lightGray,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: mediumGray),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: mediumGray),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: accentBlue),
        ),
        labelStyle: TextStyle(
          color: textDark.withOpacity(0.6),
          fontSize: 14,
        ),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 12,
          horizontal: 16,
        ),
      ),
    );
  }
}
