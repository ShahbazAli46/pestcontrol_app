import 'package:accurate/utils/appColors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class AppInput extends StatefulWidget {
  final String title;
  final TextEditingController controller;
  final TextInputType inputType;
  final bool enabled;
  final Function(String)? onChange; // Added onChange callback
  final FocusNode? focusNode;  // Add focusNode parameter


  AppInput({
    required this.title,
    required this.controller,
    this.inputType = TextInputType.text,
    this.enabled = true,
    this.onChange, // New parameter
  this.focusNode,
  });

  @override
  State<AppInput> createState() => _AppInputState();
}

class _AppInputState extends State<AppInput> {
  FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    // Use provided focus node or create new one
    _focusNode = widget.focusNode ?? FocusNode();
    _focusNode.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    // Only dispose if we created the focus node ourselves
    if (widget.focusNode == null) {
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
              color: widget.enabled ? AppColors.appBlack : AppColors.appBlack.withOpacity(0.5),
            ),
          ),
          SizedBox(height: 8),
          TextField(
            controller: widget.controller,
            keyboardType: widget.inputType,
            obscureText: widget.inputType == TextInputType.visiblePassword,
            focusNode: _focusNode,
            enabled: widget.enabled,
            onChanged: widget.onChange, // Added onChanged handler
            style: GoogleFonts.manrope(
              color: widget.enabled
                  ? (_focusNode.hasFocus ? AppColors.appGreen : AppColors.appBlack)
                  : AppColors.appBlack.withOpacity(0.5),
            ),
            decoration: InputDecoration(
              filled: true,
              fillColor: widget.enabled
                  ? (_focusNode.hasFocus ? AppColors.lightGreen : Colors.white)
                  : Colors.grey[200],
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
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  color: AppColors.appBlack.withOpacity(0.5),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}