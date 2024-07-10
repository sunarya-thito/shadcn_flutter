import '../../shadcn_flutter.dart';
import 'package:flutter/painting.dart';
class ColorSchemes {
	static ColorScheme lightBlue() {
		return ColorScheme(
			background: const HSLColor.fromAHSL(1, 0.0, 0.0, 1.0).toColor(),
			foreground: const HSLColor.fromAHSL(1, 222.2, 0.84, 0.05).toColor(),
			card: const HSLColor.fromAHSL(1, 0.0, 0.0, 1.0).toColor(),
			cardForeground: const HSLColor.fromAHSL(1, 222.2, 0.84, 0.05).toColor(),
			popover: const HSLColor.fromAHSL(1, 0.0, 0.0, 1.0).toColor(),
			popoverForeground: const HSLColor.fromAHSL(1, 222.2, 0.84, 0.05).toColor(),
			primary: const HSLColor.fromAHSL(1, 221.2, 0.83, 0.53).toColor(),
			primaryForeground: const HSLColor.fromAHSL(1, 210.0, 0.4, 0.98).toColor(),
			secondary: const HSLColor.fromAHSL(1, 210.0, 0.4, 0.96).toColor(),
			secondaryForeground: const HSLColor.fromAHSL(1, 222.2, 0.47, 0.11).toColor(),
			muted: const HSLColor.fromAHSL(1, 210.0, 0.4, 0.96).toColor(),
			mutedForeground: const HSLColor.fromAHSL(1, 215.4, 0.16, 0.47).toColor(),
			accent: const HSLColor.fromAHSL(1, 210.0, 0.4, 0.96).toColor(),
			accentForeground: const HSLColor.fromAHSL(1, 222.2, 0.47, 0.11).toColor(),
			destructive: const HSLColor.fromAHSL(1, 0.0, 0.84, 0.6).toColor(),
			destructiveForeground: const HSLColor.fromAHSL(1, 210.0, 0.4, 0.98).toColor(),
			border: const HSLColor.fromAHSL(1, 214.3, 0.32, 0.91).toColor(),
			input: const HSLColor.fromAHSL(1, 214.3, 0.32, 0.91).toColor(),
			ring: const HSLColor.fromAHSL(1, 221.2, 0.83, 0.53).toColor(),
		);
	}

	static ColorScheme darkBlue() {
		return ColorScheme(
			background: const HSLColor.fromAHSL(1, 222.2, 0.84, 0.05).toColor(),
			foreground: const HSLColor.fromAHSL(1, 210.0, 0.4, 0.98).toColor(),
			card: const HSLColor.fromAHSL(1, 222.2, 0.84, 0.05).toColor(),
			cardForeground: const HSLColor.fromAHSL(1, 210.0, 0.4, 0.98).toColor(),
			popover: const HSLColor.fromAHSL(1, 222.2, 0.84, 0.05).toColor(),
			popoverForeground: const HSLColor.fromAHSL(1, 210.0, 0.4, 0.98).toColor(),
			primary: const HSLColor.fromAHSL(1, 217.2, 0.91, 0.6).toColor(),
			primaryForeground: const HSLColor.fromAHSL(1, 222.2, 0.47, 0.11).toColor(),
			secondary: const HSLColor.fromAHSL(1, 217.2, 0.33, 0.18).toColor(),
			secondaryForeground: const HSLColor.fromAHSL(1, 210.0, 0.4, 0.98).toColor(),
			muted: const HSLColor.fromAHSL(1, 217.2, 0.33, 0.18).toColor(),
			mutedForeground: const HSLColor.fromAHSL(1, 215.0, 0.2, 0.65).toColor(),
			accent: const HSLColor.fromAHSL(1, 217.2, 0.33, 0.18).toColor(),
			accentForeground: const HSLColor.fromAHSL(1, 210.0, 0.4, 0.98).toColor(),
			destructive: const HSLColor.fromAHSL(1, 0.0, 0.63, 0.31).toColor(),
			destructiveForeground: const HSLColor.fromAHSL(1, 210.0, 0.4, 0.98).toColor(),
			border: const HSLColor.fromAHSL(1, 217.2, 0.33, 0.18).toColor(),
			input: const HSLColor.fromAHSL(1, 217.2, 0.33, 0.18).toColor(),
			ring: const HSLColor.fromAHSL(1, 224.3, 0.76, 0.48).toColor(),
		);
	}

	static ColorScheme lightGray() {
		return ColorScheme(
			background: const HSLColor.fromAHSL(1, 0.0, 0.0, 1.0).toColor(),
			foreground: const HSLColor.fromAHSL(1, 224.0, 0.71, 0.04).toColor(),
			card: const HSLColor.fromAHSL(1, 0.0, 0.0, 1.0).toColor(),
			cardForeground: const HSLColor.fromAHSL(1, 224.0, 0.71, 0.04).toColor(),
			popover: const HSLColor.fromAHSL(1, 0.0, 0.0, 1.0).toColor(),
			popoverForeground: const HSLColor.fromAHSL(1, 224.0, 0.71, 0.04).toColor(),
			primary: const HSLColor.fromAHSL(1, 220.9, 0.39, 0.11).toColor(),
			primaryForeground: const HSLColor.fromAHSL(1, 210.0, 0.2, 0.98).toColor(),
			secondary: const HSLColor.fromAHSL(1, 220.0, 0.14, 0.96).toColor(),
			secondaryForeground: const HSLColor.fromAHSL(1, 220.9, 0.39, 0.11).toColor(),
			muted: const HSLColor.fromAHSL(1, 220.0, 0.14, 0.96).toColor(),
			mutedForeground: const HSLColor.fromAHSL(1, 220.0, 0.09, 0.46).toColor(),
			accent: const HSLColor.fromAHSL(1, 220.0, 0.14, 0.96).toColor(),
			accentForeground: const HSLColor.fromAHSL(1, 220.9, 0.39, 0.11).toColor(),
			destructive: const HSLColor.fromAHSL(1, 0.0, 0.84, 0.6).toColor(),
			destructiveForeground: const HSLColor.fromAHSL(1, 210.0, 0.2, 0.98).toColor(),
			border: const HSLColor.fromAHSL(1, 220.0, 0.13, 0.91).toColor(),
			input: const HSLColor.fromAHSL(1, 220.0, 0.13, 0.91).toColor(),
			ring: const HSLColor.fromAHSL(1, 224.0, 0.71, 0.04).toColor(),
		);
	}

