import 'package:finplus/styles/text_define.dart';
import 'package:flutter/material.dart';

const lightColorScheme = ColorScheme(
  brightness: Brightness.light,
  primary: Color(0xFF244EE1),
  onPrimary: Color(0xFFFFFFFF),
  primaryContainer: Color(0xFFDDE1FF),
  onPrimaryContainer: Color(0xFF001355),
  secondary: Color(0xFF5A5D72),
  onSecondary: Color(0xFFFFFFFF),
  secondaryContainer: Color(0xFFDFE1F9),
  onSecondaryContainer: Color(0xFF171B2C),
  tertiary: Color(0xFF76546E),
  onTertiary: Color(0xFFFFFFFF),
  tertiaryContainer: Color(0xFFFFD7F3),
  onTertiaryContainer: Color(0xFF2C1229),
  error: Color(0xFFBA1A1A),
  errorContainer: Color(0xFFFFDAD6),
  onError: Color(0xFFFFFFFF),
  onErrorContainer: Color(0xFF410002),
  background: Color(0xFFFFFBFF),
  onBackground: Color(0xFF1B1B1F),
  surface: Color(0xFFFFFBFF),
  onSurface: Color(0xFF1B1B1F),
  surfaceVariant: Color(0xFFE2E1EC),
  onSurfaceVariant: Color(0xFF45464F),
  outline: Color(0xFF767680),
  onInverseSurface: Color(0xFFF3F0F4),
  inverseSurface: Color(0xFF303034),
  inversePrimary: Color(0xFFB8C3FF),
  shadow: Color(0xFF000000),
  surfaceTint: Color(0xFF244EE1),
  outlineVariant: Color(0xFFC6C6D0),
  scrim: Color(0xFF000000),
);

const darkColorScheme = ColorScheme(
  brightness: Brightness.dark,
  primary: Color(0xFFB8C3FF),
  onPrimary: Color(0xFF002387),
  primaryContainer: Color(0xFF0035BD),
  onPrimaryContainer: Color(0xFFDDE1FF),
  secondary: Color(0xFFC3C5DD),
  onSecondary: Color(0xFF2C2F42),
  secondaryContainer: Color(0xFF424659),
  onSecondaryContainer: Color(0xFFDFE1F9),
  tertiary: Color(0xFFE4BAD9),
  onTertiary: Color(0xFF44273E),
  tertiaryContainer: Color(0xFF5C3D56),
  onTertiaryContainer: Color(0xFFFFD7F3),
  error: Color(0xFFFFB4AB),
  errorContainer: Color(0xFF93000A),
  onError: Color(0xFF690005),
  onErrorContainer: Color(0xFFFFDAD6),
  background: Color(0xFF1B1B1F),
  onBackground: Color(0xFFE4E1E6),
  surface: Color(0xFF1B1B1F),
  onSurface: Color(0xFFC8C5CA),
  surfaceVariant: Color(0xFF45464F),
  onSurfaceVariant: Color(0xFFC6C6D0),
  outline: Color(0xFF8F909A),
  onInverseSurface: Color(0xFF1B1B1F),
  inverseSurface: Color(0xFFE4E1E6),
  inversePrimary: Color(0xFF244EE1),
  shadow: Color(0xFF000000),
  surfaceTint: Color(0xFFB8C3FF),
  outlineVariant: Color(0xFF45464F),
  scrim: Color(0xFF000000),
);

class StyleConfigs {
  static final dark = ThemeData(
    useMaterial3: true,
    colorScheme: darkColorScheme,
    dividerColor: const Color(0xff1d1f29),
    textTheme: TextTheme(
      bodyMedium: TextDefine.P2_R.copyWith(color: const Color(0xffffffff)),
    ),
  );

  static final light = ThemeData(
    useMaterial3: true,
    colorScheme: lightColorScheme,
  );
}
