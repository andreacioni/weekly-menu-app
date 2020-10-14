import 'package:flutter/material.dart';

import 'package:flutter_date_pickers/flutter_date_pickers.dart';
import 'package:weekly_menu_app/globals/date.dart';
import '../../globals/utils.dart' as utils;

class DateRangePicker extends StatefulWidget {
  final DatePeriod selectedPeriod;
  final Function(DatePeriod) onChanged;
  final DatePickerRangeStyles datePickerStyles;
  final Date firstDate;
  final Date lastDate;

  DateRangePicker({
    this.datePickerStyles,
    this.selectedPeriod,
    this.onChanged,
    this.firstDate,
    this.lastDate,
  });

  @override
  _DateRangePickerState createState() => _DateRangePickerState();
}

class _DateRangePickerState extends State<DateRangePicker> {
  DatePeriod selectedPeriod;

  @override
  void initState() {
    selectedPeriod = widget.selectedPeriod;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RangePicker(
      selectedPeriod: _dateTimePeriodToDatePeriod(selectedPeriod),
      onChanged: (dp) {
        dp = _dateTimePeriodToDatePeriod(dp);
        setState(() {
          selectedPeriod = dp;
        });
        widget.onChanged(dp);
      },
      firstDate: widget.firstDate.toDateTime,
      lastDate: widget.lastDate.toDateTime,
      datePickerStyles: widget.datePickerStyles,
    );
  }

  DatePeriod _dateTimePeriodToDatePeriod(DatePeriod dp) {
    return DatePeriod(dp.start, dp.end);
  }
}
