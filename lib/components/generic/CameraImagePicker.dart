import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class CameraImagePicker extends StatefulWidget {
  final Function(File?) onImageSelected;
  final double? buttonWidth;
  final double? buttonHeight;
  final String? buttonText;
  final Color? buttonColor;
  final Color? textColor;

  const CameraImagePicker({
    Key? key,
    required this.onImageSelected,
    this.buttonWidth = 200,
    this.buttonHeight = 50,
    this.buttonText = 'Take Photo',
    this.buttonColor,
    this.textColor,
  }) : super(key: key);

  @override
  State<CameraImagePicker> createState() => _CameraImagePickerState();
}

class _CameraImagePickerState extends State<CameraImagePicker> {
  final ImagePicker _picker = ImagePicker();
  File? _imageFile;

  Future<void> _takePhoto() async {
    try {
      final XFile? photo = await _picker.pickImage(
        source: ImageSource.camera,
        preferredCameraDevice: CameraDevice.rear,
      );

      if (photo != null) {
        setState(() {
          _imageFile = File(photo.path);
        });
        widget.onImageSelected(_imageFile);
      }
    } catch (e) {
      debugPrint('Error picking image: $e');
      // You might want to handle the error appropriately
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (_imageFile != null)
        ElevatedButton(
          onPressed: _takePhoto,
          style: ElevatedButton.styleFrom(
            backgroundColor: widget.buttonColor,
            minimumSize: Size(widget.buttonWidth!, widget.buttonHeight!),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: Text(
            widget.buttonText!,
            style: TextStyle(
              color: widget.textColor,
              fontSize: 16,
            ),
          ),
        ),
      ],
    );
  }
}