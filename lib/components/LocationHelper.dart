import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

class LocationService {
  // Singleton pattern implementation
  static final LocationService _instance = LocationService._internal();

  factory LocationService() {
    return _instance;
  }

  LocationService._internal();

  /// Gets the current device location, handling permissions appropriately.
  /// Returns a [Position] object containing latitude and longitude if successful.
  /// Throws a [LocationServiceException] if there are any errors.
  Future<Position> getCurrentLocation(BuildContext context) async {
    try {
      // First check if location services are enabled
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        _showLocationDisabledDialog(context);
        throw LocationServiceException('Location services are disabled');
      }

      // Check location permission status
      LocationPermission permission = await Geolocator.checkPermission();

      // Handle permission cases
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          throw LocationServiceException('Location permissions are denied');
        }
      }

      // If permissions are permanently denied, we need to open app settings
      if (permission == LocationPermission.deniedForever) {
        await _showPermissionDeniedForeverDialog(context);
        throw LocationServiceException('Location permissions are permanently denied');
      }

      // Get the current position
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      return position;
    } catch (e) {
      if (e is LocationServiceException) {
        rethrow;
      }
      throw LocationServiceException('Failed to get location: ${e.toString()}');
    }
  }

  /// Shows a dialog when location services are disabled
  Future<void> _showLocationDisabledDialog(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Location Services Disabled'),
          content: const Text(
              'Please enable location services to use this feature.'
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('CANCEL'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: const Text('OPEN SETTINGS'),
              onPressed: () {
                Navigator.of(context).pop();
                Geolocator.openLocationSettings();
              },
            ),
          ],
        );
      },
    );
  }

  /// Shows a dialog when location permissions are permanently denied
  Future<void> _showPermissionDeniedForeverDialog(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Location Permission Required'),
          content: const Text(
              'Location permissions are permanently denied. Please enable them in app settings.'
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('CANCEL'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: const Text('OPEN SETTINGS'),
              onPressed: () {
                Navigator.of(context).pop();
                openAppSettings();
              },
            ),
          ],
        );
      },
    );
  }
}

/// Custom exception class for location service errors
class LocationServiceException implements Exception {
  final String message;
  LocationServiceException(this.message);

  @override
  String toString() => message;
}