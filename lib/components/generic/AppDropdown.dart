import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:accurate/utils/appColors.dart';

class AppDropdown extends StatefulWidget {
  final String title;
  final List<String> options;
  final Function(String? value, int? index) onChanged;
  final String? selectedOption;
  final double? width;

  AppDropdown({
    required this.title,
    required this.options,
    required this.onChanged,
    this.selectedOption,
    this.width,
  });

  @override
  _AppDropdownState createState() => _AppDropdownState();
}

class _AppDropdownState extends State<AppDropdown> {
  String? _selectedValue;
  FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _selectedValue = widget.selectedOption;
    _focusNode.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width ?? double.infinity,
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
          Focus(
            focusNode: _focusNode,
            child: DropdownButtonFormField<String>(
              isExpanded: true, // This helps with long text
              value: _selectedValue,
              hint: Text(
                "Select Value",
                style: GoogleFonts.manrope(
                  color: AppColors.appBlack.withOpacity(0.5),
                ),
                overflow: TextOverflow.ellipsis,
              ),
              items: [
                ...widget.options.asMap().entries.map((entry) {
                  return DropdownMenuItem<String>(
                    value: entry.value,
                    child: Text(
                      entry.value,
                      style: GoogleFonts.manrope(
                        color: _focusNode.hasFocus ? AppColors.appGreen : AppColors.appBlack,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  );
                }).toList(),
              ],
              onChanged: (String? newValue) {
                setState(() {
                  _selectedValue = newValue;
                });
                int? index = newValue != null ? widget.options.indexOf(newValue) : null;
                widget.onChanged(newValue, index);
              },
              style: GoogleFonts.manrope(
                color: _focusNode.hasFocus ? AppColors.appGreen : AppColors.appBlack,
              ),
              decoration: InputDecoration(
                filled: true,
                fillColor: _focusNode.hasFocus ? AppColors.lightGreen : Colors.white,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: AppColors.appBlack,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: AppColors.appGreen,
                  ),
                ),
                contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              ),
              menuMaxHeight: 300, // Limit dropdown height
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ],
      ),
    );
  }
}
