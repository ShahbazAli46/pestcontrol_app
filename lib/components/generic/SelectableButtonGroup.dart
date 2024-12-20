import 'package:accurate/utils/TextStyle.dart';
import 'package:accurate/utils/appColors.dart';
import 'package:flutter/material.dart';

class SelectableButtonGroup extends StatefulWidget {
  final List<String> titles;
  final Function(int) onSelect;

  SelectableButtonGroup({
    required this.titles,
    required this.onSelect,
    Key? key,
  }) : super(key: key);

  @override
  SelectableButtonGroupState createState() => SelectableButtonGroupState();
}

class SelectableButtonGroupState extends State<SelectableButtonGroup> {
  int selectedIndex = 0;

  void reset() {
    setState(() {
      selectedIndex = 0;
    });
    widget.onSelect(0);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(
        widget.titles.length,
            (index) => Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: InkWell(
              onTap: () {
                setState(() {
                  selectedIndex = index;
                });
                widget.onSelect(index);
              },
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  color: selectedIndex == index
                      ? AppColors.appGreen
                      : AppColors.appGreen.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: AppTextLabels.boldTextShort(
                    label: widget.titles[index],
                    color: Colors.white,
                    fontSize: 15,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}