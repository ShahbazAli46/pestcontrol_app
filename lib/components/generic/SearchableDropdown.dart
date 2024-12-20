import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:accurate/utils/appColors.dart';
import 'package:get/get.dart';

class SearchableDropdown extends StatefulWidget {
  final String title;
  final RxList<String> options;
  final Function(String? value, int? index) onChanged;

  const SearchableDropdown({
    Key? key,
    required this.title,
    required this.options,
    required this.onChanged,
  }) : super(key: key);

  @override
  _SearchableDropdownState createState() => _SearchableDropdownState();
}

class _SearchableDropdownState extends State<SearchableDropdown> {
  String? _selectedValue;
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  RxList<String> _filteredOptions = <String>[].obs;
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    // Initialize filtered options with all options
    _filteredOptions.value = widget.options;

    // Listen to changes in the original options list
    ever(widget.options, (list) {
      // Reset filtered options when original list changes
      _filteredOptions.value = list;
      _searchController.clear();
    });

    // Add focus listener
    _focusNode.addListener(() {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _filterOptions(String query) {
    if (query.isEmpty) {
      // If search is empty, show all options
      _filteredOptions.value = widget.options;
    } else {
      // Filter options case-insensitively
      _filteredOptions.value = widget.options
          .where((option) => option.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
  }

  void _showSearchDialog() {
    // Reset search when dropdown is tapped
    _searchController.clear();
    _filteredOptions.value = widget.options;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            "Search ${widget.title}",
            style: GoogleFonts.manrope(),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: "Search...",
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onChanged: _filterOptions,
              ),
              const SizedBox(height: 10),
              Obx(() => SizedBox(
                width: double.maxFinite,
                height: 300, // Adjust height as needed
                child: _filteredOptions.isNotEmpty
                    ? ListView.builder(
                  shrinkWrap: true,
                  itemCount: _filteredOptions.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(_filteredOptions[index]),
                      onTap: () {
                        setState(() {
                          _selectedValue = _filteredOptions[index];
                        });
                        // Find the index in the original list
                        int? optionIndex = widget.options.indexOf(_selectedValue!);
                        _searchController.text = _selectedValue ?? "";

                        widget.onChanged(_selectedValue, optionIndex);
                        Navigator.of(context).pop();
                      },
                    );
                  },
                )
                    : Center(
                  child: Text(
                    "No results found",
                    style: GoogleFonts.manrope(),
                  ),
                ),
              )),
            ],
          ),
        );
      },
    );
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
          TextField(
            focusNode: _focusNode,
            controller: _searchController,
            readOnly: true, // Make the TextField read-only
            onTap: _showSearchDialog, // Show dialog when tapped
            decoration: InputDecoration(
              hintText: "Search...",
              suffixIcon: const Icon(Icons.arrow_drop_down),
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  color: AppColors.appGreen, // Red border when focused
                  width: 1,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  color: Colors.grey.shade400, // Default border color
                  width: 1,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}