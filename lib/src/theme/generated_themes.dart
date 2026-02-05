import '../../shadcn_flutter.dart';
import 'dart:ui';
void _assertNotThemeModeSystem(ThemeMode mode, String label) {
  if (mode == ThemeMode.system) {
    final List<DiagnosticsNode> diagnosticList = [];
    diagnosticList.add(ErrorSummary('ColorSchemes.${label.toLowerCase()}(ThemeMode mode) can only be used with ThemeMode.light or ThemeMode.dark.'));
    diagnosticList.add(ErrorDescription('This method is only intended as a helper method to get either ColorSchemes.light$label() or ColorSchemes.dark$label().'));
    diagnosticList.add(ErrorHint('To use system theme mode, do this:\n'
      'ShadcnApp(\n'
      '  theme: ThemeData(colorScheme: ColorSchemes.${label.toLowerCase()}(ThemeMode.light)),\n'
      '  darkTheme: ThemeData(colorScheme: ColorSchemes.${label.toLowerCase()}(ThemeMode.dark)),\n'
      '  themeMode: ThemeMode.system, // optional, default is ThemeMode.system\n'
      ')\n'
      'or:\n'
      'ShadcnApp(\n'
      '  theme: ThemeData(colorScheme: ColorSchemes.light$label),\n'
      '  darkTheme: ThemeData(colorScheme: ColorSchemes.dark$label),\n'
      ')\n'
      'instead of:\n'
      'ShadcnApp(\n'
      '  theme: ThemeData(colorScheme: ColorSchemes.${label.toLowerCase()}(ThemeMode.system)),\n'
      ')'));
    throw FlutterError.fromParts(diagnosticList);
  }
}
class ColorSchemes {
  ColorSchemes._();
	static const ColorScheme lightGray = 
		ColorScheme(
			brightness: Brightness.light,
			background: Color(0xFFFFFFFF),
			foreground: Color(0xFF030712),
			card: Color(0xFFFFFFFF),
			cardForeground: Color(0xFF030712),
			popover: Color(0xFFFFFFFF),
			popoverForeground: Color(0xFF030712),
			primary: Color(0xFF111827),
			primaryForeground: Color(0xFFF9FAFB),
			secondary: Color(0xFFF3F4F6),
			secondaryForeground: Color(0xFF111827),
			muted: Color(0xFFF3F4F6),
			mutedForeground: Color(0xFF6B7280),
			accent: Color(0xFFF3F4F6),
			accentForeground: Color(0xFF111827),
			destructive: Color(0xFFEF4444),
			destructiveForeground: Color(0xFFF9FAFB),
			border: Color(0xFFE5E7EB),
			input: Color(0xFFE5E7EB),
			ring: Color(0xFF030712),
			chart1: Color(0xFFE76E50),
			chart2: Color(0xFF2A9D90),
			chart3: Color(0xFF274754),
			chart4: Color(0xFFE8C468),
			chart5: Color(0xFFF4A462),
		);

	static const ColorScheme darkGray = 
		ColorScheme(
			brightness: Brightness.dark,
			background: Color(0xFF030712),
			foreground: Color(0xFFF9FAFB),
			card: Color(0xFF030712),
			cardForeground: Color(0xFFF9FAFB),
			popover: Color(0xFF030712),
			popoverForeground: Color(0xFFF9FAFB),
			primary: Color(0xFFF9FAFB),
			primaryForeground: Color(0xFF111827),
			secondary: Color(0xFF1F2937),
			secondaryForeground: Color(0xFFF9FAFB),
			muted: Color(0xFF1F2937),
			mutedForeground: Color(0xFF9CA3AF),
			accent: Color(0xFF1F2937),
			accentForeground: Color(0xFFF9FAFB),
			destructive: Color(0xFF7F1D1D),
			destructiveForeground: Color(0xFFF9FAFB),
			border: Color(0xFF1F2937),
			input: Color(0xFF1F2937),
			ring: Color(0xFFD1D5DB),
			chart1: Color(0xFF2662D9),
			chart2: Color(0xFF2EB88A),
			chart3: Color(0xFFE88C30),
			chart4: Color(0xFFAF57DB),
			chart5: Color(0xFFE23670),
		);

	static ColorScheme gray(ThemeMode mode) {
		assert(() {
			_assertNotThemeModeSystem(mode, 'Gray');
			return true;
		}());
		return mode == ThemeMode.light ? lightGray : darkGray;
	}

	static const ColorScheme lightNeutral = 
		ColorScheme(
			brightness: Brightness.light,
			background: Color(0xFFFFFFFF),
			foreground: Color(0xFF0A0A0A),
			card: Color(0xFFFFFFFF),
			cardForeground: Color(0xFF0A0A0A),
			popover: Color(0xFFFFFFFF),
			popoverForeground: Color(0xFF0A0A0A),
			primary: Color(0xFF171717),
			primaryForeground: Color(0xFFFAFAFA),
			secondary: Color(0xFFF5F5F5),
			secondaryForeground: Color(0xFF171717),
			muted: Color(0xFFF5F5F5),
			mutedForeground: Color(0xFF737373),
			accent: Color(0xFFF5F5F5),
			accentForeground: Color(0xFF171717),
			destructive: Color(0xFFEF4444),
			destructiveForeground: Color(0xFFFAFAFA),
			border: Color(0xFFE5E5E5),
			input: Color(0xFFE5E5E5),
			ring: Color(0xFF0A0A0A),
			chart1: Color(0xFFE76E50),
			chart2: Color(0xFF2A9D90),
			chart3: Color(0xFF274754),
			chart4: Color(0xFFE8C468),
			chart5: Color(0xFFF4A462),
		);

