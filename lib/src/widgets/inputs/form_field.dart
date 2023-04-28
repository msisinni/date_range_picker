import 'package:flutter/material.dart';
import 'package:flutter_date_range_picker/flutter_date_range_picker.dart';
import 'package:flutter_date_range_picker/src/widgets/typedefs.dart';

/// A [FormField] that wraps a [DateTimeRangeField] and integrates with a form.
class DateTimeRangeFormField extends FormField<DateTimeRange> {
  /// Creates a [DateTimeRangeFormField].
  ///
  /// * [decoration] - The decoration to show around the field. If null, defaults to [InputDecoration].
  /// * [enabled] - Whether the field is enabled or not.
  /// * [initialValue] - The initial [DateTimeRange] for the field.
  /// * [pickerBuilder] - A builder to construct the date range picker widget.
  /// * [onSaved] - Called when the form is saved.
  /// * [validator] - Called to validate the field value when the form is submitted.
  /// * [builder] - A builder to construct the child widget of the field.
  /// * [dialogFooterBuilder] - A builder to construct the footer widget of the dialog.
  /// * [showDateTimeRangePicker] - A function to show the date range picker dialog, defaults to [showDateTimeRangePickerDialogOnWidget].
  DateTimeRangeFormField({
    Key? key,
    InputDecoration? decoration,
    bool enabled = true,
    DateTimeRange? initialValue,
    required DateTimeRangerPickerWidgetBuilder pickerBuilder,
    FormFieldSetter<DateTimeRange>? onSaved,
    FormFieldValidator<DateTimeRange>? validator,
    Future<DateTimeRange?> Function({
      required BuildContext widgetContext,
      required DateTimeRangerPickerWidgetBuilder pickerBuilder,
    })
        showDateTimeRangePicker = showDateTimeRangePickerDialogOnWidget,
    Widget Function({DateTimeRange? selectedDateTimeRange})? dialogFooterBuilder,
    Widget Function(BuildContext, DateTimeRange?)? builder,
  }) : super(
          key: key,
          initialValue: initialValue ?? DateTimeRange(start: DateTime.now(), end: DateTime.now()),
          onSaved: onSaved,
          validator: validator,
          builder: (FormFieldState<DateTimeRange> state) {
            final selectedDateTimeRange = state.value;
            final inputDecoration = (decoration ?? const InputDecoration()).applyDefaults(
              Theme.of(state.context).inputDecorationTheme,
            );

            return DateTimeRangeField(
              showDateTimeRangePicker: showDateTimeRangePicker,
              dialogFooterBuilder: dialogFooterBuilder,
              decoration: inputDecoration.copyWith(errorText: state.errorText),
              enabled: enabled,
              selectedDateTimeRange: selectedDateTimeRange,
              onDateTimeRangeSelected: enabled
                  ? (dateRange) {
                      state.didChange(dateRange);
                    }
                  : null,
              childBuilder: builder,
              pickerBuilder: pickerBuilder,
            );
          },
        );
}
