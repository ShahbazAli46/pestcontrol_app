import 'package:accurate/utils/appColors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';

class InputWithGetxTitle extends StatefulWidget {
  final RxString title;
  final TextEditingController controller;
  final TextInputType inputType;
  final bool enabled;
  final Function(String)? onChange;

  InputWithGetxTitle({
    required this.title,
    required this.controller,
    this.inputType = TextInputType.text,
    this.enabled = true,
    this.onChange,
  });

  @override
  State<InputWithGetxTitle> createState() => _InputWithGetxTitleState();
}

class _InputWithGetxTitleState extends State<InputWithGetxTitle> {
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
          Obx(() => Text(
            "Quantity ${widget.title.value}",
            style: GoogleFonts.manrope(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: widget.enabled ? AppColors.appBlack : AppColors.appBlack.withOpacity(0.5),
            ),
          )),
          SizedBox(height: 8),
          TextField(
            controller: widget.controller,
            keyboardType: widget.inputType,
            obscureText: widget.inputType == TextInputType.visiblePassword,
            focusNode: _focusNode,
            enabled: widget.enabled,
            onChanged: widget.onChange,
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