	static ColorScheme darkGray() {
		return ColorScheme(
			background: const HSLColor.fromAHSL(1, 224.0, 0.71, 0.04).toColor(),
			foreground: const HSLColor.fromAHSL(1, 210.0, 0.2, 0.98).toColor(),
			card: const HSLColor.fromAHSL(1, 224.0, 0.71, 0.04).toColor(),
			cardForeground: const HSLColor.fromAHSL(1, 210.0, 0.2, 0.98).toColor(),
			popover: const HSLColor.fromAHSL(1, 224.0, 0.71, 0.04).toColor(),
			popoverForeground: const HSLColor.fromAHSL(1, 210.0, 0.2, 0.98).toColor(),
			primary: const HSLColor.fromAHSL(1, 210.0, 0.2, 0.98).toColor(),
			primaryForeground: const HSLColor.fromAHSL(1, 220.9, 0.39, 0.11).toColor(),
			secondary: const HSLColor.fromAHSL(1, 215.0, 0.28, 0.17).toColor(),
			secondaryForeground: const HSLColor.fromAHSL(1, 210.0, 0.2, 0.98).toColor(),
			muted: const HSLColor.fromAHSL(1, 215.0, 0.28, 0.17).toColor(),
			mutedForeground: const HSLColor.fromAHSL(1, 217.9, 0.11, 0.65).toColor(),
			accent: const HSLColor.fromAHSL(1, 215.0, 0.28, 0.17).toColor(),
			accentForeground: const HSLColor.fromAHSL(1, 210.0, 0.2, 0.98).toColor(),
			destructive: const HSLColor.fromAHSL(1, 0.0, 0.63, 0.31).toColor(),
			destructiveForeground: const HSLColor.fromAHSL(1, 210.0, 0.2, 0.98).toColor(),
			border: const HSLColor.fromAHSL(1, 215.0, 0.28, 0.17).toColor(),
			input: const HSLColor.fromAHSL(1, 215.0, 0.28, 0.17).toColor(),
			ring: const HSLColor.fromAHSL(1, 216.0, 0.12, 0.84).toColor(),
		);
	}

	static ColorScheme lightGreen() {
		return ColorScheme(
			background: const HSLColor.fromAHSL(1, 0.0, 0.0, 1.0).toColor(),
			foreground: const HSLColor.fromAHSL(1, 240.0, 0.1, 0.04).toColor(),
			card: const HSLColor.fromAHSL(1, 0.0, 0.0, 1.0).toColor(),
			cardForeground: const HSLColor.fromAHSL(1, 240.0, 0.1, 0.04).toColor(),
			popover: const HSLColor.fromAHSL(1, 0.0, 0.0, 1.0).toColor(),
			popoverForeground: const HSLColor.fromAHSL(1, 240.0, 0.1, 0.04).toColor(),
			primary: const HSLColor.fromAHSL(1, 142.1, 0.76, 0.36).toColor(),
			primaryForeground: const HSLColor.fromAHSL(1, 355.7, 1.0, 0.97).toColor(),
			secondary: const HSLColor.fromAHSL(1, 240.0, 0.05, 0.96).toColor(),
			secondaryForeground: const HSLColor.fromAHSL(1, 240.0, 0.06, 0.1).toColor(),
			muted: const HSLColor.fromAHSL(1, 240.0, 0.05, 0.96).toColor(),
			mutedForeground: const HSLColor.fromAHSL(1, 240.0, 0.04, 0.46).toColor(),
			accent: const HSLColor.fromAHSL(1, 240.0, 0.05, 0.96).toColor(),
			accentForeground: const HSLColor.fromAHSL(1, 240.0, 0.06, 0.1).toColor(),
			destructive: const HSLColor.fromAHSL(1, 0.0, 0.84, 0.6).toColor(),
			destructiveForeground: const HSLColor.fromAHSL(1, 0.0, 0.0, 0.98).toColor(),
			border: const HSLColor.fromAHSL(1, 240.0, 0.06, 0.9).toColor(),
			input: const HSLColor.fromAHSL(1, 240.0, 0.06, 0.9).toColor(),
			ring: const HSLColor.fromAHSL(1, 142.1, 0.76, 0.36).toColor(),
		);
	}

	static ColorScheme darkGreen() {
		return ColorScheme(
			background: const HSLColor.fromAHSL(1, 20.0, 0.14, 0.04).toColor(),
			foreground: const HSLColor.fromAHSL(1, 0.0, 0.0, 0.95).toColor(),
			card: const HSLColor.fromAHSL(1, 24.0, 0.1, 0.1).toColor(),
			cardForeground: const HSLColor.fromAHSL(1, 0.0, 0.0, 0.95).toColor(),
			popover: const HSLColor.fromAHSL(1, 0.0, 0.0, 0.09).toColor(),
			popoverForeground: const HSLColor.fromAHSL(1, 0.0, 0.0, 0.95).toColor(),
			primary: const HSLColor.fromAHSL(1, 142.1, 0.71, 0.45).toColor(),
			primaryForeground: const HSLColor.fromAHSL(1, 144.9, 0.8, 0.1).toColor(),
			secondary: const HSLColor.fromAHSL(1, 240.0, 0.04, 0.16).toColor(),
			secondaryForeground: const HSLColor.fromAHSL(1, 0.0, 0.0, 0.98).toColor(),
			muted: const HSLColor.fromAHSL(1, 0.0, 0.0, 0.15).toColor(),
			mutedForeground: const HSLColor.fromAHSL(1, 240.0, 0.05, 0.65).toColor(),
			accent: const HSLColor.fromAHSL(1, 12.0, 0.07, 0.15).toColor(),
			accentForeground: const HSLColor.fromAHSL(1, 0.0, 0.0, 0.98).toColor(),
			destructive: const HSLColor.fromAHSL(1, 0.0, 0.63, 0.31).toColor(),
			destructiveForeground: const HSLColor.fromAHSL(1, 0.0, 0.86, 0.97).toColor(),
			border: const HSLColor.fromAHSL(1, 240.0, 0.04, 0.16).toColor(),
			input: const HSLColor.fromAHSL(1, 240.0, 0.04, 0.16).toColor(),
			ring: const HSLColor.fromAHSL(1, 142.4, 0.72, 0.29).toColor(),
		);
	}

