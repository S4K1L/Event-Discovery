import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_extension/util/app_colors.dart';
import 'package:flutter_extension/util/style.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';

class EventCoverPhotoPicker extends StatefulWidget {
  final String? initialImage;
  final Function(File? file)? onImagePicked;

  const EventCoverPhotoPicker({
    super.key,
    this.initialImage,
    this.onImagePicked,
  });

  @override
  State<EventCoverPhotoPicker> createState() => _EventCoverPhotoPickerState();
}

class _EventCoverPhotoPickerState extends State<EventCoverPhotoPicker> {
  File? selectedImage;
  final picker = ImagePicker();

  Future<void> pickImage() async {
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      final file = File(picked.path);

      setState(() => selectedImage = file);
      widget.onImagePicked?.call(file);
    }
  }

  void removeImage() {
    setState(() => selectedImage = null);
    widget.onImagePicked?.call(null);
  }

  @override
  Widget build(BuildContext context) {
    final hasImage = selectedImage != null || widget.initialImage != null;

    return GestureDetector(
      onTap: pickImage,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Container(
          height: 150,
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.grey[200]!),
          ),
          child: Stack(
            children: [
              Positioned.fill(
                child: selectedImage != null
                    ? Image.file(selectedImage!, fit: BoxFit.cover)
                    : widget.initialImage != null
                    ? Image.asset(widget.initialImage!, fit: BoxFit.cover)
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            "assets/icons/download.svg",
                            width: 26,
                            height: 26,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "Upload Photo",
                            style: AppTextStyles.text14(
                              color: AppColors.grey[400],
                              weight: AppTextStyles.medium,
                            ),
                          ),
                        ],
                      ),
              ),

              if (hasImage)
                Positioned(
                  top: 8,
                  right: 8,
                  child: GestureDetector(
                    onTap: removeImage,
                    child: Container(
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.black54,
                      ),
                      padding: const EdgeInsets.all(6),
                      child: const Icon(
                        Icons.close,
                        size: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
