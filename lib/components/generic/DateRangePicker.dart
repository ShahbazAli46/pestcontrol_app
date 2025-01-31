import 'package:accurate/utils/TextStyle.dart';
import 'package:accurate/utils/appColors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateRangePicker extends StatefulWidget {
  final Function(String, String) onDateRangeChanged;

  const DateRangePicker({
    Key? key,
    required this.onDateRangeChanged,
  }) : super(key: key);

  @override
  State<DateRangePicker> createState() => _DateRangePickerState();
}

class _DateRangePickerState extends State<DateRangePicker> {
  late DateTime fromDate;
  late DateTime toDate;
  late DateTime currentDate;

  @override
  void initState() {
    super.initState();
    currentDate = DateTime.now();
    fromDate = currentDate;
    toDate = currentDate;
  }

  void _previousFromDay() {
    setState(() {
      fromDate = fromDate.subtract(const Duration(days: 1));
      if (fromDate.isAfter(toDate)) {
        toDate = fromDate;
      }
      _notifyDateChange();
    });
  }

  void _nextFromDay() {
    if (fromDate.isBefore(currentDate)) {
      setState(() {
        fromDate = fromDate.add(const Duration(days: 1));
        if (fromDate.isAfter(toDate)) {
          toDate = fromDate;
        }
        _notifyDateChange();
      });
    }
  }

  void _previousToDay() {
    if (toDate.isAfter(fromDate)) {
      setState(() {
        toDate = toDate.subtract(const Duration(days: 1));
        _notifyDateChange();
      });
    }
  }

  void _nextToDay() {
    if (toDate.isBefore(currentDate)) {
      setState(() {
        toDate = toDate.add(const Duration(days: 1));
        _notifyDateChange();
      });
    }
  }

  void _notifyDateChange() {
    widget.onDateRangeChanged(_formatDate(fromDate), _formatDate(toDate));
  }

  String _formatDate(DateTime date) {
    return DateFormat('yyyy-MM-dd').format(date);
  }

  String _formatDisplayDate(DateTime date) {
    return DateFormat('dd MMM yyyy').format(date);
  }

  Widget _buildDateSelector({
    required String label,
    required DateTime selectedDate,
    required VoidCallback onPrevious,
    required VoidCallback onNext,
    required bool canGoNext,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16, bottom: 8),
          child: AppTextLabels.boldTextShort(
            label: label,
            color: AppColors.appGreen,
            fontSize: 14,
          ),
        ),
        Container(
          height: 50,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 1,
                blurRadius: 2,
                offset: const Offset(0, 1),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                icon: const Icon(Icons.chevron_left),
                onPressed: onPrevious,
              ),
              AppTextLabels.boldTextShort(
                label: _formatDisplayDate(selectedDate),
                color: AppColors.appGreen,
                fontSize: 16,
              ),
              IconButton(
                icon: const Icon(Icons.chevron_right),
                onPressed: canGoNext ? onNext : null,
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildDateSelector(
          label: 'From Date',
          selectedDate: fromDate,
          onPrevious: _previousFromDay,
          onNext: _nextFromDay,
          canGoNext: fromDate.isBefore(currentDate),
        ),
        const SizedBox(height: 16),
        _buildDateSelector(
          label: 'To Date',
          selectedDate: toDate,
          onPrevious: _previousToDay,
          onNext: _nextToDay,
          canGoNext: toDate.isBefore(currentDate),
        ),
      ],
    );
  }
}