	static ColorScheme lightNeutral() {
		return ColorScheme(
			background: const HSLColor.fromAHSL(1, 0.0, 0.0, 1.0).toColor(),
			foreground: const HSLColor.fromAHSL(1, 0.0, 0.0, 0.04).toColor(),
			card: const HSLColor.fromAHSL(1, 0.0, 0.0, 1.0).toColor(),
			cardForeground: const HSLColor.fromAHSL(1, 0.0, 0.0, 0.04).toColor(),
			popover: const HSLColor.fromAHSL(1, 0.0, 0.0, 1.0).toColor(),
			popoverForeground: const HSLColor.fromAHSL(1, 0.0, 0.0, 0.04).toColor(),
			primary: const HSLColor.fromAHSL(1, 0.0, 0.0, 0.09).toColor(),
			primaryForeground: const HSLColor.fromAHSL(1, 0.0, 0.0, 0.98).toColor(),
			secondary: const HSLColor.fromAHSL(1, 0.0, 0.0, 0.96).toColor(),
			secondaryForeground: const HSLColor.fromAHSL(1, 0.0, 0.0, 0.09).toColor(),
			muted: const HSLColor.fromAHSL(1, 0.0, 0.0, 0.96).toColor(),
			mutedForeground: const HSLColor.fromAHSL(1, 0.0, 0.0, 0.45).toColor(),
			accent: const HSLColor.fromAHSL(1, 0.0, 0.0, 0.96).toColor(),
			accentForeground: const HSLColor.fromAHSL(1, 0.0, 0.0, 0.09).toColor(),
			destructive: const HSLColor.fromAHSL(1, 0.0, 0.84, 0.6).toColor(),
			destructiveForeground: const HSLColor.fromAHSL(1, 0.0, 0.0, 0.98).toColor(),
			border: const HSLColor.fromAHSL(1, 0.0, 0.0, 0.9).toColor(),
			input: const HSLColor.fromAHSL(1, 0.0, 0.0, 0.9).toColor(),
			ring: const HSLColor.fromAHSL(1, 0.0, 0.0, 0.04).toColor(),
		);
	}

	static ColorScheme darkNeutral() {
		return ColorScheme(
			background: const HSLColor.fromAHSL(1, 0.0, 0.0, 0.04).toColor(),
			foreground: const HSLColor.fromAHSL(1, 0.0, 0.0, 0.98).toColor(),
			card: const HSLColor.fromAHSL(1, 0.0, 0.0, 0.04).toColor(),
			cardForeground: const HSLColor.fromAHSL(1, 0.0, 0.0, 0.98).toColor(),
			popover: const HSLColor.fromAHSL(1, 0.0, 0.0, 0.04).toColor(),
			popoverForeground: const HSLColor.fromAHSL(1, 0.0, 0.0, 0.98).toColor(),
			primary: const HSLColor.fromAHSL(1, 0.0, 0.0, 0.98).toColor(),
			primaryForeground: const HSLColor.fromAHSL(1, 0.0, 0.0, 0.09).toColor(),
			secondary: const HSLColor.fromAHSL(1, 0.0, 0.0, 0.15).toColor(),
			secondaryForeground: const HSLColor.fromAHSL(1, 0.0, 0.0, 0.98).toColor(),
			muted: const HSLColor.fromAHSL(1, 0.0, 0.0, 0.15).toColor(),
			mutedForeground: const HSLColor.fromAHSL(1, 0.0, 0.0, 0.64).toColor(),
			accent: const HSLColor.fromAHSL(1, 0.0, 0.0, 0.15).toColor(),
			accentForeground: const HSLColor.fromAHSL(1, 0.0, 0.0, 0.98).toColor(),
			destructive: const HSLColor.fromAHSL(1, 0.0, 0.63, 0.31).toColor(),
			destructiveForeground: const HSLColor.fromAHSL(1, 0.0, 0.0, 0.98).toColor(),
			border: const HSLColor.fromAHSL(1, 0.0, 0.0, 0.15).toColor(),
			input: const HSLColor.fromAHSL(1, 0.0, 0.0, 0.15).toColor(),
			ring: const HSLColor.fromAHSL(1, 0.0, 0.0, 0.83).toColor(),
		);
	}

	static ColorScheme lightOrange() {
		return ColorScheme(
			background: const HSLColor.fromAHSL(1, 0.0, 0.0, 1.0).toColor(),
			foreground: const HSLColor.fromAHSL(1, 20.0, 0.14, 0.04).toColor(),
			card: const HSLColor.fromAHSL(1, 0.0, 0.0, 1.0).toColor(),
			cardForeground: const HSLColor.fromAHSL(1, 20.0, 0.14, 0.04).toColor(),
			popover: const HSLColor.fromAHSL(1, 0.0, 0.0, 1.0).toColor(),
			popoverForeground: const HSLColor.fromAHSL(1, 20.0, 0.14, 0.04).toColor(),
			primary: const HSLColor.fromAHSL(1, 24.6, 0.95, 0.53).toColor(),
			primaryForeground: const HSLColor.fromAHSL(1, 60.0, 0.09, 0.98).toColor(),
			secondary: const HSLColor.fromAHSL(1, 60.0, 0.05, 0.96).toColor(),
			secondaryForeground: const HSLColor.fromAHSL(1, 24.0, 0.1, 0.1).toColor(),
			muted: const HSLColor.fromAHSL(1, 60.0, 0.05, 0.96).toColor(),
			mutedForeground: const HSLColor.fromAHSL(1, 25.0, 0.05, 0.45).toColor(),
			accent: const HSLColor.fromAHSL(1, 60.0, 0.05, 0.96).toColor(),
			accentForeground: const HSLColor.fromAHSL(1, 24.0, 0.1, 0.1).toColor(),
			destructive: const HSLColor.fromAHSL(1, 0.0, 0.84, 0.6).toColor(),
			destructiveForeground: const HSLColor.fromAHSL(1, 60.0, 0.09, 0.98).toColor(),
			border: const HSLColor.fromAHSL(1, 20.0, 0.06, 0.9).toColor(),
			input: const HSLColor.fromAHSL(1, 20.0, 0.06, 0.9).toColor(),
			ring: const HSLColor.fromAHSL(1, 24.6, 0.95, 0.53).toColor(),
		);
	}

