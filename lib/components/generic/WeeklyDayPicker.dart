import 'package:flutter/material.dart';

enum SelectionType {
  monthly,
  quarterly
}

// Class to hold week and day selection information
class DaySelection {
  final int weekNumber;
  final String weekday;

  DaySelection(this.weekNumber, this.weekday);

  @override
  String toString() => 'Week $weekNumber - $weekday';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is DaySelection &&
              runtimeType == other.runtimeType &&
              weekNumber == other.weekNumber &&
              weekday == other.weekday;

  @override
  int get hashCode => weekNumber.hashCode ^ weekday.hashCode;
}

class WeeklyDayPicker extends StatefulWidget {
  final int maxSelections;
  final SelectionType selectionType;
  final Function(List<DaySelection>) onDaysSelected;

  const WeeklyDayPicker({
    Key? key,
    required this.maxSelections,
    required this.selectionType,
    required this.onDaysSelected,
  }) : super(key: key);

  @override
  _WeeklyDayPickerState createState() => _WeeklyDayPickerState();
}

class _WeeklyDayPickerState extends State<WeeklyDayPicker> {
  final List<DaySelection> selectedDays = [];

  void _toggleDay(int weekNumber, String day) {
    setState(() {
      DaySelection selection = DaySelection(weekNumber, day);

      if (selectedDays.any((d) =>
      d.weekNumber == weekNumber &&
          d.weekday == day)) {
        selectedDays.removeWhere((d) =>
        d.weekNumber == weekNumber &&
            d.weekday == day);
      } else if (selectedDays.length < widget.maxSelections) {
        selectedDays.add(selection);
      }

      widget.onDaysSelected(selectedDays);
    });
  }

  bool _isSelected(int weekNumber, String day) {
    return selectedDays.any((d) =>
    d.weekNumber == weekNumber &&
        d.weekday == day);
  }

  Widget _buildWeek(int weekNumber) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Week $weekNumber',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildDayCheckbox('Mon', weekNumber),
              _buildDayCheckbox('Tue', weekNumber),
              _buildDayCheckbox('Wed', weekNumber),
              _buildDayCheckbox('Thu', weekNumber),
              _buildDayCheckbox('Fri', weekNumber),
              _buildDayCheckbox('Sat', weekNumber),
              _buildDayCheckbox('Sun', weekNumber),
            ],
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }

  Widget _buildDayCheckbox(String day, int weekNumber) {
    return Column(
      children: [
        Checkbox(
          value: _isSelected(weekNumber, day),
          onChanged: (bool? value) {
            _toggleDay(weekNumber, day);
          },
        ),
        Text(day),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'Select Days (Max: ${widget.maxSelections})',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 16),
            ],
          ),
          const SizedBox(height: 16),
          _buildWeek(1),
          _buildWeek(2),
          _buildWeek(3),
          _buildWeek(4),
          const SizedBox(height: 8),
          Text(
            'Selected days: ${selectedDays.length}',
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}