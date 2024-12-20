import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:map_launcher/map_launcher.dart';

class MyMapLauncher {
  static Future<void> openMapsWithLocation({
    required double latitude,
    required double longitude,
    String? title,
  }) async {
    try {
      final availableMaps = await MapLauncher.installedMaps;

      if (availableMaps.isEmpty) {
        // Fallback to opening in browser if no maps installed
        final url = 'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
        if (await canLaunch(url)) {
          await launch(url);
        }
        return;
      }

      // Show bottom sheet with available maps
      Get.bottomSheet(
        Container(
          color: Get.theme.scaffoldBackgroundColor,
          child: SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ListTile(
                  title: Text('Open location with...'),
                ),
                ...availableMaps.map((map) => ListTile(
                  onTap: () {
                    map.showMarker(
                      coords: Coords(latitude, longitude),
                      title: title ?? 'Selected Location',
                    );
                    Get.back(); // Close bottom sheet
                  },
                  title: Text(map.mapName),
                )).toList(),
              ],
            ),
          ),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        backgroundColor: Get.theme.scaffoldBackgroundColor,
      );
    } catch (e) {
      print('Error opening maps: $e');
      Get.snackbar(
        'Error',
        'Could not open maps: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}