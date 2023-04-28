import 'package:flutter/material.dart';

/// A function that builds a widget that will be used to display the selected date range.
typedef DateTimeRangerPickerWidgetBuilder = Widget Function(
  BuildContext context,
  void Function(DateTimeRange? dateRange) onDateTimeRangeChanged,
);