	static ColorScheme darkOrange() {
		return ColorScheme(
			background: const HSLColor.fromAHSL(1, 20.0, 0.14, 0.04).toColor(),
			foreground: const HSLColor.fromAHSL(1, 60.0, 0.09, 0.98).toColor(),
			card: const HSLColor.fromAHSL(1, 20.0, 0.14, 0.04).toColor(),
			cardForeground: const HSLColor.fromAHSL(1, 60.0, 0.09, 0.98).toColor(),
			popover: const HSLColor.fromAHSL(1, 20.0, 0.14, 0.04).toColor(),
			popoverForeground: const HSLColor.fromAHSL(1, 60.0, 0.09, 0.98).toColor(),
			primary: const HSLColor.fromAHSL(1, 20.5, 0.9, 0.48).toColor(),
			primaryForeground: const HSLColor.fromAHSL(1, 60.0, 0.09, 0.98).toColor(),
			secondary: const HSLColor.fromAHSL(1, 12.0, 0.07, 0.15).toColor(),
			secondaryForeground: const HSLColor.fromAHSL(1, 60.0, 0.09, 0.98).toColor(),
			muted: const HSLColor.fromAHSL(1, 12.0, 0.07, 0.15).toColor(),
			mutedForeground: const HSLColor.fromAHSL(1, 24.0, 0.05, 0.64).toColor(),
			accent: const HSLColor.fromAHSL(1, 12.0, 0.07, 0.15).toColor(),
			accentForeground: const HSLColor.fromAHSL(1, 60.0, 0.09, 0.98).toColor(),
			destructive: const HSLColor.fromAHSL(1, 0.0, 0.72, 0.51).toColor(),
			destructiveForeground: const HSLColor.fromAHSL(1, 60.0, 0.09, 0.98).toColor(),
			border: const HSLColor.fromAHSL(1, 12.0, 0.07, 0.15).toColor(),
			input: const HSLColor.fromAHSL(1, 12.0, 0.07, 0.15).toColor(),
			ring: const HSLColor.fromAHSL(1, 20.5, 0.9, 0.48).toColor(),
		);
	}

	static ColorScheme lightRed() {
		return ColorScheme(
			background: const HSLColor.fromAHSL(1, 0.0, 0.0, 1.0).toColor(),
			foreground: const HSLColor.fromAHSL(1, 0.0, 0.0, 0.04).toColor(),
			card: const HSLColor.fromAHSL(1, 0.0, 0.0, 1.0).toColor(),
			cardForeground: const HSLColor.fromAHSL(1, 0.0, 0.0, 0.04).toColor(),
			popover: const HSLColor.fromAHSL(1, 0.0, 0.0, 1.0).toColor(),
			popoverForeground: const HSLColor.fromAHSL(1, 0.0, 0.0, 0.04).toColor(),
			primary: const HSLColor.fromAHSL(1, 0.0, 0.72, 0.51).toColor(),
			primaryForeground: const HSLColor.fromAHSL(1, 0.0, 0.86, 0.97).toColor(),
			secondary: const HSLColor.fromAHSL(1, 0.0, 0.0, 0.96).toColor(),
			secondaryForeground: const HSLColor.fromAHSL(1, 0.0, 0.0, 0.09).toColor(),
			muted: const HSLColor.fromAHSL(1, 0.0, 0.0, 0.96).toColor(),
			mutedForeground: const HSLColor.fromAHSL(1, 0.0, 0.0, 0.45).toColor(),
			accent: const HSLColor.fromAHSL(1, 0.0, 0.0, 0.96).toColor(),
			accentForeground: const HSLColor.fromAHSL(1, 0.0, 0.0, 0.09).toColor(),
			destructive: const HSLColor.fromAHSL(1, 0.0, 0.84, 0.6).toColor(),
			destructiveForeground: const HSLColor.fromAHSL(1, 0.0, 0.0, 0.98).toColor(),
			border: const HSLColor.fromAHSL(1, 0.0, 0.0, 0.9).toColor(),
			input: const HSLColor.fromAHSL(1, 0.0, 0.0, 0.9).toColor(),
			ring: const HSLColor.fromAHSL(1, 0.0, 0.72, 0.51).toColor(),
		);
	}

	static ColorScheme darkRed() {
		return ColorScheme(
			background: const HSLColor.fromAHSL(1, 0.0, 0.0, 0.04).toColor(),
			foreground: const HSLColor.fromAHSL(1, 0.0, 0.0, 0.98).toColor(),
			card: const HSLColor.fromAHSL(1, 0.0, 0.0, 0.04).toColor(),
			cardForeground: const HSLColor.fromAHSL(1, 0.0, 0.0, 0.98).toColor(),
			popover: const HSLColor.fromAHSL(1, 0.0, 0.0, 0.04).toColor(),
			popoverForeground: const HSLColor.fromAHSL(1, 0.0, 0.0, 0.98).toColor(),
			primary: const HSLColor.fromAHSL(1, 0.0, 0.72, 0.51).toColor(),
			primaryForeground: const HSLColor.fromAHSL(1, 0.0, 0.86, 0.97).toColor(),
			secondary: const HSLColor.fromAHSL(1, 0.0, 0.0, 0.15).toColor(),
			secondaryForeground: const HSLColor.fromAHSL(1, 0.0, 0.0, 0.98).toColor(),
			muted: const HSLColor.fromAHSL(1, 0.0, 0.0, 0.15).toColor(),
			mutedForeground: const HSLColor.fromAHSL(1, 0.0, 0.0, 0.64).toColor(),
			accent: const HSLColor.fromAHSL(1, 0.0, 0.0, 0.15).toColor(),
			accentForeground: const HSLColor.fromAHSL(1, 0.0, 0.0, 0.98).toColor(),
			destructive: const HSLColor.fromAHSL(1, 0.0, 0.63, 0.31).toColor(),
			destructiveForeground: const HSLColor.fromAHSL(1, 0.0, 0.0, 0.98).toColor(),
			border: const HSLColor.fromAHSL(1, 0.0, 0.0, 0.15).toColor(),
			input: const HSLColor.fromAHSL(1, 0.0, 0.0, 0.15).toColor(),
			ring: const HSLColor.fromAHSL(1, 0.0, 0.72, 0.51).toColor(),
		);
	}

