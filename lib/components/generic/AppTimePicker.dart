import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:accurate/utils/appColors.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:accurate/utils/appColors.dart';

class AppTimePicker extends StatefulWidget {
  final String title;
  final Function(String) onTimeSelected;
  final String? initialTime;

  const AppTimePicker({
    Key? key,
    required this.title,
    required this.onTimeSelected,
    this.initialTime,
  }) : super(key: key);

  @override
  State<AppTimePicker> createState() => _AppTimePickerState();
}

class _AppTimePickerState extends State<AppTimePicker> {
  String? _selectedTime;
  String _amPm = 'AM';

  @override
  void initState() {
    super.initState();
    // If initial time is provided, parse it
    if (widget.initialTime != null) {
      _parseInitialTime(widget.initialTime!);
    } else {
      // Default to current time
      final now = DateTime.now();
      _selectedTime = _formatTime(now.hour, now.minute);
      _amPm = now.hour >= 12 ? 'PM' : 'AM';
    }
  }

  void _parseInitialTime(String time) {
    // Assumes format like "09:30 AM" or "02:45 PM"
    final timeParts = time.split(' ');
    if (timeParts.length == 2) {
      _selectedTime = timeParts[0];
      _amPm = timeParts[1];
    }
  }

  String _formatTime(int hour, int minute) {
    // Convert to 12-hour format
    int displayHour = hour % 12;
    displayHour = displayHour == 0 ? 12 : displayHour;
    return '${displayHour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}';
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
          child: child!,
        );
      },
    );

    if (pickedTime != null) {
      setState(() {
        // Convert to 12-hour format
        _selectedTime = _formatTime(pickedTime.hour, pickedTime.minute);
        _amPm = pickedTime.hour >= 12 ? 'PM' : 'AM';
      });

      // Combine time and AM/PM for the callback
      widget.onTimeSelected('$_selectedTime $_amPm');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.title,
            style: GoogleFonts.manrope(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          InkWell(
            onTap: () => _selectTime(context),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.appGreen),
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    _selectedTime != null
                        ? '$_selectedTime $_amPm'
                        : 'Select Time',
                    style: GoogleFonts.manrope(
                      color: AppColors.appBlack,
                    ),
                  ),
                  Icon(Icons.access_time, color: AppColors.appGreen),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}