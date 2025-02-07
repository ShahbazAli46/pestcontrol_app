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
  final bool active;
  final int? selectedID;

  const SearchableDropdownWithID({
    required Key key,
    required this.title,
    required this.options,
    required this.onChanged,
    this.active = true,
    this.selectedID,
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
    if (!widget.active) return;
    setState(() {
      _selectedValue = null;
      _searchController.clear();
    });
    widget.onChanged(null);
  }

  @override
  void initState() {
    super.initState();
    _filteredOptions = widget.options;
    if (widget.selectedID != null) {
      _selectedValue = widget.options.firstWhere(
            (item) => item.id == widget.selectedID,
        orElse: () => widget.options.first,
      );
      _searchController.text = _selectedValue?.name ?? "";
    }

    _focusNode.addListener(() {
      if (!widget.active) return;
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
    if (!widget.active) return;
    setState(() {
      if (query.isEmpty) {
        _filteredOptions = widget.options;
      } else {
        _filteredOptions = widget.options
            .where((item) => item.name.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
    _overlayEntry?.markNeedsBuild();
  }

  void _showOverlay() {
    if (!widget.active) return;

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
                  final item = _filteredOptions[index];
                  final isSelected = _selectedValue?.id == item.id;
                  return ListTile(
                    title: Text(item.name),
                    tileColor: isSelected ? Colors.grey.shade100 : null,
                    onTap: () {
                      setState(() {
                        _selectedValue = item;
                        _searchController.text = item.name;
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
  void didUpdateWidget(SearchableDropdownWithID oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.selectedID != oldWidget.selectedID) {
      if (widget.selectedID != null) {
        _selectedValue = widget.options.firstWhere(
              (item) => item.id == widget.selectedID,
          orElse: () => widget.options.first,
        );
        _searchController.text = _selectedValue?.name ?? "";
      } else {
        _selectedValue = null;
        _searchController.clear();
      }
    }
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
                color: widget.active ? null : Colors.grey,
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              focusNode: _focusNode,
              controller: _searchController,
              onChanged: _filterOptions,
              enabled: widget.active,
              decoration: InputDecoration(
                hintText: "Search...",
                suffixIcon: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (_selectedValue != null && widget.active)
                      IconButton(
                        icon: Icon(Icons.clear, size: 20),
                        onPressed: clear,
                      ),
                    const Icon(Icons.arrow_drop_down),
                  ],
                ),
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
                fillColor: widget.active ? null : Colors.grey.shade200,
                filled: !widget.active,
              ),
            ),
          ],
        ),
      ),
    );
  }
}