	static const ColorScheme darkNeutral = 
		ColorScheme(
			brightness: Brightness.dark,
			background: Color(0xFF0A0A0A),
			foreground: Color(0xFFFAFAFA),
			card: Color(0xFF0A0A0A),
			cardForeground: Color(0xFFFAFAFA),
			popover: Color(0xFF0A0A0A),
			popoverForeground: Color(0xFFFAFAFA),
			primary: Color(0xFFFAFAFA),
			primaryForeground: Color(0xFF171717),
			secondary: Color(0xFF262626),
			secondaryForeground: Color(0xFFFAFAFA),
			muted: Color(0xFF262626),
			mutedForeground: Color(0xFFA3A3A3),
			accent: Color(0xFF262626),
			accentForeground: Color(0xFFFAFAFA),
			destructive: Color(0xFF7F1D1D),
			destructiveForeground: Color(0xFFFAFAFA),
			border: Color(0xFF262626),
			input: Color(0xFF262626),
			ring: Color(0xFFD4D4D4),
			chart1: Color(0xFF2662D9),
			chart2: Color(0xFF2EB88A),
			chart3: Color(0xFFE88C30),
			chart4: Color(0xFFAF57DB),
			chart5: Color(0xFFE23670),
		);

	static ColorScheme neutral(ThemeMode mode) {
		assert(() {
			_assertNotThemeModeSystem(mode, 'Neutral');
			return true;
		}());
		return mode == ThemeMode.light ? lightNeutral : darkNeutral;
	}

	static const ColorScheme lightSlate = 
		ColorScheme(
			brightness: Brightness.light,
			background: Color(0xFFFFFFFF),
			foreground: Color(0xFF020817),
			card: Color(0xFFFFFFFF),
			cardForeground: Color(0xFF020817),
			popover: Color(0xFFFFFFFF),
			popoverForeground: Color(0xFF020817),
			primary: Color(0xFF0F172A),
			primaryForeground: Color(0xFFF8FAFC),
			secondary: Color(0xFFF1F5F9),
			secondaryForeground: Color(0xFF0F172A),
			muted: Color(0xFFF1F5F9),
			mutedForeground: Color(0xFF64748B),
			accent: Color(0xFFF1F5F9),
			accentForeground: Color(0xFF0F172A),
			destructive: Color(0xFFEF4444),
			destructiveForeground: Color(0xFFF8FAFC),
			border: Color(0xFFE2E8F0),
			input: Color(0xFFE2E8F0),
			ring: Color(0xFF020817),
			chart1: Color(0xFFE76E50),
			chart2: Color(0xFF2A9D90),
			chart3: Color(0xFF274754),
			chart4: Color(0xFFE8C468),
			chart5: Color(0xFFF4A462),
		);

	static const ColorScheme darkSlate = 
		ColorScheme(
			brightness: Brightness.dark,
			background: Color(0xFF020817),
			foreground: Color(0xFFF8FAFC),
			card: Color(0xFF020817),
			cardForeground: Color(0xFFF8FAFC),
			popover: Color(0xFF020817),
			popoverForeground: Color(0xFFF8FAFC),
			primary: Color(0xFFF8FAFC),
			primaryForeground: Color(0xFF0F172A),
			secondary: Color(0xFF1E293B),
			secondaryForeground: Color(0xFFF8FAFC),
			muted: Color(0xFF1E293B),
			mutedForeground: Color(0xFF94A3B8),
			accent: Color(0xFF1E293B),
			accentForeground: Color(0xFFF8FAFC),
			destructive: Color(0xFF7F1D1D),
			destructiveForeground: Color(0xFFF8FAFC),
			border: Color(0xFF1E293B),
			input: Color(0xFF1E293B),
			ring: Color(0xFFCBD5E1),
			chart1: Color(0xFF2662D9),
			chart2: Color(0xFF2EB88A),
			chart3: Color(0xFFE88C30),
			chart4: Color(0xFFAF57DB),
			chart5: Color(0xFFE23670),
		);

	static ColorScheme slate(ThemeMode mode) {
		assert(() {
			_assertNotThemeModeSystem(mode, 'Slate');
			return true;
		}());
		return mode == ThemeMode.light ? lightSlate : darkSlate;
	}

