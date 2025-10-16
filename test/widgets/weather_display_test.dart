import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_testing_lab/widgets/weather_display.dart';

import '../test_utils/test_wrapper.dart';

void main() {
  group('WeatherDisplay Testing', () {
    /// Loading State
    testWidgets('displays loading indicator initially', (tester) async {
      await tester.pumpWidget(TestWrapper(child: WeatherDisplay()));
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      await tester.pumpAndSettle();
    });

    /// Success Display
    testWidgets('displays weather card after loading', (tester) async {
      await tester.pumpWidget(TestWrapper(child: WeatherDisplay()));
      await tester.pump(const Duration(seconds: 2));
      await tester.pumpAndSettle();
      expect(find.byType(Card), findsWidgets);

      /// °C or °F
      final celsiusFinder = find.textContaining('°C');
      final fahrenheitFinder = find.textContaining('°F');
      expect(
        celsiusFinder.evaluate().isNotEmpty ||
            fahrenheitFinder.evaluate().isNotEmpty,
        isTrue,
        reason: 'Should display either °C or °F after loading',
      );
    });

    /// Change City & Refresh through Dropdown
    testWidgets('select a different city and refresh', (tester) async {
      await tester.pumpWidget(TestWrapper(child: WeatherDisplay()));
      await tester.pump(const Duration(seconds: 2));
      await tester.pumpAndSettle();
      await tester.tap(find.byType(DropdownButton<String>));
      await tester.pumpAndSettle();
      await tester.tap(find.text('London').last);
      await tester.pump(); /// setState
      await tester.pump(const Duration(seconds: 2));
      await tester.pumpAndSettle();
      expect(find.text('London'), findsWidgets);
    });

    /// Error State
    testWidgets('shows error for invalid city', ( tester) async {
      await tester.pumpWidget(TestWrapper(child: WeatherDisplay()));
      await tester.pump(const Duration(seconds: 2));
      await tester.pumpAndSettle();

      await tester.tap(find.byType(DropdownButton<String>));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Invalid City').last);
      await tester.pump();
      await tester.pump(const Duration(seconds: 2));
      await tester.pumpAndSettle();
      expect(
        find.textContaining('Failed to load weather data'),
        findsOneWidget,
      );
      expect(find.byIcon(Icons.error_outline), findsOneWidget);
    });

    /// Refresh Button
    testWidgets('refresh button triggers reload', (WidgetTester tester) async {
      await tester.pumpWidget(TestWrapper(child: WeatherDisplay()));
      await tester.pump(const Duration(seconds: 2));
      await tester.pumpAndSettle();

      final refreshButton = find.widgetWithText(ElevatedButton, 'Refresh');
      expect(refreshButton, findsOneWidget);

      await tester.tap(refreshButton);
      await tester.pump();
      await tester.pump(const Duration(seconds: 2));
      await tester.pumpAndSettle();
      expect(find.byType(CircularProgressIndicator), findsNothing);
    });
  });
}