	static ColorScheme lightRose() {
		return ColorScheme(
			background: const HSLColor.fromAHSL(1, 0.0, 0.0, 1.0).toColor(),
			foreground: const HSLColor.fromAHSL(1, 240.0, 0.1, 0.04).toColor(),
			card: const HSLColor.fromAHSL(1, 0.0, 0.0, 1.0).toColor(),
			cardForeground: const HSLColor.fromAHSL(1, 240.0, 0.1, 0.04).toColor(),
			popover: const HSLColor.fromAHSL(1, 0.0, 0.0, 1.0).toColor(),
			popoverForeground: const HSLColor.fromAHSL(1, 240.0, 0.1, 0.04).toColor(),
			primary: const HSLColor.fromAHSL(1, 346.8, 0.77, 0.5).toColor(),
			primaryForeground: const HSLColor.fromAHSL(1, 355.7, 1.0, 0.97).toColor(),
			secondary: const HSLColor.fromAHSL(1, 240.0, 0.05, 0.96).toColor(),
			secondaryForeground: const HSLColor.fromAHSL(1, 240.0, 0.06, 0.1).toColor(),
			muted: const HSLColor.fromAHSL(1, 240.0, 0.05, 0.96).toColor(),
			mutedForeground: const HSLColor.fromAHSL(1, 240.0, 0.04, 0.46).toColor(),
			accent: const HSLColor.fromAHSL(1, 240.0, 0.05, 0.96).toColor(),
			accentForeground: const HSLColor.fromAHSL(1, 240.0, 0.06, 0.1).toColor(),
			destructive: const HSLColor.fromAHSL(1, 0.0, 0.84, 0.6).toColor(),
			destructiveForeground: const HSLColor.fromAHSL(1, 0.0, 0.0, 0.98).toColor(),
			border: const HSLColor.fromAHSL(1, 240.0, 0.06, 0.9).toColor(),
			input: const HSLColor.fromAHSL(1, 240.0, 0.06, 0.9).toColor(),
			ring: const HSLColor.fromAHSL(1, 346.8, 0.77, 0.5).toColor(),
		);
	}

	static ColorScheme darkRose() {
		return ColorScheme(
			background: const HSLColor.fromAHSL(1, 20.0, 0.14, 0.04).toColor(),
			foreground: const HSLColor.fromAHSL(1, 0.0, 0.0, 0.95).toColor(),
			card: const HSLColor.fromAHSL(1, 24.0, 0.1, 0.1).toColor(),
			cardForeground: const HSLColor.fromAHSL(1, 0.0, 0.0, 0.95).toColor(),
			popover: const HSLColor.fromAHSL(1, 0.0, 0.0, 0.09).toColor(),
			popoverForeground: const HSLColor.fromAHSL(1, 0.0, 0.0, 0.95).toColor(),
			primary: const HSLColor.fromAHSL(1, 346.8, 0.77, 0.5).toColor(),
			primaryForeground: const HSLColor.fromAHSL(1, 355.7, 1.0, 0.97).toColor(),
			secondary: const HSLColor.fromAHSL(1, 240.0, 0.04, 0.16).toColor(),
			secondaryForeground: const HSLColor.fromAHSL(1, 0.0, 0.0, 0.98).toColor(),
			muted: const HSLColor.fromAHSL(1, 0.0, 0.0, 0.15).toColor(),
			mutedForeground: const HSLColor.fromAHSL(1, 240.0, 0.05, 0.65).toColor(),
			accent: const HSLColor.fromAHSL(1, 12.0, 0.07, 0.15).toColor(),
			accentForeground: const HSLColor.fromAHSL(1, 0.0, 0.0, 0.98).toColor(),
			destructive: const HSLColor.fromAHSL(1, 0.0, 0.63, 0.31).toColor(),
			destructiveForeground: const HSLColor.fromAHSL(1, 0.0, 0.86, 0.97).toColor(),
			border: const HSLColor.fromAHSL(1, 240.0, 0.04, 0.16).toColor(),
			input: const HSLColor.fromAHSL(1, 240.0, 0.04, 0.16).toColor(),
			ring: const HSLColor.fromAHSL(1, 346.8, 0.77, 0.5).toColor(),
		);
	}

	static ColorScheme lightSlate() {
		return ColorScheme(
			background: const HSLColor.fromAHSL(1, 0.0, 0.0, 1.0).toColor(),
			foreground: const HSLColor.fromAHSL(1, 222.2, 0.84, 0.05).toColor(),
			card: const HSLColor.fromAHSL(1, 0.0, 0.0, 1.0).toColor(),
			cardForeground: const HSLColor.fromAHSL(1, 222.2, 0.84, 0.05).toColor(),
			popover: const HSLColor.fromAHSL(1, 0.0, 0.0, 1.0).toColor(),
			popoverForeground: const HSLColor.fromAHSL(1, 222.2, 0.84, 0.05).toColor(),
			primary: const HSLColor.fromAHSL(1, 222.2, 0.47, 0.11).toColor(),
			primaryForeground: const HSLColor.fromAHSL(1, 210.0, 0.4, 0.98).toColor(),
			secondary: const HSLColor.fromAHSL(1, 210.0, 0.4, 0.96).toColor(),
			secondaryForeground: const HSLColor.fromAHSL(1, 222.2, 0.47, 0.11).toColor(),
			muted: const HSLColor.fromAHSL(1, 210.0, 0.4, 0.96).toColor(),
			mutedForeground: const HSLColor.fromAHSL(1, 215.4, 0.16, 0.47).toColor(),
			accent: const HSLColor.fromAHSL(1, 210.0, 0.4, 0.96).toColor(),
			accentForeground: const HSLColor.fromAHSL(1, 222.2, 0.47, 0.11).toColor(),
			destructive: const HSLColor.fromAHSL(1, 0.0, 0.84, 0.6).toColor(),
			destructiveForeground: const HSLColor.fromAHSL(1, 210.0, 0.4, 0.98).toColor(),
			border: const HSLColor.fromAHSL(1, 214.3, 0.32, 0.91).toColor(),
			input: const HSLColor.fromAHSL(1, 214.3, 0.32, 0.91).toColor(),
			ring: const HSLColor.fromAHSL(1, 222.2, 0.84, 0.05).toColor(),
		);
	}

