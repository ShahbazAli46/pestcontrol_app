import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utils/appColors.dart';

class AppRadioSelection extends StatefulWidget {
  final String title;
  final List<String> options;
  final Function(String? value, int? index) onChanged;
  final String? initialValue;

  AppRadioSelection({
    required this.title,
    required this.options,
    required this.onChanged,
    this.initialValue,
  });

  @override
  _AppRadioSelectionState createState() => _AppRadioSelectionState();
}

class _AppRadioSelectionState extends State<AppRadioSelection> {
  String? _selectedValue;

  @override
  void initState() {
    super.initState();
    _selectedValue = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
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
          SizedBox(height: 8),
          ...widget.options.asMap().entries.map((entry) {
            return RadioListTile<String>(
              title: Text(
                entry.value,
                style: GoogleFonts.manrope(
                  color: AppColors.appBlack,
                ),
              ),
              value: entry.value,
              groupValue: _selectedValue,
              onChanged: (String? value) {
                setState(() {
                  _selectedValue = value;
                });
                widget.onChanged(value, entry.key);
              },
              activeColor: AppColors.appGreen,
              controlAffinity: ListTileControlAffinity.leading,
              contentPadding: EdgeInsets.symmetric(horizontal: 0),
            );
          }).toList(),
        ],
      ),
    );
  }
}