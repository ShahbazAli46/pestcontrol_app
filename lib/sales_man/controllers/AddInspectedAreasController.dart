

import 'package:accurate/components/generic/DialogHelper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddInspectedAreasController extends GetxController {
  final inspectedAreas = RxList<InspectedArea>();
  TextEditingController areaName = new TextEditingController();
  TextEditingController pestFound = new TextEditingController();
  TextEditingController manifestiedArea = new TextEditingController();
  TextEditingController followUp = new TextEditingController();
  String level = "";

  void addAres(closeModel){
    if (areaName.text.trim().isEmpty ){
      DialogHelper.showDialog(msg: "Please enter area name");
    } else if (pestFound.text.trim().isEmpty){
      DialogHelper.showDialog(msg: "Please enter what pest was found");
    } else if (level.isEmpty){
      DialogHelper.showDialog(msg: "Please select manifestation level");
    } else if (manifestiedArea.text.trim().isEmpty){
        DialogHelper.showDialog(msg: "Please enter main infested area");
    } else if (followUp.text.trim().isEmpty){
      DialogHelper.showDialog(msg: "Please enter follow up detail");
    } else {
      inspectedAreas.add(
        InspectedArea(
          areaName: areaName.text,
          pestFound: pestFound.text,
          manifestationLevel: level,
          manifestedArea: manifestiedArea.text,
          followUp: followUp.text,
        ),
      );
      areaName.clear();
      pestFound.clear();
      manifestiedArea.clear();
      followUp.clear();
      level = "";
      closeModel();
    }
  }
  void removeAddressAt(int index){
    inspectedAreas.removeAt(index);
  }
}




class InspectedArea {
  String areaName;
  String pestFound;
  String manifestationLevel;
  String manifestedArea;
  String followUp;

  InspectedArea({
    required this.areaName,
    required this.pestFound,
    required this.manifestationLevel,
    required this.manifestedArea,
    required this.followUp,
  });
}