	static ColorScheme darkSlate() {
		return ColorScheme(
			background: const HSLColor.fromAHSL(1, 222.2, 0.84, 0.05).toColor(),
			foreground: const HSLColor.fromAHSL(1, 210.0, 0.4, 0.98).toColor(),
			card: const HSLColor.fromAHSL(1, 222.2, 0.84, 0.05).toColor(),
			cardForeground: const HSLColor.fromAHSL(1, 210.0, 0.4, 0.98).toColor(),
			popover: const HSLColor.fromAHSL(1, 222.2, 0.84, 0.05).toColor(),
			popoverForeground: const HSLColor.fromAHSL(1, 210.0, 0.4, 0.98).toColor(),
			primary: const HSLColor.fromAHSL(1, 210.0, 0.4, 0.98).toColor(),
			primaryForeground: const HSLColor.fromAHSL(1, 222.2, 0.47, 0.11).toColor(),
			secondary: const HSLColor.fromAHSL(1, 217.2, 0.33, 0.18).toColor(),
			secondaryForeground: const HSLColor.fromAHSL(1, 210.0, 0.4, 0.98).toColor(),
			muted: const HSLColor.fromAHSL(1, 217.2, 0.33, 0.18).toColor(),
			mutedForeground: const HSLColor.fromAHSL(1, 215.0, 0.2, 0.65).toColor(),
			accent: const HSLColor.fromAHSL(1, 217.2, 0.33, 0.18).toColor(),
			accentForeground: const HSLColor.fromAHSL(1, 210.0, 0.4, 0.98).toColor(),
			destructive: const HSLColor.fromAHSL(1, 0.0, 0.63, 0.31).toColor(),
			destructiveForeground: const HSLColor.fromAHSL(1, 210.0, 0.4, 0.98).toColor(),
			border: const HSLColor.fromAHSL(1, 217.2, 0.33, 0.18).toColor(),
			input: const HSLColor.fromAHSL(1, 217.2, 0.33, 0.18).toColor(),
			ring: const HSLColor.fromAHSL(1, 212.7, 0.27, 0.84).toColor(),
		);
	}

	static ColorScheme lightStone() {
		return ColorScheme(
			background: const HSLColor.fromAHSL(1, 0.0, 0.0, 1.0).toColor(),
			foreground: const HSLColor.fromAHSL(1, 20.0, 0.14, 0.04).toColor(),
			card: const HSLColor.fromAHSL(1, 0.0, 0.0, 1.0).toColor(),
			cardForeground: const HSLColor.fromAHSL(1, 20.0, 0.14, 0.04).toColor(),
			popover: const HSLColor.fromAHSL(1, 0.0, 0.0, 1.0).toColor(),
			popoverForeground: const HSLColor.fromAHSL(1, 20.0, 0.14, 0.04).toColor(),
			primary: const HSLColor.fromAHSL(1, 24.0, 0.1, 0.1).toColor(),
			primaryForeground: const HSLColor.fromAHSL(1, 60.0, 0.09, 0.98).toColor(),
			secondary: const HSLColor.fromAHSL(1, 60.0, 0.05, 0.96).toColor(),
			secondaryForeground: const HSLColor.fromAHSL(1, 24.0, 0.1, 0.1).toColor(),
			muted: const HSLColor.fromAHSL(1, 60.0, 0.05, 0.96).toColor(),
			mutedForeground: const HSLColor.fromAHSL(1, 25.0, 0.05, 0.45).toColor(),
			accent: const HSLColor.fromAHSL(1, 60.0, 0.05, 0.96).toColor(),
			accentForeground: const HSLColor.fromAHSL(1, 24.0, 0.1, 0.1).toColor(),
			destructive: const HSLColor.fromAHSL(1, 0.0, 0.84, 0.6).toColor(),
			destructiveForeground: const HSLColor.fromAHSL(1, 60.0, 0.09, 0.98).toColor(),
			border: const HSLColor.fromAHSL(1, 20.0, 0.06, 0.9).toColor(),
			input: const HSLColor.fromAHSL(1, 20.0, 0.06, 0.9).toColor(),
			ring: const HSLColor.fromAHSL(1, 20.0, 0.14, 0.04).toColor(),
		);
	}

	static ColorScheme darkStone() {
		return ColorScheme(
			background: const HSLColor.fromAHSL(1, 20.0, 0.14, 0.04).toColor(),
			foreground: const HSLColor.fromAHSL(1, 60.0, 0.09, 0.98).toColor(),
			card: const HSLColor.fromAHSL(1, 20.0, 0.14, 0.04).toColor(),
			cardForeground: const HSLColor.fromAHSL(1, 60.0, 0.09, 0.98).toColor(),
			popover: const HSLColor.fromAHSL(1, 20.0, 0.14, 0.04).toColor(),
			popoverForeground: const HSLColor.fromAHSL(1, 60.0, 0.09, 0.98).toColor(),
			primary: const HSLColor.fromAHSL(1, 60.0, 0.09, 0.98).toColor(),
			primaryForeground: const HSLColor.fromAHSL(1, 24.0, 0.1, 0.1).toColor(),
			secondary: const HSLColor.fromAHSL(1, 12.0, 0.07, 0.15).toColor(),
			secondaryForeground: const HSLColor.fromAHSL(1, 60.0, 0.09, 0.98).toColor(),
			muted: const HSLColor.fromAHSL(1, 12.0, 0.07, 0.15).toColor(),
			mutedForeground: const HSLColor.fromAHSL(1, 24.0, 0.05, 0.64).toColor(),
			accent: const HSLColor.fromAHSL(1, 12.0, 0.07, 0.15).toColor(),
			accentForeground: const HSLColor.fromAHSL(1, 60.0, 0.09, 0.98).toColor(),
			destructive: const HSLColor.fromAHSL(1, 0.0, 0.63, 0.31).toColor(),
			destructiveForeground: const HSLColor.fromAHSL(1, 60.0, 0.09, 0.98).toColor(),
			border: const HSLColor.fromAHSL(1, 12.0, 0.07, 0.15).toColor(),
			input: const HSLColor.fromAHSL(1, 12.0, 0.07, 0.15).toColor(),
			ring: const HSLColor.fromAHSL(1, 24.0, 0.06, 0.83).toColor(),
		);
	}

