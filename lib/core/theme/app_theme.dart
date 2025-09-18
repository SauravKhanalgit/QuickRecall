import 'package:flutter/material.dart';

class AppTheme {
  static final lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorScheme: const ColorScheme.light(
      primary: Color(0xFF006874),
      onPrimary: Color(0xFFFFFFFF),
      primaryContainer: Color(0xFF97F0FF),
      onPrimaryContainer: Color(0xFF001F24),
      secondary: Color(0xFF4A6267),
      onSecondary: Color(0xFFFFFFFF),
      secondaryContainer: Color(0xFFCDE7EC),
      onSecondaryContainer: Color(0xFF051F23),
      tertiary: Color(0xFF525E7D),
      onTertiary: Color(0xFFFFFFFF),
      tertiaryContainer: Color(0xFFDAE2FF),
      onTertiaryContainer: Color(0xFF0E1B37),
      error: Color(0xFFBA1A1A),
      onError: Color(0xFFFFFFFF),
      errorContainer: Color(0xFFFFDAD6),
      onErrorContainer: Color(0xFF410002),
      surface: Color(0xFFFAFDFD),
      onSurface: Color(0xFF191C1D),
      surfaceContainerHighest: Color(0xFFDBE4E6),
      onSurfaceVariant: Color(0xFF3F484A),
      outline: Color(0xFF6F797A),
      shadow: Color(0xFF000000),
      inverseSurface: Color(0xFF2E3132),
      onInverseSurface: Color(0xFFEFF1F1),
      inversePrimary: Color(0xFF4FD8EB),
    ),
    appBarTheme: const AppBarTheme(
      centerTitle: true,
      elevation: 0,
      scrolledUnderElevation: 2,
      surfaceTintColor: Colors.transparent,
    ),

    textTheme: const TextTheme(
      displayLarge: TextStyle(
        fontWeight: FontWeight.w800,
        fontSize: 57,
        height: 1.12,
        letterSpacing: -0.25,
      ),
      displayMedium: TextStyle(
        fontWeight: FontWeight.w700,
        fontSize: 45,
        height: 1.15,
      ),
      displaySmall: TextStyle(
        fontWeight: FontWeight.w700,
        fontSize: 36,
        height: 1.22,
      ),
      headlineLarge: TextStyle(
        fontWeight: FontWeight.w700,
        fontSize: 32,
        height: 1.25,
      ),
      headlineMedium: TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 28,
        height: 1.28,
      ),
      headlineSmall: TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 24,
        height: 1.33,
      ),
      titleLarge: TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 22,
        height: 1.27,
      ),
      titleMedium: TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 16,
        height: 1.5,
        letterSpacing: 0.15,
      ),
      titleSmall: TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 14,
        height: 1.42,
        letterSpacing: 0.1,
      ),
      bodyLarge: TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 16,
        height: 1.5,
        letterSpacing: 0.15,
      ),
      bodyMedium: TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 14,
        height: 1.42,
        letterSpacing: 0.25,
      ),
      bodySmall: TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 12,
        height: 1.33,
        letterSpacing: 0.4,
      ),
      labelLarge: TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 14,
        height: 1.42,
        letterSpacing: 0.1,
      ),
      labelMedium: TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 12,
        height: 1.33,
        letterSpacing: 0.5,
      ),
      labelSmall: TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 11,
        height: 1.45,
        letterSpacing: 0.5,
      ),
    ),
  );

  static final darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: const ColorScheme.dark(
      primary: Color(0xFF4FD8EB),
      onPrimary: Color(0xFF00363D),
      primaryContainer: Color(0xFF004F58),
      onPrimaryContainer: Color(0xFF97F0FF),
      secondary: Color(0xFFB1CBD0),
      onSecondary: Color(0xFF1C3438),
      secondaryContainer: Color(0xFF334B4F),
      onSecondaryContainer: Color(0xFFCDE7EC),
      tertiary: Color(0xFFBAC6EA),
      onTertiary: Color(0xFF24304D),
      tertiaryContainer: Color(0xFF3B4664),
      onTertiaryContainer: Color(0xFFDAE2FF),
      error: Color(0xFFFFB4AB),
      onError: Color(0xFF690005),
      errorContainer: Color(0xFF93000A),
      onErrorContainer: Color(0xFFFFDAD6),
      surface: Color(0xFF191C1D),
      onSurface: Color(0xFFE1E3E3),
      surfaceContainerHighest: Color(0xFF3F484A),
      onSurfaceVariant: Color(0xFFBFC8CA),
      outline: Color(0xFF899294),
      shadow: Color(0xFF000000),
      inverseSurface: Color(0xFFE1E3E3),
      onInverseSurface: Color(0xFF191C1D),
      inversePrimary: Color(0xFF006874),
    ),
    appBarTheme: const AppBarTheme(
      centerTitle: true,
      elevation: 0,
      scrolledUnderElevation: 3,
      surfaceTintColor: Colors.transparent,
    ),

    textTheme: TextTheme(
      displayLarge: lightTheme.textTheme.displayLarge!.copyWith(
        color: const Color(0xFFE1E3E3),
      ),
      displayMedium: lightTheme.textTheme.displayMedium!.copyWith(
        color: const Color(0xFFE1E3E3),
      ),
      displaySmall: lightTheme.textTheme.displaySmall!.copyWith(
        color: const Color(0xFFE1E3E3),
      ),
      headlineLarge: lightTheme.textTheme.headlineLarge!.copyWith(
        color: const Color(0xFFE1E3E3),
      ),
      headlineMedium: lightTheme.textTheme.headlineMedium!.copyWith(
        color: const Color(0xFFE1E3E3),
      ),
      headlineSmall: lightTheme.textTheme.headlineSmall!.copyWith(
        color: const Color(0xFFE1E3E3),
      ),
      titleLarge: lightTheme.textTheme.titleLarge!.copyWith(
        color: const Color(0xFFE1E3E3),
      ),
      titleMedium: lightTheme.textTheme.titleMedium!.copyWith(
        color: const Color(0xFFE1E3E3),
      ),
      titleSmall: lightTheme.textTheme.titleSmall!.copyWith(
        color: const Color(0xFFE1E3E3),
      ),
      bodyLarge: lightTheme.textTheme.bodyLarge!.copyWith(
        color: const Color(0xFFC5C7C7),
      ),
      bodyMedium: lightTheme.textTheme.bodyMedium!.copyWith(
        color: const Color(0xFFC5C7C7),
      ),
      bodySmall: lightTheme.textTheme.bodySmall!.copyWith(
        color: const Color(0xFFC5C7C7),
      ),
      labelLarge: lightTheme.textTheme.labelLarge!.copyWith(
        color: const Color(0xFFE1E3E3),
      ),
      labelMedium: lightTheme.textTheme.labelMedium!.copyWith(
        color: const Color(0xFFE1E3E3),
      ),
      labelSmall: lightTheme.textTheme.labelSmall!.copyWith(
        color: const Color(0xFFE1E3E3),
      ),
    ),
  );
}
