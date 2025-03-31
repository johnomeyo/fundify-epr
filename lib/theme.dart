import "package:flutter/material.dart";

class FlowTheme {
  final TextTheme textTheme;

  const FlowTheme(this.textTheme);

  static ColorScheme lightScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff2962ff),           // Flow blue
      surfaceTint: Color(0x002962ff),       // Light tint of primary
      onPrimary: Color(0xffffffff),         // White text on primary
      primaryContainer: Color(0xffd8e6ff),  // Light blue container
      onPrimaryContainer: Color(0xff00174f), // Dark blue text on container
      secondary: Color(0xff6c63ff),         // Secondary purple
      onSecondary: Color(0xffffffff),       // White text on secondary
      secondaryContainer: Color(0xffe6e0ff), // Light purple container
      onSecondaryContainer: Color(0xff1d0099), // Dark purple text on container
      tertiary: Color(0xff00b8d4),          // Accent cyan
      onTertiary: Color(0xffffffff),        // White text on tertiary
      tertiaryContainer: Color(0xffcefaff), // Light cyan container
      onTertiaryContainer: Color(0xff004e58), // Dark cyan text on container
      error: Color(0xffb00020),             // Standard error red
      onError: Color(0xffffffff),           // White text on error
      errorContainer: Color(0xfffde8e8),    // Light red container
      onErrorContainer: Color(0xff410002),  // Dark red text on container
      surface: Color(0xfff8f9fa),           // Light surface
      onSurface: Color(0xff121212),         // Dark text on surface
      onSurfaceVariant: Color(0xff494949),  // Variant text on surface
      outline: Color(0xff79747e),           // Standard outline
      outlineVariant: Color(0xffc9c5d0),    // Variant outline
      shadow: Color(0xff000000),            // Shadow
      scrim: Color(0xff000000),             // Scrim
      inverseSurface: Color(0xff303030),    // Dark inverse surface
      inversePrimary: Color(0xff82b1ff),    // Light blue on dark surface
      primaryFixed: Color(0xffd8e6ff),      // Fixed primary container
      onPrimaryFixed: Color(0xff00174f),    // Fixed text on primary container
      primaryFixedDim: Color(0xffadc7ff),   // Dimmed primary container
      onPrimaryFixedVariant: Color(0xff0044c1), // Variant text on fixed primary
      secondaryFixed: Color(0xffe6e0ff),    // Fixed secondary container
      onSecondaryFixed: Color(0xff1d0099),  // Fixed text on secondary container
      secondaryFixedDim: Color(0xffc9b8ff), // Dimmed secondary container
      onSecondaryFixedVariant: Color(0xff4a3dc9), // Variant text on fixed secondary
      tertiaryFixed: Color(0xffcefaff),     // Fixed tertiary container
      onTertiaryFixed: Color(0xff004e58),   // Fixed text on tertiary container
      tertiaryFixedDim: Color(0xff8defff),  // Dimmed tertiary container
      onTertiaryFixedVariant: Color(0xff0086a4), // Variant text on fixed tertiary
      surfaceDim: Color(0xffe6e6e6),        // Dimmed surface
      surfaceBright: Color(0xfffafafa),     // Bright surface
      surfaceContainerLowest: Color(0xffffffff), // Lowest container surface
      surfaceContainerLow: Color(0xfff3f4f9),    // Low container surface
      surfaceContainer: Color(0xffedf0f8),       // Standard container surface
      surfaceContainerHigh: Color(0xffe7eaf4),   // High container surface
      surfaceContainerHighest: Color(0xffe1e5f0), // Highest container surface
    );
  }

  ThemeData light() {
    return theme(lightScheme());
  }

  static ColorScheme darkScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xff82b1ff),           // Light blue primary
      surfaceTint: Color(0x6682b1ff),       // Tinted primary for dark mode
      onPrimary: Color(0xff00174f),         // Dark blue text on primary
      primaryContainer: Color(0xff0044c1),  // Dark blue container
      onPrimaryContainer: Color(0xffd8e6ff), // Light blue text on container
      secondary: Color(0xffb4a9ff),         // Light purple secondary
      onSecondary: Color(0xff1d0099),       // Dark purple text on secondary
      secondaryContainer: Color(0xff4a3dc9), // Dark purple container
      onSecondaryContainer: Color(0xffe6e0ff), // Light purple text on container
      tertiary: Color(0xff88f7ff),          // Light cyan tertiary
      onTertiary: Color(0xff004e58),        // Dark cyan text on tertiary
      tertiaryContainer: Color(0xff0086a4), // Dark cyan container
      onTertiaryContainer: Color(0xffcefaff), // Light cyan text on container
      error: Color(0xffcf6679),             // Light red error
      onError: Color(0xff410002),           // Dark red text on error
      errorContainer: Color(0xffb00020),    // Dark red container
      onErrorContainer: Color(0xfffde8e8),  // Light red text on container
      surface: Color(0xff121212),           // Dark surface
      onSurface: Color(0xffe0e0e0),         // Light text on surface
      onSurfaceVariant: Color(0xffc9c5d0),  // Variant text on surface
      outline: Color(0xff938f99),           // Standard outline for dark
      outlineVariant: Color(0xff494949),    // Variant outline for dark
      shadow: Color(0xff000000),            // Shadow
      scrim: Color(0xff000000),             // Scrim
      inverseSurface: Color(0xfff5f5f5),    // Light inverse surface
      inversePrimary: Color(0xff2962ff),    // Dark blue on light surface
      primaryFixed: Color(0xffd8e6ff),      // Fixed primary container
      onPrimaryFixed: Color(0xff00174f),    // Fixed text on primary container
      primaryFixedDim: Color(0xffadc7ff),   // Dimmed primary container
      onPrimaryFixedVariant: Color(0xff0044c1), // Variant text on fixed primary
      secondaryFixed: Color(0xffe6e0ff),    // Fixed secondary container
      onSecondaryFixed: Color(0xff1d0099),  // Fixed text on secondary container
      secondaryFixedDim: Color(0xffc9b8ff), // Dimmed secondary container
      onSecondaryFixedVariant: Color(0xff4a3dc9), // Variant text on fixed secondary
      tertiaryFixed: Color(0xffcefaff),     // Fixed tertiary container
      onTertiaryFixed: Color(0xff004e58),   // Fixed text on tertiary container
      tertiaryFixedDim: Color(0xff8defff),  // Dimmed tertiary container
      onTertiaryFixedVariant: Color(0xff0086a4), // Variant text on fixed tertiary
      surfaceDim: Color(0xff121212),        // Dimmed surface
      surfaceBright: Color(0xff373737),     // Bright surface for dark mode
      surfaceContainerLowest: Color(0xff0d0d0d), // Lowest container surface
      surfaceContainerLow: Color(0xff1a1a1a),    // Low container surface
      surfaceContainer: Color(0xff222222),       // Standard container surface
      surfaceContainerHigh: Color(0xff2d2d2d),   // High container surface
      surfaceContainerHighest: Color(0xff383838), // Highest container surface
    );
  }

  ThemeData dark() {
    return theme(darkScheme());
  }

  // Medium contrast light scheme
  static ColorScheme lightMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff0044c1),           // Darker blue for better contrast
      surfaceTint: Color(0x002962ff),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff4a85ff),  // More vibrant container
      onPrimaryContainer: Color(0xffffffff), // White text for contrast
      secondary: Color(0xff4a3dc9),         // Darker purple for contrast
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff6c63ff), // More vibrant container
      onSecondaryContainer: Color(0xffffffff), // White text for contrast
      tertiary: Color(0xff0086a4),          // Darker cyan for contrast
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff00b8d4), // More vibrant container
      onTertiaryContainer: Color(0xffffffff), // White text for contrast
      error: Color(0xff96000b),             // Darker error for contrast
      onError: Color(0xffffffff),
      errorContainer: Color(0xffb00020),    // More vibrant container
      onErrorContainer: Color(0xffffffff),  // White text for contrast
      surface: Color(0xfff8f9fa),
      onSurface: Color(0xff121212),
      onSurfaceVariant: Color(0xff494949),
      outline: Color(0xff5e5e5e),           // Darker outline for contrast
      outlineVariant: Color(0xff7c7c7c),    // Darker variant for contrast
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff303030),
      inversePrimary: Color(0xff82b1ff),
      primaryFixed: Color(0xff4a85ff),      // More vibrant fixed
      onPrimaryFixed: Color(0xffffffff),    // White text for contrast
      primaryFixedDim: Color(0xff2962ff),   // Darker fixed dim
      onPrimaryFixedVariant: Color(0xffffffff), // White text for contrast
      secondaryFixed: Color(0xff6c63ff),    // More vibrant fixed
      onSecondaryFixed: Color(0xffffffff),  // White text for contrast
      secondaryFixedDim: Color(0xff4a3dc9), // Darker fixed dim
      onSecondaryFixedVariant: Color(0xffffffff), // White text for contrast
      tertiaryFixed: Color(0xff00b8d4),     // More vibrant fixed
      onTertiaryFixed: Color(0xffffffff),   // White text for contrast
      tertiaryFixedDim: Color(0xff0086a4),  // Darker fixed dim
      onTertiaryFixedVariant: Color(0xffffffff), // White text for contrast
      surfaceDim: Color(0xffe6e6e6),
      surfaceBright: Color(0xfffafafa),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff3f4f9),
      surfaceContainer: Color(0xffedf0f8),
      surfaceContainerHigh: Color(0xffe7eaf4),
      surfaceContainerHighest: Color(0xffe1e5f0),
    );
  }

  ThemeData lightMediumContrast() {
    return theme(lightMediumContrastScheme());
  }

  // High contrast light scheme
  static ColorScheme lightHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff00174f),           // Very dark blue for highest contrast
      surfaceTint: Color(0x002962ff),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff0044c1),  // Dark container for highest contrast
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff1d0099),         // Very dark purple for highest contrast
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff4a3dc9), // Dark container for highest contrast
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff004e58),          // Very dark cyan for highest contrast
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff0086a4), // Dark container for highest contrast
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff410002),             // Very dark error for highest contrast
      onError: Color(0xffffffff),
      errorContainer: Color(0xff96000b),    // Dark container for highest contrast
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xfff8f9fa),
      onSurface: Color(0xff000000),         // Pure black text for highest contrast
      onSurfaceVariant: Color(0xff000000),  // Pure black text for highest contrast
      outline: Color(0xff000000),           // Pure black outline for highest contrast
      outlineVariant: Color(0xff000000),    // Pure black variant for highest contrast
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff303030),
      inversePrimary: Color(0xffd8e6ff),    // Very light blue for inverse contrast
      primaryFixed: Color(0xff0044c1),      // Dark fixed for highest contrast
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff00174f),   // Very dark fixed dim for highest contrast
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff4a3dc9),    // Dark fixed for highest contrast
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff1d0099), // Very dark fixed dim for highest contrast
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff0086a4),     // Dark fixed for highest contrast
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff004e58),  // Very dark fixed dim for highest contrast
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffe6e6e6),
      surfaceBright: Color(0xfffafafa),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff3f4f9),
      surfaceContainer: Color(0xffedf0f8),
      surfaceContainerHigh: Color(0xffe7eaf4),
      surfaceContainerHighest: Color(0xffe1e5f0),
    );
  }

  ThemeData lightHighContrast() {
    return theme(lightHighContrastScheme());
  }

  // Medium contrast dark scheme
  static ColorScheme darkMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffadc7ff),           // Brighter blue for better contrast
      surfaceTint: Color(0x6682b1ff),
      onPrimary: Color(0xff00174f),
      primaryContainer: Color(0xff4a85ff),  // More vibrant container for contrast
      onPrimaryContainer: Color(0xff000000), // Black text for contrast
      secondary: Color(0xffc9b8ff),         // Brighter purple for better contrast
      onSecondary: Color(0xff1d0099),
      secondaryContainer: Color(0xff6c63ff), // More vibrant container for contrast
      onSecondaryContainer: Color(0xff000000), // Black text for contrast
      tertiary: Color(0xff8defff),          // Brighter cyan for better contrast
      onTertiary: Color(0xff004e58),
      tertiaryContainer: Color(0xff00b8d4), // More vibrant container for contrast
      onTertiaryContainer: Color(0xff000000), // Black text for contrast
      error: Color(0xffffb3b3),             // Brighter error for better contrast
      onError: Color(0xff410002),
      errorContainer: Color(0xffcf6679),    // More vibrant container for contrast
      onErrorContainer: Color(0xff000000),  // Black text for contrast
      surface: Color(0xff121212),
      onSurface: Color(0xfff5f5f5),         // Brighter text for better contrast
      onSurfaceVariant: Color(0xffe0e0e0),  // Brighter variant for better contrast
      outline: Color(0xffb0b0b0),           // Brighter outline for better contrast
      outlineVariant: Color(0xffa0a0a0),    // Brighter variant for better contrast
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xfff5f5f5),
      inversePrimary: Color(0xff0044c1),
      primaryFixed: Color(0xffadc7ff),      // Brighter fixed for better contrast
      onPrimaryFixed: Color(0xff00174f),
      primaryFixedDim: Color(0xff82b1ff),   // Dimmed but still contrasting
      onPrimaryFixedVariant: Color(0xff0044c1),
      secondaryFixed: Color(0xffc9b8ff),    // Brighter fixed for better contrast
      onSecondaryFixed: Color(0xff1d0099),
      secondaryFixedDim: Color(0xffb4a9ff), // Dimmed but still contrasting
      onSecondaryFixedVariant: Color(0xff4a3dc9),
      tertiaryFixed: Color(0xff8defff),     // Brighter fixed for better contrast
      onTertiaryFixed: Color(0xff004e58),
      tertiaryFixedDim: Color(0xff88f7ff),  // Dimmed but still contrasting
      onTertiaryFixedVariant: Color(0xff0086a4),
      surfaceDim: Color(0xff121212),
      surfaceBright: Color(0xff373737),
      surfaceContainerLowest: Color(0xff0d0d0d),
      surfaceContainerLow: Color(0xff1a1a1a),
      surfaceContainer: Color(0xff222222),
      surfaceContainerHigh: Color(0xff2d2d2d),
      surfaceContainerHighest: Color(0xff383838),
    );
  }

  ThemeData darkMediumContrast() {
    return theme(darkMediumContrastScheme());
  }

  // High contrast dark scheme
  static ColorScheme darkHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffd8e6ff),           // Very bright blue for highest contrast
      surfaceTint: Color(0x6682b1ff),
      onPrimary: Color(0xff000000),         // Pure black text for highest contrast
      primaryContainer: Color(0xffadc7ff),  // Bright container for highest contrast
      onPrimaryContainer: Color(0xff000000), // Pure black text for highest contrast
      secondary: Color(0xffe6e0ff),         // Very bright purple for highest contrast
      onSecondary: Color(0xff000000),       // Pure black text for highest contrast
      secondaryContainer: Color(0xffc9b8ff), // Bright container for highest contrast
      onSecondaryContainer: Color(0xff000000), // Pure black text for highest contrast
      tertiary: Color(0xffcefaff),          // Very bright cyan for highest contrast
      onTertiary: Color(0xff000000),        // Pure black text for highest contrast
      tertiaryContainer: Color(0xff8defff), // Bright container for highest contrast
      onTertiaryContainer: Color(0xff000000), // Pure black text for highest contrast
      error: Color(0xfffde8e8),             // Very bright error for highest contrast
      onError: Color(0xff000000),           // Pure black text for highest contrast
      errorContainer: Color(0xffffb3b3),    // Bright container for highest contrast
      onErrorContainer: Color(0xff000000),  // Pure black text for highest contrast
      surface: Color(0xff121212),
      onSurface: Color(0xffffffff),         // Pure white text for highest contrast
      onSurfaceVariant: Color(0xffffffff),  // Pure white variant for highest contrast
      outline: Color(0xffffffff),           // Pure white outline for highest contrast
      outlineVariant: Color(0xffffffff),    // Pure white variant for highest contrast
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xfff5f5f5),
      inversePrimary: Color(0xff00174f),    // Very dark blue for inverse contrast
      primaryFixed: Color(0xffd8e6ff),      // Very bright fixed for highest contrast
      onPrimaryFixed: Color(0xff000000),    // Pure black text for highest contrast
      primaryFixedDim: Color(0xffadc7ff),   // Bright fixed dim for highest contrast
      onPrimaryFixedVariant: Color(0xff000000), // Pure black text for highest contrast
      secondaryFixed: Color(0xffe6e0ff),    // Very bright fixed for highest contrast
      onSecondaryFixed: Color(0xff000000),  // Pure black text for highest contrast
      secondaryFixedDim: Color(0xffc9b8ff), // Bright fixed dim for highest contrast
      onSecondaryFixedVariant: Color(0xff000000), // Pure black text for highest contrast
      tertiaryFixed: Color(0xffcefaff),     // Very bright fixed for highest contrast
      onTertiaryFixed: Color(0xff000000),   // Pure black text for highest contrast
      tertiaryFixedDim: Color(0xff8defff),  // Bright fixed dim for highest contrast
      onTertiaryFixedVariant: Color(0xff000000), // Pure black text for highest contrast
      surfaceDim: Color(0xff121212),
      surfaceBright: Color(0xff373737),
      surfaceContainerLowest: Color(0xff0d0d0d),
      surfaceContainerLow: Color(0xff1a1a1a),
      surfaceContainer: Color(0xff222222),
      surfaceContainerHigh: Color(0xff2d2d2d),
      surfaceContainerHighest: Color(0xff383838),
    );
  }

  ThemeData darkHighContrast() {
    return theme(darkHighContrastScheme());
  }

  ThemeData theme(ColorScheme colorScheme) => ThemeData(
        useMaterial3: true,
        brightness: colorScheme.brightness,
        colorScheme: colorScheme,
        textTheme: textTheme.apply(
          bodyColor: colorScheme.onSurface,
          displayColor: colorScheme.onSurface,
        ),
        scaffoldBackgroundColor: colorScheme.surface,
        canvasColor: colorScheme.surface,
      );

  /// Custom Colors
  static const customFlow = ExtendedColor(
    seed: Color(0xff2962ff),
    value: Color(0xff2962ff),
    light: ColorFamily(
      color: Color(0xff2962ff),
      onColor: Color(0xffffffff),
      colorContainer: Color(0xffd8e6ff),
      onColorContainer: Color(0xff00174f),
    ),
    lightMediumContrast: ColorFamily(
      color: Color(0xff0044c1),
      onColor: Color(0xffffffff),
      colorContainer: Color(0xff4a85ff),
      onColorContainer: Color(0xffffffff),
    ),
    lightHighContrast: ColorFamily(
      color: Color(0xff00174f),
      onColor: Color(0xffffffff),
      colorContainer: Color(0xff0044c1),
      onColorContainer: Color(0xffffffff),
    ),
    dark: ColorFamily(
      color: Color(0xff82b1ff),
      onColor: Color(0xff00174f),
      colorContainer: Color(0xff0044c1),
      onColorContainer: Color(0xffd8e6ff),
    ),
    darkMediumContrast: ColorFamily(
      color: Color(0xffadc7ff),
      onColor: Color(0xff00174f),
      colorContainer: Color(0xff4a85ff),
      onColorContainer: Color(0xff000000),
    ),
    darkHighContrast: ColorFamily(
      color: Color(0xffd8e6ff),
      onColor: Color(0xff000000),
      colorContainer: Color(0xffadc7ff),
      onColorContainer: Color(0xff000000),
    ),
  );

  static const customSuccess = ExtendedColor(
    seed: Color(0xff4caf50),
    value: Color(0xff4caf50),
    light: ColorFamily(
      color: Color(0xff2e7d32),
      onColor: Color(0xffffffff),
      colorContainer: Color(0xffb9f6ca),
      onColorContainer: Color(0xff00210b),
    ),
    lightMediumContrast: ColorFamily(
      color: Color(0xff1b5e20),
      onColor: Color(0xffffffff),
      colorContainer: Color(0xff4caf50),
      onColorContainer: Color(0xffffffff),
    ),
    lightHighContrast: ColorFamily(
      color: Color(0xff00210b),
      onColor: Color(0xffffffff),
      colorContainer: Color(0xff1b5e20),
      onColorContainer: Color(0xffffffff),
    ),
    dark: ColorFamily(
      color: Color(0xff81c784),
      onColor: Color(0xff00210b),
      colorContainer: Color(0xff2e7d32),
      onColorContainer: Color(0xffb9f6ca),
    ),
    darkMediumContrast: ColorFamily(
      color: Color(0xffa5d6a7),
      onColor: Color(0xff00210b),
      colorContainer: Color(0xff4caf50),
      onColorContainer: Color(0xff000000),
    ),
    darkHighContrast: ColorFamily(
      color: Color(0xffb9f6ca),
      onColor: Color(0xff000000),
      colorContainer: Color(0xffa5d6a7),
      onColorContainer: Color(0xff000000),
    ),
  );

  List<ExtendedColor> get extendedColors => [
        customFlow,
        customSuccess,
      ];
}

class ExtendedColor {
  final Color seed, value;
  final ColorFamily light;
  final ColorFamily lightHighContrast;
  final ColorFamily lightMediumContrast;
  final ColorFamily dark;
  final ColorFamily darkHighContrast;
  final ColorFamily darkMediumContrast;

  const ExtendedColor({
    required this.seed,
    required this.value,
    required this.light,
    required this.lightHighContrast,
    required this.lightMediumContrast,
    required this.dark,
    required this.darkHighContrast,
    required this.darkMediumContrast,
  });
}

class ColorFamily {
  const ColorFamily({
    required this.color,
    required this.onColor,
    required this.colorContainer,
    required this.onColorContainer,
  });

  final Color color;
  final Color onColor;
  final Color colorContainer;
  final Color onColorContainer;
}