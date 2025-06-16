import 'package:flutter/material.dart';

class CustomTabs extends StatefulWidget {
  final List<String> tabTitles;
  final List<Widget> tabContents;

  const CustomTabs({
    Key? key,
    required this.tabTitles,
    required this.tabContents,
  }) : assert(tabTitles.length == tabContents.length),
        super(key: key);

  @override
  _CustomTabsState createState() => _CustomTabsState();
}

class _CustomTabsState extends State<CustomTabs> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: widget.tabTitles.length,
      vsync: this,
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height-110,
      child: Column(
        children: [
          Container(
          margin: EdgeInsets.only(top: 10, bottom: 10),
            child: TabBar(
              controller: _tabController,
              isScrollable: true,
              indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.green,
              ),
              labelColor: Colors.white,
              unselectedLabelColor: Colors.black87,
              indicatorSize: TabBarIndicatorSize.tab,
              padding: EdgeInsets.only(bottom: 12),
              labelPadding: const EdgeInsets.symmetric(horizontal: 4),
              tabs: widget.tabTitles.map((title) {
                return Tab(
                  child: Container(

                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.black.withOpacity(0.05),
                    ),
                    child: Center(
                      child: Text(
                        title,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: widget.tabContents,
            ),
          ),
        ],
      ),
    );
  }
}