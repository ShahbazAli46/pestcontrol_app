import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class MultiImagePicker extends StatefulWidget {
  final Function(List<File>) onImagesSelected;
  final int maxImages;
  final double spacing;
  final int crossAxisCount;

  const MultiImagePicker({
    Key? key,
    required this.onImagesSelected,
    this.maxImages = 10,
    this.spacing = 8.0,
    this.crossAxisCount = 3,
  }) : super(key: key);

  @override
  _MultiImagePickerState createState() => _MultiImagePickerState();
}

class _MultiImagePickerState extends State<MultiImagePicker> {
  final List<File> _selectedImages = [];
  final ImagePicker _picker = ImagePicker();

  Future<void> _takePhoto() async {
    final XFile? photo = await _picker.pickImage(source: ImageSource.camera);

    if (photo != null) {
      setState(() {
        _selectedImages.add(File(photo.path));
      });
      widget.onImagesSelected(_selectedImages);
    }
  }

  void _removeImage(int index) {
    setState(() {
      _selectedImages.removeAt(index);
    });
    widget.onImagesSelected(_selectedImages);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Add photo button
        if (_selectedImages.length < widget.maxImages)
          ElevatedButton.icon(
            onPressed: _takePhoto,
            icon: const Icon(Icons.camera_alt),
            label: const Text('Take Photo'),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            ),
          ),

        const SizedBox(height: 16),

        // Image grid
        if (_selectedImages.isNotEmpty)
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: widget.crossAxisCount,
              crossAxisSpacing: widget.spacing,
              mainAxisSpacing: widget.spacing,
            ),
            itemCount: _selectedImages.length,
            itemBuilder: (context, index) {
              return Stack(
                children: [
                  // Image
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: Image.file(
                      _selectedImages[index],
                      width: double.infinity,
                      height: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),

                  // Delete button
                  Positioned(
                    top: 4,
                    right: 4,
                    child: GestureDetector(
                      onTap: () => _removeImage(index),
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.close,
                          color: Colors.white,
                          size: 16,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
      ],
    );
  }
}