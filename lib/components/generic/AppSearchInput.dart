import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppSearchInput extends StatefulWidget {
  final String title;
  final TextEditingController controller;
  final TextInputType inputType;
  final bool enabled;
  final Function(String) onChanged;

  AppSearchInput({
    required this.title,
    required this.controller,
    required this.onChanged,
    this.inputType = TextInputType.text,
    this.enabled = true,
  });

  @override
  State<AppSearchInput> createState() => _AppInputState();
}

class _AppInputState extends State<AppSearchInput> {
  FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
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
      padding: EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.title,
            style: GoogleFonts.manrope(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: widget.enabled ? Colors.black : Colors.black.withOpacity(0.5),
            ),
          ),
          SizedBox(height: 8),
          TextField(
            controller: widget.controller,
            keyboardType: widget.inputType,
            obscureText: widget.inputType == TextInputType.visiblePassword,
            focusNode: _focusNode,
            enabled: widget.enabled,
            onChanged: widget.onChanged,
            style: GoogleFonts.manrope(
              color: widget.enabled
                  ? (_focusNode.hasFocus ? Colors.green : Colors.black)
                  : Colors.black.withOpacity(0.5),
            ),
            decoration: InputDecoration(
              filled: true,
              fillColor: widget.enabled
                  ? (_focusNode.hasFocus ? Colors.lightGreen.withOpacity(0.1) : Colors.white)
                  : Colors.grey[200],
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.black),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.green),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.black.withOpacity(0.5)),
              ),
              prefixIcon: Icon(
                Icons.search,
                color: Colors.grey,
              ),
            ),
          ),
        ],
      ),
    );
  }
}