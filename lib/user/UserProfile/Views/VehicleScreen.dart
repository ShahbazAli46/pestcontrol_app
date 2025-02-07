import 'package:accurate/components/generic/CustomListView.dart';
import 'package:accurate/components/generic/UIHelper.dart';
import 'package:accurate/jsonModels/UserDetails.dart';
import 'package:flutter/material.dart';

class VehicleScreen extends StatefulWidget {
  UserDetails info;
  VehicleScreen({required this.info});

  @override
  State<VehicleScreen> createState() => _VehicleScreenState();
}

class _VehicleScreenState extends State<VehicleScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 20, width: double.infinity,),
        Expanded(child: CustomListView(items: widget.info.data?.assignedVehicles ??  [],
          itemBuilder: (context, item, index)=>_mobileDeviceItem(index),
        )),
        SizedBox(height: 20,),
      ],
    );
  }
  _mobileDeviceItem(int index){
    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 5,
            offset: Offset(0, 2),
          ),
        ],)
      ,child: Column(
      children: [
        UiHelper.buildRow("Sr", "${index + 1}"),
        UiHelper.buildRow("Vehicle Name ", widget.info?.data?.assignedVehicles?[index].modalName ?? ""),
        UiHelper.buildRow("Number", widget.info?.data?.assignedVehicles?[index]?.vehicleNumber ?? ""),
        UiHelper.buildRow("Mulkia Expiry", widget.info?.data?.assignedVehicles?[index]?.expiryDate ?? ""),
        UiHelper.buildRow("Next Oil Change", widget.info?.data?.assignedVehicles?[index]?.oilChangeLimit ?? ""),
      ],
    ),

    );
  }
}
