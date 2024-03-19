import 'package:flutter/material.dart';
import 'package:m3m_tennis_booking/utils/app_dimensions.dart';

class AppTheme {
  static const myColorScheme = ColorScheme(
    primary: Color(0xFF58E967),
    secondary: Color.fromARGB(255, 45, 49, 54),
    surface: Colors.white,
    background: Colors.black,
    error: Colors.red,
    onPrimary: Colors.white,
    onSecondary: Colors.white,
    onSurface: Colors.black,
    onBackground: Colors.black,
    onError: Colors.white,
    brightness: Brightness.dark,
  );

  static const backgroundColor = LinearGradient(
    colors: [
      Colors.black,
      Colors.grey,
    ],
  );

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: myColorScheme,
      canvasColor: Colors.white,
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.black,
      ),
      bottomSheetTheme: const BottomSheetThemeData(
        surfaceTintColor: Colors.white,
        backgroundColor: Colors.white,
      ),

      buttonTheme: ButtonThemeData(
        buttonColor: myColorScheme.primary,
        textTheme: ButtonTextTheme.primary,
      ),
      dialogBackgroundColor: Colors.black,
      scaffoldBackgroundColor: Colors.black,
      dialogTheme: const DialogTheme(
        backgroundColor: Colors.black,
        surfaceTintColor: Colors.black,
      ),

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.all(12),
          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Colors.grey),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppDimension.normalRadius * 3),
          ),
          side: const BorderSide(
            color: Colors.grey,
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          padding: EdgeInsets.zero,
          visualDensity: VisualDensity.compact,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          textStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: Colors.black),
          backgroundColor: myColorScheme.primary,
          //padding: EdgeInsets.all(8),
          // padding: const EdgeInsets.symmetric(
          //   vertical: AppDimension.normalPadding - 8.0,
          //   horizontal: AppDimension.normalPadding,
          // ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppDimension.normalRadius / 2),
          ),
        ),
      ),

      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: myColorScheme.primary,
      ),

      // timePickerTheme: TimePickerThemeData(),
      fontFamily: "Quicksand",
      textTheme: TextTheme(
        displayLarge: const TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 32,
          height: 64 / 57,
          letterSpacing: -0.25,
        ),
        displayMedium: const TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 24,
          height: 52 / 45,
        ),
        displaySmall: const TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 18,
          height: 44 / 36,
        ),
        headlineLarge: const TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 32,
          height: 40 / 32,
        ),
        headlineMedium: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24, color: Colors.white),
        headlineSmall: const TextStyle(fontWeight: FontWeight.w700, fontSize: 22, height: 32 / 24, color: Colors.grey),
        titleLarge: TextStyle(fontWeight: FontWeight.w400, fontSize: 18, height: 28 / 22, color: myColorScheme.primary),
        titleMedium: const TextStyle(fontWeight: FontWeight.w700, fontSize: 18, height: 24 / 16, letterSpacing: 0.1, color: Colors.white),
        titleSmall: const TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 16,
          height: 20 / 14,
          letterSpacing: 0.1,
        ),
        labelLarge: const TextStyle(fontWeight: FontWeight.w700, fontSize: 17, color: Colors.grey),
        labelMedium: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16, color: Colors.grey),
        labelSmall: const TextStyle(fontWeight: FontWeight.w400, fontSize: 14, color: Colors.grey),
        bodyLarge: const TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 18,
          height: 26 / 18,
          color: Colors.white,
        ),
        bodyMedium: const TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 16,
          height: 22 / 16,
          color: Colors.grey,
        ),
        bodySmall: const TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 14,
          height: 18 / 14,
          color: Colors.white,
        ),
      ),
    );
  }
}
