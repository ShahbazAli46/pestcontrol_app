import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MultiSelectCheckbox extends StatefulWidget {
  final RxList items;
  final Function(List<String>) onSelectionChanged;
  final String? title;

  const MultiSelectCheckbox({
    Key? key,
    required this.items,
    required this.onSelectionChanged,
    this.title,
  }) : super(key: key);

  @override
  State<MultiSelectCheckbox> createState() => _MultiSelectCheckboxState();
}

class _MultiSelectCheckboxState extends State<MultiSelectCheckbox> {
  @override
  Widget build(BuildContext context) {
    return Obx(() => Card(
      color: Colors.white70,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (widget.title != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Text(
                  widget.title!,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ...List.generate(
              widget.items.length,
                  (index) => CheckboxListTile(
                value: widget.items[index].isSelected,
                title: Text(widget.items[index].value),

                onChanged: (value) {
                  // Create a new list with the updated item
                  final updatedItems = widget.items.toList();
                  updatedItems[index].isSelected = value ?? false;

                  // Update the RxList using value assignment
                  widget.items.assignAll(updatedItems);

                  List<String> ids = [];

                  widget.items.forEach((item){
                    if (item.isSelected){
                        ids.add(item.id);
                    }
                  });
                  widget.onSelectionChanged(ids);
                },
                controlAffinity: ListTileControlAffinity.leading,
                dense: true,
              ),
            ),
          ],
        ),
      ),
    ));
  }
}

class CheckboxItem {
  final String id;
  final String value;
  bool isSelected;

  CheckboxItem({
    required this.id,
    required this.value,
    this.isSelected = false,
  });
}