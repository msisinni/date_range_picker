import 'package:flutter_date_range_picker/flutter_date_range_picker.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Date range picker example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Date range picker example'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  DateTimeRange? selectedDateTimeRange;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: DefaultTabController(
          length: 3,
          child: TabBarView(
            children: <Widget>[
              Column(
                children: [
                  const SizedBox(height: 100),
                  const Text("The simple field example:"),
                  Container(
                    padding: const EdgeInsets.all(8),
                    width: 250,
                    child: DateTimeRangeField(
                      decoration: const InputDecoration(
                        label: Text("Date range picker"),
                        hintText: 'Please select a date range',
                      ),
                      onDateTimeRangeSelected: (DateTimeRange? value) {
                        setState(() {
                          selectedDateTimeRange = value;
                        });
                      },
                      selectedDateTimeRange: selectedDateTimeRange,
                      pickerBuilder: datePickerBuilder,
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  const SizedBox(height: 100),
                  const Text("The simple form field example:"),
                  Container(
                    padding: const EdgeInsets.all(8),
                    width: 250,
                    child: DateTimeRangeFormField(
                      decoration: const InputDecoration(
                        label: Text("Date range picker"),
                        hintText: 'Please select a date range',
                      ),
                      pickerBuilder: (x, y) => datePickerBuilder(x, y, false),
                    ),
                  )
                ],
              ),
              SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 50),
                    const Text("The decomposed widgets example :"),
                    const SizedBox(height: 20),
                    const Text("The date range picker widget:"),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: 560,
                      child: DateTimeRangePickerWidget(
                        maximumDateTimeRangeLength: 10,
                        minimumDateTimeRangeLength: 3,
                        disabledDates: [DateTime(2023, 11, 20)],
                        initialDisplayedDate: DateTime(2023, 11, 20),
                        onDateTimeRangeChanged: print,
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text("The month selector:"),
                    SizedBox(
                      width: 450,
                      child: MonthSelectorAndDoubleIndicator(
                        currentMonth: DateTime(2023, 11, 20),
                        onNext: () => debugPrint("Next"),
                        onPrevious: () => debugPrint("Previous"),
                        nextMonth: DateTime(2023, 12, 20),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text("A button to open the picker:"),
                    TextButton(
                      onPressed: () => showDateTimeRangePickerDialog(context: context, builder: datePickerBuilder),
                      child: const Text("Open the picker"),
                    ),
                    const SizedBox(height: 20),
                    const Text("The quick dateRanges:"),
                    SizedBox(
                      width: 250,
                      height: 100,
                      child: QuickSelectorWidget(
                          selectedDateTimeRange: selectedDateTimeRange,
                          quickDateTimeRanges: [
                            QuickDateTimeRange(
                              label: 'Last 3 days',
                              dateRange: DateTimeRange(
                                start: DateTime.now().subtract(const Duration(days: 3)),
                                end: DateTime.now(),
                              ),
                            ),
                            QuickDateTimeRange(
                              label: 'Last 7 days',
                              dateRange: DateTimeRange(
                                start: DateTime.now().subtract(const Duration(days: 7)),
                                end: DateTime.now(),
                              ),
                            ),
                            QuickDateTimeRange(
                              label: 'Last 30 days',
                              dateRange: DateTimeRange(
                                start: DateTime.now().subtract(const Duration(days: 30)),
                                end: DateTime.now(),
                              ),
                            ),
                            QuickDateTimeRange(
                              label: 'Last 90 days',
                              dateRange: DateTimeRange(
                                start: DateTime.now().subtract(const Duration(days: 90)),
                                end: DateTime.now(),
                              ),
                            ),
                            QuickDateTimeRange(
                              label: 'Last 180 days',
                              dateRange: DateTimeRange(
                                start: DateTime.now().subtract(const Duration(days: 180)),
                                end: DateTime.now(),
                              ),
                            ),
                          ],
                          onDateTimeRangeChanged: print,
                          theme: kTheme),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget datePickerBuilder(BuildContext context, dynamic Function(DateTimeRange?) onDateTimeRangeChanged,
          [bool doubleMonth = true]) =>
      DateTimeRangePickerWidget(
        doubleMonth: doubleMonth,
        maximumDateTimeRangeLength: 10,
        quickDateTimeRanges: [
          QuickDateTimeRange(dateRange: null, label: "Remove date range"),
          QuickDateTimeRange(
            label: 'Last 3 days',
            dateRange: DateTimeRange(
              start: DateTime.now().subtract(const Duration(days: 3)),
              end: DateTime.now(),
            ),
          ),
          QuickDateTimeRange(
            label: 'Last 7 days',
            dateRange: DateTimeRange(
              start: DateTime.now().subtract(const Duration(days: 7)),
              end: DateTime.now(),
            ),
          ),
          QuickDateTimeRange(
            label: 'Last 30 days',
            dateRange: DateTimeRange(
              start: DateTime.now().subtract(const Duration(days: 30)),
              end: DateTime.now(),
            ),
          ),
          QuickDateTimeRange(
            label: 'Last 90 days',
            dateRange: DateTimeRange(
              start: DateTime.now().subtract(const Duration(days: 90)),
              end: DateTime.now(),
            ),
          ),
          QuickDateTimeRange(
            label: 'Last 180 days',
            dateRange: DateTimeRange(
              start: DateTime.now().subtract(const Duration(days: 180)),
              end: DateTime.now(),
            ),
          ),
        ],
        minimumDateTimeRangeLength: 3,
        initialDateTimeRange: selectedDateTimeRange,
        disabledDates: [DateTime(2023, 11, 20)],
        initialDisplayedDate: selectedDateTimeRange?.start ?? DateTime(2023, 11, 20),
        onDateTimeRangeChanged: onDateTimeRangeChanged,
      );
}
