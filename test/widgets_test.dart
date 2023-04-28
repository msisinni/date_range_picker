import 'package:flutter/material.dart';
import 'package:flutter_date_range_picker/flutter_date_range_picker.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('DayNamesRow Widget', () {
    testWidgets('renders correctly with default week days',
        (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: DayNamesRow(textStyle: kTheme.dayNameTextStyle),
        ),
      ));

      for (var day in defaultWeekDays()) {
        expect(find.text(day), findsOneWidget);
      }
    });
  });

  group('DateTimeRangePickerWidget', () {
    testWidgets('renders correctly and initializes with initial dateRange',
        (WidgetTester tester) async {
      final initialDateTimeRange = DateTimeRange(start: DateTime(2023, 1, 1),end: DateTime(2023, 1, 5));
      final minDate = DateTime(2022, 1, 1);
      final maxDate = DateTime(2023, 12, 31);

      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: DateTimeRangePickerWidget(
            initialDateTimeRange: initialDateTimeRange,
            minDate: minDate,
            maxDate: maxDate,
            onDateTimeRangeChanged: (DateTimeRange? dateRange) {},
          ),
        ),
      ));

      expect(find.byType(DateTimeRangePickerWidget), findsOneWidget);
      expect(find.byType(MonthSelectorAndDoubleIndicator), findsOneWidget);
      expect(find.byType(DayNamesRow), findsNWidgets(2));
      expect(find.byType(MonthWrapWidget), findsNWidgets(2));
      expect(find.byType(DayTileWidget), findsWidgets);
    });
  });
}
