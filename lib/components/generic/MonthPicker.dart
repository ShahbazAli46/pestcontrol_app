import 'package:accurate/utils/TextStyle.dart';
import 'package:accurate/utils/appColors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MonthPicker extends StatefulWidget {
  final Function(String) onMonthChanged;

  const MonthPicker({
    Key? key,
    required this.onMonthChanged,
  }) : super(key: key);

  @override
  State<MonthPicker> createState() => _MonthPickerState();
}

class _MonthPickerState extends State<MonthPicker> {
  late DateTime selectedDate;
  late DateTime currentDate;

  @override
  void initState() {
    super.initState();
    selectedDate = DateTime.now();
    currentDate = DateTime.now();
  }

  void _previousMonth() {
    setState(() {
      selectedDate = DateTime(selectedDate.year, selectedDate.month - 1);
      widget.onMonthChanged(_formatDate());
    });
  }

  void _nextMonth() {
    if (selectedDate.year < currentDate.year ||
        (selectedDate.year == currentDate.year &&
            selectedDate.month < currentDate.month)) {
      setState(() {
        selectedDate = DateTime(selectedDate.year, selectedDate.month + 1);
        widget.onMonthChanged(_formatDate());
      });
    }
  }

  String _formatDate() {
    return DateFormat('yyyy-MM').format(selectedDate);
  }

  String _formatDisplayDate() {
    return DateFormat('MMM yyyy').format(selectedDate);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
            onPressed: _previousMonth,
          ),
          AppTextLabels.boldTextShort(label: _formatDisplayDate(), color: AppColors.appGreen, fontSize: 16),
          IconButton(
            icon: const Icon(Icons.chevron_right),
            onPressed: selectedDate.year < currentDate.year ||
                (selectedDate.year == currentDate.year &&
                    selectedDate.month < currentDate.month)
                ? _nextMonth
                : null,
          ),
        ],
      ),
    );
  }
}