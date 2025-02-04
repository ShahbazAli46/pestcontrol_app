import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:accurate/utils/appColors.dart';
import 'package:get/get.dart';

// Define the DropdownItem class
class DropdownItem {
  final String name;
  final int id;

  DropdownItem({required this.name, required this.id});
}

class SearchableDropdownWithID extends StatefulWidget {
  final String title;
  final List<DropdownItem> options;
  final Function(DropdownItem? value) onChanged;

  const SearchableDropdownWithID({
    required Key key,
    required this.title,
    required this.options,
    required this.onChanged,
  }) : super(key: key);

  @override
  SearchableDropdownWithIDState createState() => SearchableDropdownWithIDState();
}

class SearchableDropdownWithIDState extends State<SearchableDropdownWithID> {
  DropdownItem? _selectedValue;
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  List<DropdownItem> _filteredOptions = [];
  bool _isExpanded = false;
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;


  void clear() {
    setState(() {
      _selectedValue = null;
      _searchController.clear();
    });
  }


  @override
  void initState() {
    super.initState();
    _filteredOptions = widget.options;

    _focusNode.addListener(() {
      if (_focusNode.hasFocus && !_isExpanded) {
        _showOverlay();
      } else if (!_focusNode.hasFocus && _isExpanded) {
        _hideOverlay();
      }
    });
  }

  @override
  void dispose() {
    _hideOverlay();
    _searchController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _filterOptions(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredOptions = widget.options;
      } else {
        _filteredOptions = widget.options
            .where((item) => item.name.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });

    // Rebuild overlay to show filtered results
    _overlayEntry?.markNeedsBuild();
  }

  void _showOverlay() {
    final RenderBox renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;

    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        width: size.width,
        child: CompositedTransformFollower(
          link: _layerLink,
          showWhenUnlinked: false,
          offset: Offset(0.0, size.height + 5.0),
          child: Material(
            elevation: 4.0,
            child: Container(
              constraints: BoxConstraints(maxHeight: 200),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(4.0),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: _filteredOptions.isNotEmpty
                  ? ListView.builder(
                shrinkWrap: true,
                itemCount: _filteredOptions.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(_filteredOptions[index].name),
                    onTap: () {
                      setState(() {
                        _selectedValue = _filteredOptions[index];
                        _searchController.text = _selectedValue?.name ?? "";
                      });
                      widget.onChanged(_selectedValue);
                      _focusNode.unfocus();
                    },
                  );
                },
              )
                  : Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "No results found",
                  style: GoogleFonts.manrope(),
                ),
              ),
            ),
          ),
        ),
      ),
    );

    Overlay.of(context).insert(_overlayEntry!);
    setState(() => _isExpanded = true);
  }

  void _hideOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
    setState(() => _isExpanded = false);
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: Container(
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
              onChanged: _filterOptions,
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
                    color: AppColors.appGreen,
                    width: 1,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: Colors.grey.shade400,
                    width: 1,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}