	static ColorScheme lightViolet() {
		return ColorScheme(
			background: const HSLColor.fromAHSL(1, 0.0, 0.0, 1.0).toColor(),
			foreground: const HSLColor.fromAHSL(1, 224.0, 0.71, 0.04).toColor(),
			card: const HSLColor.fromAHSL(1, 0.0, 0.0, 1.0).toColor(),
			cardForeground: const HSLColor.fromAHSL(1, 224.0, 0.71, 0.04).toColor(),
			popover: const HSLColor.fromAHSL(1, 0.0, 0.0, 1.0).toColor(),
			popoverForeground: const HSLColor.fromAHSL(1, 224.0, 0.71, 0.04).toColor(),
			primary: const HSLColor.fromAHSL(1, 262.1, 0.83, 0.58).toColor(),
			primaryForeground: const HSLColor.fromAHSL(1, 210.0, 0.2, 0.98).toColor(),
			secondary: const HSLColor.fromAHSL(1, 220.0, 0.14, 0.96).toColor(),
			secondaryForeground: const HSLColor.fromAHSL(1, 220.9, 0.39, 0.11).toColor(),
			muted: const HSLColor.fromAHSL(1, 220.0, 0.14, 0.96).toColor(),
			mutedForeground: const HSLColor.fromAHSL(1, 220.0, 0.09, 0.46).toColor(),
			accent: const HSLColor.fromAHSL(1, 220.0, 0.14, 0.96).toColor(),
			accentForeground: const HSLColor.fromAHSL(1, 220.9, 0.39, 0.11).toColor(),
			destructive: const HSLColor.fromAHSL(1, 0.0, 0.84, 0.6).toColor(),
			destructiveForeground: const HSLColor.fromAHSL(1, 210.0, 0.2, 0.98).toColor(),
			border: const HSLColor.fromAHSL(1, 220.0, 0.13, 0.91).toColor(),
			input: const HSLColor.fromAHSL(1, 220.0, 0.13, 0.91).toColor(),
			ring: const HSLColor.fromAHSL(1, 262.1, 0.83, 0.58).toColor(),
		);
	}

	static ColorScheme darkViolet() {
		return ColorScheme(
			background: const HSLColor.fromAHSL(1, 224.0, 0.71, 0.04).toColor(),
			foreground: const HSLColor.fromAHSL(1, 210.0, 0.2, 0.98).toColor(),
			card: const HSLColor.fromAHSL(1, 224.0, 0.71, 0.04).toColor(),
			cardForeground: const HSLColor.fromAHSL(1, 210.0, 0.2, 0.98).toColor(),
			popover: const HSLColor.fromAHSL(1, 224.0, 0.71, 0.04).toColor(),
			popoverForeground: const HSLColor.fromAHSL(1, 210.0, 0.2, 0.98).toColor(),
			primary: const HSLColor.fromAHSL(1, 263.4, 0.7, 0.5).toColor(),
			primaryForeground: const HSLColor.fromAHSL(1, 210.0, 0.2, 0.98).toColor(),
			secondary: const HSLColor.fromAHSL(1, 215.0, 0.28, 0.17).toColor(),
			secondaryForeground: const HSLColor.fromAHSL(1, 210.0, 0.2, 0.98).toColor(),
			muted: const HSLColor.fromAHSL(1, 215.0, 0.28, 0.17).toColor(),
			mutedForeground: const HSLColor.fromAHSL(1, 217.9, 0.11, 0.65).toColor(),
			accent: const HSLColor.fromAHSL(1, 215.0, 0.28, 0.17).toColor(),
			accentForeground: const HSLColor.fromAHSL(1, 210.0, 0.2, 0.98).toColor(),
			destructive: const HSLColor.fromAHSL(1, 0.0, 0.63, 0.31).toColor(),
			destructiveForeground: const HSLColor.fromAHSL(1, 210.0, 0.2, 0.98).toColor(),
			border: const HSLColor.fromAHSL(1, 215.0, 0.28, 0.17).toColor(),
			input: const HSLColor.fromAHSL(1, 215.0, 0.28, 0.17).toColor(),
			ring: const HSLColor.fromAHSL(1, 263.4, 0.7, 0.5).toColor(),
		);
	}

	static ColorScheme lightYellow() {
		return ColorScheme(
			background: const HSLColor.fromAHSL(1, 0.0, 0.0, 1.0).toColor(),
			foreground: const HSLColor.fromAHSL(1, 20.0, 0.14, 0.04).toColor(),
			card: const HSLColor.fromAHSL(1, 0.0, 0.0, 1.0).toColor(),
			cardForeground: const HSLColor.fromAHSL(1, 20.0, 0.14, 0.04).toColor(),
			popover: const HSLColor.fromAHSL(1, 0.0, 0.0, 1.0).toColor(),
			popoverForeground: const HSLColor.fromAHSL(1, 20.0, 0.14, 0.04).toColor(),
			primary: const HSLColor.fromAHSL(1, 47.9, 0.96, 0.53).toColor(),
			primaryForeground: const HSLColor.fromAHSL(1, 26.0, 0.83, 0.14).toColor(),
			secondary: const HSLColor.fromAHSL(1, 60.0, 0.05, 0.96).toColor(),
			secondaryForeground: const HSLColor.fromAHSL(1, 24.0, 0.1, 0.1).toColor(),
			muted: const HSLColor.fromAHSL(1, 60.0, 0.05, 0.96).toColor(),
			mutedForeground: const HSLColor.fromAHSL(1, 25.0, 0.05, 0.45).toColor(),
			accent: const HSLColor.fromAHSL(1, 60.0, 0.05, 0.96).toColor(),
			accentForeground: const HSLColor.fromAHSL(1, 24.0, 0.1, 0.1).toColor(),
			destructive: const HSLColor.fromAHSL(1, 0.0, 0.84, 0.6).toColor(),
			destructiveForeground: const HSLColor.fromAHSL(1, 60.0, 0.09, 0.98).toColor(),
			border: const HSLColor.fromAHSL(1, 20.0, 0.06, 0.9).toColor(),
			input: const HSLColor.fromAHSL(1, 20.0, 0.06, 0.9).toColor(),
			ring: const HSLColor.fromAHSL(1, 20.0, 0.14, 0.04).toColor(),
		);
	}