	static const ColorScheme lightStone = 
		ColorScheme(
			brightness: Brightness.light,
			background: Color(0xFFFFFFFF),
			foreground: Color(0xFF0C0A09),
			card: Color(0xFFFFFFFF),
			cardForeground: Color(0xFF0C0A09),
			popover: Color(0xFFFFFFFF),
			popoverForeground: Color(0xFF0C0A09),
			primary: Color(0xFF1C1917),
			primaryForeground: Color(0xFFFAFAF9),
			secondary: Color(0xFFF5F5F4),
			secondaryForeground: Color(0xFF1C1917),
			muted: Color(0xFFF5F5F4),
			mutedForeground: Color(0xFF78716C),
			accent: Color(0xFFF5F5F4),
			accentForeground: Color(0xFF1C1917),
			destructive: Color(0xFFEF4444),
			destructiveForeground: Color(0xFFFAFAF9),
			border: Color(0xFFE7E5E4),
			input: Color(0xFFE7E5E4),
			ring: Color(0xFF0C0A09),
			chart1: Color(0xFFE76E50),
			chart2: Color(0xFF2A9D90),
			chart3: Color(0xFF274754),
			chart4: Color(0xFFE8C468),
			chart5: Color(0xFFF4A462),
		);

	static const ColorScheme darkStone = 
		ColorScheme(
			brightness: Brightness.dark,
			background: Color(0xFF0C0A09),
			foreground: Color(0xFFFAFAF9),
			card: Color(0xFF0C0A09),
			cardForeground: Color(0xFFFAFAF9),
			popover: Color(0xFF0C0A09),
			popoverForeground: Color(0xFFFAFAF9),
			primary: Color(0xFFFAFAF9),
			primaryForeground: Color(0xFF1C1917),
			secondary: Color(0xFF292524),
			secondaryForeground: Color(0xFFFAFAF9),
			muted: Color(0xFF292524),
			mutedForeground: Color(0xFFA8A29E),
			accent: Color(0xFF292524),
			accentForeground: Color(0xFFFAFAF9),
			destructive: Color(0xFF7F1D1D),
			destructiveForeground: Color(0xFFFAFAF9),
			border: Color(0xFF292524),
			input: Color(0xFF292524),
			ring: Color(0xFFD6D3D1),
			chart1: Color(0xFF2662D9),
			chart2: Color(0xFF2EB88A),
			chart3: Color(0xFFE88C30),
			chart4: Color(0xFFAF57DB),
			chart5: Color(0xFFE23670),
		);

	static ColorScheme stone(ThemeMode mode) {
		assert(() {
			_assertNotThemeModeSystem(mode, 'Stone');
			return true;
		}());
		return mode == ThemeMode.light ? lightStone : darkStone;
	}

	static const ColorScheme lightZinc = 
		ColorScheme(
			brightness: Brightness.light,
			background: Color(0xFFFFFFFF),
			foreground: Color(0xFF09090B),
			card: Color(0xFFFFFFFF),
			cardForeground: Color(0xFF09090B),
			popover: Color(0xFFFFFFFF),
			popoverForeground: Color(0xFF09090B),
			primary: Color(0xFF18181B),
			primaryForeground: Color(0xFFFAFAFA),
			secondary: Color(0xFFF4F4F5),
			secondaryForeground: Color(0xFF18181B),
			muted: Color(0xFFF4F4F5),
			mutedForeground: Color(0xFF71717A),
			accent: Color(0xFFF4F4F5),
			accentForeground: Color(0xFF18181B),
			destructive: Color(0xFFEF4444),
			destructiveForeground: Color(0xFFFAFAFA),
			border: Color(0xFFE4E4E7),
			input: Color(0xFFE4E4E7),
			ring: Color(0xFF09090B),
			chart1: Color(0xFFE76E50),
			chart2: Color(0xFF2A9D90),
			chart3: Color(0xFF274754),
			chart4: Color(0xFFE8C468),
			chart5: Color(0xFFF4A462),
		);

	static const ColorScheme darkZinc = 
		ColorScheme(
			brightness: Brightness.dark,
			background: Color(0xFF09090B),
			foreground: Color(0xFFFAFAFA),
			card: Color(0xFF09090B),
			cardForeground: Color(0xFFFAFAFA),
			popover: Color(0xFF09090B),
			popoverForeground: Color(0xFFFAFAFA),
			primary: Color(0xFFFAFAFA),
			primaryForeground: Color(0xFF18181B),
			secondary: Color(0xFF27272A),
			secondaryForeground: Color(0xFFFAFAFA),
			muted: Color(0xFF27272A),
			mutedForeground: Color(0xFFA1A1AA),
			accent: Color(0xFF27272A),
			accentForeground: Color(0xFFFAFAFA),
			destructive: Color(0xFF7F1D1D),
			destructiveForeground: Color(0xFFFAFAFA),
			border: Color(0xFF27272A),
			input: Color(0xFF27272A),
			ring: Color(0xFFD4D4D8),
			chart1: Color(0xFF2662D9),
			chart2: Color(0xFF2EB88A),
			chart3: Color(0xFFE88C30),
			chart4: Color(0xFFAF57DB),
			chart5: Color(0xFFE23670),
		);

	static ColorScheme zinc(ThemeMode mode) {
		assert(() {
			_assertNotThemeModeSystem(mode, 'Zinc');
			return true;
		}());
		return mode == ThemeMode.light ? lightZinc : darkZinc;
	}

}