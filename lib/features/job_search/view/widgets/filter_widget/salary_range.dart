import 'package:flutter/material.dart';

class SalaryRangeFilterWidget extends StatefulWidget {
  const SalaryRangeFilterWidget({super.key});

  @override
  _SalaryRangeFilterWidgetState createState() =>
      _SalaryRangeFilterWidgetState();
}

class _SalaryRangeFilterWidgetState extends State<SalaryRangeFilterWidget> {
  RangeValues _currentRangeValues = const RangeValues(50000, 120000);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text('Salary Range', style: TextStyle(fontSize: 16)),
        const SizedBox(height: 8),
        RangeSlider(
          values: _currentRangeValues,
          min: 0,
          max: 250000,
          divisions: 50,
          labels: RangeLabels(
            '\$${_currentRangeValues.start.round()}',
            '\$${_currentRangeValues.end.round()}',
          ),
          onChanged: (RangeValues values) {
            setState(() {
              _currentRangeValues = values;
            });
          },
        ),
        const SizedBox(height: 8),
        Text(
            'Range: \$${_currentRangeValues.start.round()} - \$${_currentRangeValues.end.round()}'),
      ],
    );
  }
}
