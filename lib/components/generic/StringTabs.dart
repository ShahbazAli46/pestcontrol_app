import 'package:flutter/material.dart';

class AppTabs extends StatefulWidget {
  final List<String> tabs;
  final Function(int) onSelected;

  AppTabs({required this.tabs, required this.onSelected});

  @override
  _StringTabsState createState() => _StringTabsState();
}

class _StringTabsState extends State<AppTabs> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TabBar(
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
            widget.onSelected(index);
          },
          tabs: widget.tabs.map((tab) => Tab(text: tab)).toList(),
        ),
        Text('Selected index: $_currentIndex'),
      ],
    );
  }
}