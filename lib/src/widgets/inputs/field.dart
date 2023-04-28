import 'package:flutter/material.dart';
import 'package:flutter_date_range_picker/flutter_date_range_picker.dart';
import 'package:flutter_date_range_picker/src/widgets/typedefs.dart';

/// A [StatelessWidget] that provides a field to select a date range dateRange.
class DateTimeRangeField extends StatelessWidget {
  /// Creates a [DateTimeRangeField].
  ///
  /// * [decoration] - The decoration to show around the field. If null, defaults to [InputDecoration].
  /// * [selectedDateTimeRange] - The selected date range for the field.
  /// * [onDateTimeRangeSelected] - Called when a date range is selected.
  /// * [childBuilder] - A builder to construct the child widget of the field.
  /// * [enabled] - Whether the field is enabled or not.
  /// * [pickerBuilder] - A builder to construct the date range picker widget.
  /// * [dialogFooterBuilder] - A builder to construct the footer widget of the dialog.
  /// * [showDateTimeRangePicker] - A function to show the date range picker dialog, defaults to [showDateTimeRangePickerDialogOnWidget].
  const DateTimeRangeField({
    Key? key,
    this.decoration,
    this.selectedDateTimeRange,
    this.onDateTimeRangeSelected,
    this.childBuilder,
    this.dialogFooterBuilder,
    this.enabled = true,
    required this.pickerBuilder,
    this.showDateTimeRangePicker = showDateTimeRangePickerDialogOnWidget,
  }) : super(key: key);

  final Widget Function({DateTimeRange? selectedDateTimeRange})? dialogFooterBuilder;
  final DateTimeRangerPickerWidgetBuilder pickerBuilder;
  final InputDecoration? decoration;
  final bool enabled;
  final DateTimeRange? selectedDateTimeRange;
  final ValueChanged<DateTimeRange?>? onDateTimeRangeSelected;
  final Widget Function(BuildContext, DateTimeRange?)? childBuilder;
  final Future<DateTimeRange?> Function({
    required BuildContext widgetContext,
    required DateTimeRangerPickerWidgetBuilder pickerBuilder,
  }) showDateTimeRangePicker;

  @override
  Widget build(BuildContext context) {
    var inputDecoration = (decoration ?? const InputDecoration()).applyDefaults(
      Theme.of(context).inputDecorationTheme,
    );

    return InkWell(
      onTap: generateOnTap(context),
      child: InputDecorator(
        decoration: inputDecoration,
        isEmpty: selectedDateTimeRange == null,
        child: childBuilder?.call(context, selectedDateTimeRange) ??
            Text(
              selectedDateTimeRange?.toString() ?? '',
            ),
      ),
    );
  }

  VoidCallback? generateOnTap(BuildContext context) {
    if (enabled) {
      return () async {
        final DateTimeRange? dateRange = await showDateTimeRangePicker(
          widgetContext: context,
          pickerBuilder: pickerBuilder,
        );

        onDateTimeRangeSelected?.call(dateRange);
      };
    } else {
      return null;
    }
  }
}
