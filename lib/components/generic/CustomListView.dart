import 'package:flutter/material.dart';

// Common NoDataWidget that can be used across the app
class NoDataWidget extends StatelessWidget {
  final String? message;
  final IconData? icon;
  final double? iconSize;
  final TextStyle? textStyle;

  const NoDataWidget({
    Key? key,
    this.message,
    this.icon,
    this.iconSize,
    this.textStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (icon != null)
            Icon(
              icon ?? Icons.hourglass_empty,
              size: iconSize ?? 48,
              color: Colors.grey,
            ),
          const SizedBox(height: 16),
          Text(
            message ?? 'No data available',
            style: textStyle ??
                const TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
          ),
        ],
      ),
    );
  }
}

class CustomListView<T> extends StatelessWidget {
  final List<T> items;
  final Widget Function(BuildContext context, T item, int index) itemBuilder;
  final Function(BuildContext context, T item, int index)? onItemTap; // Added callback for item tap
  final Future<void> Function()? onRefresh; // Optional refresh callback
  final bool isLoading;
  final EdgeInsets? padding;
  final ScrollPhysics? physics;
  final bool shrinkWrap;
  final ScrollController? scrollController;
  bool isPrimary = false;

  CustomListView({
    Key? key,
    required this.items,
    required this.itemBuilder,
    this.onItemTap,
    this.onRefresh,
    this.isLoading = false,
    this.padding,
    this.physics,
    this.shrinkWrap = false,
    this.scrollController,
    this.isPrimary = false,  // Making it optional with default value null
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (items.isEmpty) {
      return const NoDataWidget(
        icon: Icons.hourglass_empty,
        message: 'No data available',
      );
    }

    Widget listView = ListView.builder(

      controller: scrollController,
      padding: padding,
      physics: physics,
      shrinkWrap: shrinkWrap,
      primary: isPrimary,
      itemCount: items.length,
      itemBuilder: (context, index) => InkWell(
        onTap: onItemTap != null
            ? () => onItemTap!(context, items[index], index)
            : null,
        child: itemBuilder(context, items[index], index),
      ),
    );

    if (onRefresh != null) {
      return RefreshIndicator(
        onRefresh: onRefresh!,
        child: listView,
      );
    }

    return listView;
  }
}