	static ColorScheme darkYellow() {
		return ColorScheme(
			background: const HSLColor.fromAHSL(1, 20.0, 0.14, 0.04).toColor(),
			foreground: const HSLColor.fromAHSL(1, 60.0, 0.09, 0.98).toColor(),
			card: const HSLColor.fromAHSL(1, 20.0, 0.14, 0.04).toColor(),
			cardForeground: const HSLColor.fromAHSL(1, 60.0, 0.09, 0.98).toColor(),
			popover: const HSLColor.fromAHSL(1, 20.0, 0.14, 0.04).toColor(),
			popoverForeground: const HSLColor.fromAHSL(1, 60.0, 0.09, 0.98).toColor(),
			primary: const HSLColor.fromAHSL(1, 47.9, 0.96, 0.53).toColor(),
			primaryForeground: const HSLColor.fromAHSL(1, 26.0, 0.83, 0.14).toColor(),
			secondary: const HSLColor.fromAHSL(1, 12.0, 0.07, 0.15).toColor(),
			secondaryForeground: const HSLColor.fromAHSL(1, 60.0, 0.09, 0.98).toColor(),
			muted: const HSLColor.fromAHSL(1, 12.0, 0.07, 0.15).toColor(),
			mutedForeground: const HSLColor.fromAHSL(1, 24.0, 0.05, 0.64).toColor(),
			accent: const HSLColor.fromAHSL(1, 12.0, 0.07, 0.15).toColor(),
			accentForeground: const HSLColor.fromAHSL(1, 60.0, 0.09, 0.98).toColor(),
			destructive: const HSLColor.fromAHSL(1, 0.0, 0.63, 0.31).toColor(),
			destructiveForeground: const HSLColor.fromAHSL(1, 60.0, 0.09, 0.98).toColor(),
			border: const HSLColor.fromAHSL(1, 12.0, 0.07, 0.15).toColor(),
			input: const HSLColor.fromAHSL(1, 12.0, 0.07, 0.15).toColor(),
			ring: const HSLColor.fromAHSL(1, 35.5, 0.92, 0.33).toColor(),
		);
	}

	static ColorScheme lightZync() {
		return ColorScheme(
			background: const HSLColor.fromAHSL(1, 0.0, 0.0, 1.0).toColor(),
			foreground: const HSLColor.fromAHSL(1, 240.0, 0.1, 0.04).toColor(),
			card: const HSLColor.fromAHSL(1, 0.0, 0.0, 1.0).toColor(),
			cardForeground: const HSLColor.fromAHSL(1, 240.0, 0.1, 0.04).toColor(),
			popover: const HSLColor.fromAHSL(1, 0.0, 0.0, 1.0).toColor(),
			popoverForeground: const HSLColor.fromAHSL(1, 240.0, 0.1, 0.04).toColor(),
			primary: const HSLColor.fromAHSL(1, 240.0, 0.06, 0.1).toColor(),
			primaryForeground: const HSLColor.fromAHSL(1, 0.0, 0.0, 0.98).toColor(),
			secondary: const HSLColor.fromAHSL(1, 240.0, 0.05, 0.96).toColor(),
			secondaryForeground: const HSLColor.fromAHSL(1, 240.0, 0.06, 0.1).toColor(),
			muted: const HSLColor.fromAHSL(1, 240.0, 0.05, 0.96).toColor(),
			mutedForeground: const HSLColor.fromAHSL(1, 240.0, 0.04, 0.46).toColor(),
			accent: const HSLColor.fromAHSL(1, 240.0, 0.05, 0.96).toColor(),
			accentForeground: const HSLColor.fromAHSL(1, 240.0, 0.06, 0.1).toColor(),
			destructive: const HSLColor.fromAHSL(1, 0.0, 0.84, 0.6).toColor(),
			destructiveForeground: const HSLColor.fromAHSL(1, 0.0, 0.0, 0.98).toColor(),
			border: const HSLColor.fromAHSL(1, 240.0, 0.06, 0.9).toColor(),
			input: const HSLColor.fromAHSL(1, 240.0, 0.06, 0.9).toColor(),
			ring: const HSLColor.fromAHSL(1, 240.0, 0.06, 0.1).toColor(),
		);
	}

	static ColorScheme darkZync() {
		return ColorScheme(
			background: const HSLColor.fromAHSL(1, 240.0, 0.1, 0.04).toColor(),
			foreground: const HSLColor.fromAHSL(1, 0.0, 0.0, 0.98).toColor(),
			card: const HSLColor.fromAHSL(1, 240.0, 0.1, 0.04).toColor(),
			cardForeground: const HSLColor.fromAHSL(1, 0.0, 0.0, 0.98).toColor(),
			popover: const HSLColor.fromAHSL(1, 240.0, 0.1, 0.04).toColor(),
			popoverForeground: const HSLColor.fromAHSL(1, 0.0, 0.0, 0.98).toColor(),
			primary: const HSLColor.fromAHSL(1, 0.0, 0.0, 0.98).toColor(),
			primaryForeground: const HSLColor.fromAHSL(1, 240.0, 0.06, 0.1).toColor(),
			secondary: const HSLColor.fromAHSL(1, 240.0, 0.04, 0.16).toColor(),
			secondaryForeground: const HSLColor.fromAHSL(1, 0.0, 0.0, 0.98).toColor(),
			muted: const HSLColor.fromAHSL(1, 240.0, 0.04, 0.16).toColor(),
			mutedForeground: const HSLColor.fromAHSL(1, 240.0, 0.05, 0.65).toColor(),
			accent: const HSLColor.fromAHSL(1, 240.0, 0.04, 0.16).toColor(),
			accentForeground: const HSLColor.fromAHSL(1, 0.0, 0.0, 0.98).toColor(),
			destructive: const HSLColor.fromAHSL(1, 0.0, 0.63, 0.31).toColor(),
			destructiveForeground: const HSLColor.fromAHSL(1, 0.0, 0.0, 0.98).toColor(),
			border: const HSLColor.fromAHSL(1, 240.0, 0.04, 0.16).toColor(),
			input: const HSLColor.fromAHSL(1, 240.0, 0.04, 0.16).toColor(),
			ring: const HSLColor.fromAHSL(1, 240.0, 0.05, 0.84).toColor(),
		);
	}

}