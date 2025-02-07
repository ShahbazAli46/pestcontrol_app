import 'dart:io';

import 'package:accurate/components/generic/CameraImagePicker.dart';
import 'package:accurate/components/generic/GreenButton.dart';
import 'package:accurate/components/generic/GreenButtonBordered.dart';
import 'package:accurate/components/generic/ImageGrid.dart';
import 'package:accurate/components/generic/ImageUploadWidget.dart';
import 'package:accurate/components/generic/UIHelper.dart';
import 'package:accurate/components/generic/navWithBack.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AddImagesForIPMReportScreen extends StatefulWidget {
  int serviceID;
  AddImagesForIPMReportScreen({required this.serviceID});

  @override
  State<AddImagesForIPMReportScreen> createState() => _AddImagesForIPMReportScreenState();
}

class _AddImagesForIPMReportScreenState extends State<AddImagesForIPMReportScreen> {



  List<File> images = [];

  void _deleteImage(int index) {
    setState(() {
      images.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(child: Column(
      children: [
        NavWithBack(),
        SizedBox(height: 20,),
        CameraImagePicker(onImageSelected: (file){
          images.add(file!);
          setState(() {
          });
        }),
        SizedBox(height: 20),
        if (images.isNotEmpty)
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: ImageGrid(
                  images: images,
                  onDelete: _deleteImage,
                ),
              ),
            ),
          ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: GreenButton(title: "Submit Images And complete Service", sendingData: false.obs, onTap:(){

          }),
        )

      ],
    )));
  }
}
