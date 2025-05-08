import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:accurate/utils/appColors.dart';

class AppMultilineInput extends StatefulWidget {
  final String title;
  final TextEditingController controller;
  final int? maxLines;
  final int? maxLength;
  final FocusNode? focusNode; // Make FocusNode optional

  AppMultilineInput({
    required this.title,
    required this.controller,
    this.maxLines,
    this.maxLength,
    this.focusNode, // Add this parameter
  });

  @override
  State<AppMultilineInput> createState() => _AppMultilineInputState();
}

class _AppMultilineInputState extends State<AppMultilineInput> {
  late FocusNode _focusNode;
  bool _internalFocusNode = false;

  @override
  void initState() {
    super.initState();
    // Use provided FocusNode or create a new one
    _focusNode = widget.focusNode ?? FocusNode();
    _internalFocusNode = widget.focusNode == null;

    _focusNode.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    // Only dispose the FocusNode if we created it internally
    if (_internalFocusNode) {
      _focusNode.dispose();
    }
    super.dispose();
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
          Container(
            height: 170, // Fixed height as requested
            child: TextField(
              controller: widget.controller,
              focusNode: _focusNode,
              minLines: 10,
              maxLines: widget.maxLines ?? null, // null means unlimited lines
              maxLength: widget.maxLength,
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
                contentPadding: EdgeInsets.all(12),
              ),
            ),
          ),
        ],
      ),
    );
  }
}