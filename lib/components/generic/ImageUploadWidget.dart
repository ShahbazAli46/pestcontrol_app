import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageUploadWidget extends StatefulWidget {
  final Function(File) onImageSelected;
  final double? width;
  final double? height;
  final String? title;
  final ImageSource? sourceType; // New parameter for source type

  const ImageUploadWidget({
    Key? key,
    required this.onImageSelected,
    this.width = 150,
    this.height = 150,
    this.title = 'Select an image',
    this.sourceType, // If null, shows both options. If specified, opens that source directly
  }) : super(key: key);

  @override
  _ImageUploadWidgetState createState() => _ImageUploadWidgetState();
}

class _ImageUploadWidgetState extends State<ImageUploadWidget> {
  File? _image;
  final _picker = ImagePicker();

  Future<void> _getImageFromGallery() async {
    try {
      final pickedFile = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
      );

      if (pickedFile != null) {
        setState(() {
          _image = File(pickedFile.path);
        });
        widget.onImageSelected(_image!);
      }
    } catch (e) {
      print('Error picking image from gallery: $e');
    }
  }

  Future<void> _getImageFromCamera() async {
    try {
      final pickedFile = await _picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 80,
      );

      if (pickedFile != null) {
        setState(() {
          _image = File(pickedFile.path);
        });
        widget.onImageSelected(_image!);
      }
    } catch (e) {
      print('Error picking image from camera: $e');
    }
  }

  Future<void> _handleImageSelection() async {
    if (widget.sourceType != null) {
      // If source type is specified, open that directly
      if (widget.sourceType == ImageSource.camera) {
        await _getImageFromCamera();
      } else {
        await _getImageFromGallery();
      }
    } else {
      // If no source type specified, show the bottom sheet with options
      _showImageSourceOptions();
    }
  }

  void _showImageSourceOptions() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(15.0)),
      ),
      builder: (BuildContext context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15.0),
                child: Text(
                  'Select Image Source',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const Divider(height: 1),
              ListTile(
                leading: const Icon(Icons.photo_library, color: Colors.blue),
                title: const Text('Gallery'),
                onTap: () {
                  Navigator.of(context).pop();
                  _getImageFromGallery();
                },
              ),
              const Divider(height: 1),
              ListTile(
                leading: const Icon(Icons.camera_alt, color: Colors.blue),
                title: const Text('Camera'),
                onTap: () {
                  Navigator.of(context).pop();
                  _getImageFromCamera();
                },
              ),
              const SizedBox(height: 10),
              if (_image != null)
                ListTile(
                  leading: const Icon(Icons.delete, color: Colors.red),
                  title: const Text('Remove Photo'),
                  onTap: () {
                    setState(() {
                      _image = null;
                    });
                    Navigator.of(context).pop();
                  },
                ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleImageSelection,
      child: Container(
        width: widget.width,
        height: widget.height,
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey.shade300,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: _image != null
              ? Stack(
            fit: StackFit.expand,
            children: [
              Image.file(
                _image!,
                fit: BoxFit.cover,
              ),
              Positioned(
                right: 8,
                top: 8,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.5),
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: const Icon(
                      Icons.edit,
                      color: Colors.white,
                      size: 20,
                    ),
                    onPressed: _handleImageSelection,
                  ),
                ),
              ),
            ],
          )
              : Container(
            color: Colors.grey.shade100,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  widget.sourceType == ImageSource.camera
                      ? Icons.camera_alt
                      : widget.sourceType == ImageSource.gallery
                      ? Icons.photo_library
                      : Icons.add_a_photo,
                  size: 40.0,
                  color: Colors.grey.shade400,
                ),
                const SizedBox(height: 8.0),
                Text(
                  widget.title ?? 'Select an image',
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}