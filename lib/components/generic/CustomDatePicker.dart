import 'package:accurate/utils/appColors.dart';
import 'package:flutter/material.dart';

import 'package:accurate/utils/appColors.dart';
import 'package:flutter/material.dart';

class CustomDatePicker extends StatefulWidget {
  final int maxSelections;
  final Function(List<int>) onDatesSelected;
  final DateTime? initialDate;
  final Function(int)? onMonthChanged; // Add this callback

  const CustomDatePicker({
    Key? key,
    this.maxSelections = 2,
    required this.onDatesSelected,
    this.initialDate,
    this.onMonthChanged, // Add this parameter
  }) : super(key: key);

  @override
  _CustomDatePickerState createState() => _CustomDatePickerState();
}

class _CustomDatePickerState extends State<CustomDatePicker> {
  final List<int> selectedDates = [];
  late DateTime _currentDate;
  late int _daysInMonth;
  final List<String> _months = [
    'January', 'February', 'March', 'April',
    'May', 'June', 'July', 'August',
    'September', 'October', 'November', 'December'
  ];
  final List<int> _years = List.generate(10, (index) => DateTime.now().year + index - 5);

  @override
  void initState() {
    super.initState();
    _currentDate = widget.initialDate ?? DateTime.now();
    _updateDaysInMonth();
  }

  void _updateDaysInMonth() {
    _daysInMonth = DateTime(_currentDate.year, _currentDate.month + 1, 0).day;
  }

  void _toggleDateSelection(int date) {
    setState(() {
      if (selectedDates.contains(date)) {
        selectedDates.remove(date);
      } else if (selectedDates.length < widget.maxSelections) {
        selectedDates.add(date);
        selectedDates.sort();
      }
      widget.onDatesSelected(List.from(selectedDates));
    });
  }

  void _changeMonth(int month) {
    setState(() {
      _currentDate = DateTime(_currentDate.year, month, 1);
      _updateDaysInMonth();
      selectedDates.clear();
      widget.onDatesSelected([]);
    });
    widget.onMonthChanged?.call(month);
  }

  void _changeYear(int year) {
    setState(() {
      _currentDate = DateTime(year, _currentDate.month, 1);
      _updateDaysInMonth();
      selectedDates.clear();
      widget.onDatesSelected([]);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Month/Year selector
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Month dropdown
              DropdownButton<int>(
                value: _currentDate.month,
                items: List.generate(12, (index) => index + 1)
                    .map((month) => DropdownMenuItem<int>(
                  value: month,
                  child: Text(_months[month - 1]),
                ))
                    .toList(),
                onChanged: (month) => _changeMonth(month!),
              ),

              // Year dropdown
              DropdownButton<int>(
                value: _currentDate.year,
                items: _years
                    .map((year) => DropdownMenuItem<int>(
                  value: year,
                  child: Text(year.toString()),
                ))
                    .toList(),
                onChanged: (year) => _changeYear(year!),
              ),
            ],
          ),

          // Calendar header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${_months[_currentDate.month - 1]} ${_currentDate.year}',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Selected: ${selectedDates.length}/${widget.maxSelections}',
                style: const TextStyle(
                  color: Colors.grey,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Weekday headers
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: const [
              Text('S'), Text('M'), Text('T'), Text('W'),
              Text('T'), Text('F'), Text('S'),
            ],
          ),
          const SizedBox(height: 8),

          // Calendar grid
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7,
              childAspectRatio: 1,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
            ),
            itemCount: _daysInMonth,
            itemBuilder: (context, index) {
              final date = index + 1;
              final isSelected = selectedDates.contains(date);
              final canSelect = !isSelected && selectedDates.length < widget.maxSelections;

              return GestureDetector(
                onTap: () => _toggleDateSelection(date),
                child: Container(
                  decoration: BoxDecoration(
                    color: isSelected
                        ? AppColors.appGreen
                        : canSelect
                        ? Colors.grey[200]
                        : Colors.grey[100],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Text(
                      '$date',
                      style: TextStyle(
                        color: isSelected
                            ? Colors.white
                            : canSelect
                            ? Colors.black
                            : Colors.grey[500],
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}