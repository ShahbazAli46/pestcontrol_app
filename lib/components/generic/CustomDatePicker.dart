import 'package:accurate/utils/appColors.dart';
import 'package:flutter/material.dart';

class CustomDatePicker extends StatefulWidget {
  final int maxSelections;
  final Function(List<int>) onDatesSelected;

  const CustomDatePicker({
    Key? key,
    this.maxSelections = 2,
    required this.onDatesSelected,
  }) : super(key: key);

  @override
  _CustomDatePickerState createState() => _CustomDatePickerState();
}

class _CustomDatePickerState extends State<CustomDatePicker> {
  final List<int> selectedDates = [];

  // Calendar grid layout
  final int daysInMonth = 31;
  final int columnsPerRow = 7;

  void _toggleDateSelection(int date) {
    setState(() {
      if (selectedDates.contains(date)) {
        // Remove date if already selected
        selectedDates.remove(date);
      } else if (selectedDates.length < widget.maxSelections) {
        // Add date if under max selections
        selectedDates.add(date);
        selectedDates.sort(); // Optional: keep dates in order
      }
      widget.onDatesSelected(List.from(selectedDates)); // Send a copy of the list
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
          // Calendar header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Select Dates (Max: ${widget.maxSelections})',
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
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: columnsPerRow,
              childAspectRatio: 1,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
            ),
            itemCount: daysInMonth,
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