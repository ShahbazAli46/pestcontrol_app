import 'package:accurate/components/generic/CustomListView.dart';
import 'package:accurate/components/generic/UIHelper.dart';
import 'package:accurate/jsonModels/UserDetails.dart';
import 'package:accurate/utils/TextStyle.dart';
import 'package:flutter/material.dart';

class DevicesScreen extends StatefulWidget {
  UserDetails info;
  DevicesScreen({required this.info});
  @override
  State<DevicesScreen> createState() => _DevicesScreenState();
}

class _DevicesScreenState extends State<DevicesScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 20, width: double.infinity,),
        Expanded(child: CustomListView(items: widget.info.data?.devices ??  [],
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
            UiHelper.buildRow("Device Name", widget.info?.data?.devices?[index]?.name ?? ""),
            UiHelper.buildRow("Model Name", widget.info?.data?.devices?[index]?.model ?? ""),
            UiHelper.buildRow("Identification Number", widget.info?.data?.devices?[index]?.codeNo ?? ""),
            UiHelper.buildRow("Other Info", widget.info?.data?.devices?[index]?.desc ?? ""),

          ],
        ),

    );
  }
}
