import 'package:flutter/material.dart';
import 'package:google_place/google_place.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:google_places_flutter/model/prediction.dart';

class AddressPicker extends StatefulWidget {
  final Function(Map<String, Object>) onLocationSelected;

  AddressPicker({required this.onLocationSelected});

  @override
  _AddressPickerState createState() => _AddressPickerState();
}

class _AddressPickerState extends State<AddressPicker> {
  final String apiKey = "AIzaSyBBHNqsXFQqg_-f6BkI5UH7X7nXK2KQzk8";
  TextEditingController controller = TextEditingController();
  late GooglePlace googlePlace;

  @override
  void initState() {
    super.initState();
    googlePlace = GooglePlace(apiKey);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        placesAutoCompleteTextField(),
      ],
    );
  }

  Widget placesAutoCompleteTextField() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: GooglePlaceAutoCompleteTextField(
        textEditingController: controller,
        googleAPIKey: apiKey,
        inputDecoration: InputDecoration(
          hintText: "Search your location",
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
        ),
        debounceTime: 400,
        countries: ["ae"],
        isLatLngRequired: true,
        getPlaceDetailWithLatLng: (Prediction prediction) async {
          if (prediction.placeId != null) {
            var details = await googlePlace.details.get(prediction.placeId!);
            if (details != null && details.result != null) {
              var place = details.result!;
              var lat = place.geometry?.location?.lat;
              var lng = place.geometry?.location?.lng;
              var address = place.formattedAddress;
              var area = extractAreaFromAddress(place);
              var locationInfo = extractLocationInfo(place);

              widget.onLocationSelected({
                'latitude': lat ?? 0,
                'longitude': lng ?? 0,
                'address': address ?? "",
                'area': locationInfo['area'] ?? "",
                'state': locationInfo['state'] ?? "",
                'country': locationInfo['country'] ?? "",
                'city': locationInfo['city'] ?? "", // Added city information
              });
            }
          }
        },
        itemClick: (Prediction prediction) {
          controller.text = prediction.description ?? "";
          controller.selection = TextSelection.fromPosition(
              TextPosition(offset: prediction.description?.length ?? 0));
        },
        seperatedBuilder: Divider(),
        containerHorizontalPadding: 10,
        itemBuilder: (context, index, Prediction prediction) {
          return Container(
            padding: EdgeInsets.all(10),
            child: Row(
              children: [
                Icon(Icons.location_on),
                SizedBox(width: 7),
                Expanded(child: Text("${prediction.description ?? ""}"))
              ],
            ),
          );
        },
        isCrossBtnShown: true,
      ),
    );
  }

  String extractAreaFromAddress(DetailsResult place) {
    String area = "";

    if (place.addressComponents != null) {
      var sublocality = place.addressComponents!.firstWhere(
            (component) =>
        component.types!.contains("sublocality") ||
            component.types!.contains("sublocality_level_1") ||
            component.types!.contains("neighborhood"),
        orElse: () => AddressComponent(types: [], longName: "", shortName: ""),
      );

      if (sublocality.longName!.isNotEmpty) {
        area = sublocality.longName ?? "";
      }
    }

    if (area.isEmpty && place.formattedAddress != null) {
      var parts = place.formattedAddress!.split("-").map((part) => part.trim()).toList();
      var areaPattern = RegExp(r'\b\w+(\s+\w+)*\s+Area\b', caseSensitive: false);

      for (var part in parts) {
        var match = areaPattern.firstMatch(part);
        if (match != null) {
          area = match.group(0)!;
          break;
        }
      }
    }

    return area;
  }

  Map<String, String> extractLocationInfo(DetailsResult place) {
    String area = "";
    String state = "";
    String country = "";
    String city = "";

    if (place.addressComponents != null) {
      // Extract area (sublocality or neighborhood)
      var sublocalityComponent = place.addressComponents!.firstWhere(
            (component) =>
        component.types!.contains("sublocality") ||
            component.types!.contains("sublocality_level_1") ||
            component.types!.contains("neighborhood"),
        orElse: () => AddressComponent(types: [], longName: "", shortName: ""),
      );
      area = sublocalityComponent.longName ?? "";

      // Extract city (locality)
      var cityComponent = place.addressComponents!.firstWhere(
            (component) => component.types!.contains("locality"),
        orElse: () => AddressComponent(types: [], longName: "", shortName: ""),
      );
      city = cityComponent.longName ?? "";

      // Extract state/emirate (administrative_area_level_1)
      var stateComponent = place.addressComponents!.firstWhere(
            (component) =>
            component.types!.contains("administrative_area_level_1"),
        orElse: () => AddressComponent(types: [], longName: "", shortName: ""),
      );
      state = stateComponent.longName ?? "";

      // If city is empty and it's a major emirate, use the state as city
      if (city.isEmpty && isEmirateCity(state)) {
        city = state;
      }

      // Extract country
      var countryComponent = place.addressComponents!.firstWhere(
            (component) => component.types!.contains("country"),
        orElse: () => AddressComponent(types: [], longName: "", shortName: ""),
      );
      country = countryComponent.longName ?? "";
    }

    // Fallback: Try to extract from formatted address if components are empty
    if (area.isEmpty && place.formattedAddress != null) {
      var parts = place.formattedAddress!.split(",").map((part) => part.trim()).toList();
      var areaPattern = RegExp(r'\b\w+(\s+\w+)*\s+Area\b', caseSensitive: false);

      for (var part in parts) {
        var match = areaPattern.firstMatch(part);
        if (match != null) {
          area = match.group(0)!;
          break;
        }
      }
    }

    return {
      'area': area,
      'city': city,
      'state': state,
      'country': country,
    };
  }

  bool isEmirateCity(String state) {
    // List of emirates that are also cities
    final emirateCities = [
      'Dubai',
      'Abu Dhabi',
      'Sharjah',
      'Ajman',
      'Umm Al Quwain',
      'Ras Al Khaimah',
      'Fujairah'
    ];
    return emirateCities.contains(state);
  }
}