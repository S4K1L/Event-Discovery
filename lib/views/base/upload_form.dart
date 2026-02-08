import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_extension/util/app_colors.dart';
import 'package:flutter_extension/util/style.dart';
import 'package:flutter_svg/flutter_svg.dart';

class UploadInputField extends StatefulWidget {
  final String hintText;
  final Function(PlatformFile file)? onFileSelected;

  const UploadInputField({
    super.key,
    required this.hintText,
    this.onFileSelected,
  });

  @override
  State<UploadInputField> createState() => _UploadInputFieldState();
}

class _UploadInputFieldState extends State<UploadInputField> {
  String? fileName;

  Future<void> _pickFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'jpg', 'png', 'jpeg'],
    );

    if (result != null && result.files.isNotEmpty) {
      final file = result.files.first;

      setState(() {
        fileName = file.name;
      });

      if (widget.onFileSelected != null) {
        widget.onFileSelected!(file);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _pickFile,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: double.infinity,
        height: 48,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.grey[200]!),
        ),
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.symmetric(horizontal: 14),
        child: Row(
          children: [
            Expanded(
              child: Text(
                fileName ?? widget.hintText,
                style: AppTextStyles.text14(
                  color: fileName == null
                      ? AppColors.grey[400]
                      : AppColors.grey[800],
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            SvgPicture.asset("assets/icons/upload.svg", width: 18, height: 18),
          ],
        ),
      ),
    );
  }
}
