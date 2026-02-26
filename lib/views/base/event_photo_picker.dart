import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_extension/views/base/swipeable_media_card.dart';
import 'package:flutter_extension/views/base/video_preview.dart';

class EventCoverMediaPicker extends StatefulWidget {
  final List<String>? initialMedia;
  final Function(List<File>)? onMediaPicked;

  const EventCoverMediaPicker({
    super.key,
    this.initialMedia,
    this.onMediaPicked,
  });

  @override
  State<EventCoverMediaPicker> createState() => _EventCoverMediaPickerState();
}

class _EventCoverMediaPickerState extends State<EventCoverMediaPicker> {
  List<File> mediaFiles = [];
  double dragOffsetX = 0;

  Future<void> pickMedia() async {
    final result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.media,
    );

    if (result != null) {
      final files = result.paths.map((e) => File(e!)).toList();

      setState(() {
        mediaFiles.addAll(files);
      });

      widget.onMediaPicked?.call(files);
    }
  }

  void removeMedia(int index) {
    setState(() {
      mediaFiles.removeAt(index);
    });

    widget.onMediaPicked?.call(mediaFiles);
  }

  bool isVideo(File file) {
    final ext = file.path.split('.').last.toLowerCase();
    return ['mp4', 'mov', 'avi', 'mkv'].contains(ext);
  }

  @override
  Widget build(BuildContext context) {
    final hasMedia = mediaFiles.isNotEmpty;
    return GestureDetector(
      onTap: pickMedia,
      child: Container(
        constraints: const BoxConstraints(minHeight: 150),
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: hasMedia
            ? SizedBox(
                height: 450,
                child: Stack(
                  children: List.generate(mediaFiles.length, (index) {
                    final file = mediaFiles[index];
                    final reversedIndex = mediaFiles.length - 1 - index;
                    final isTop = index == mediaFiles.length - 1;

                    return Positioned(
                      top: reversedIndex * 10,
                      left: reversedIndex * 10,
                      child: SwipeableMediaCard(
                        file: file,
                        isTop: isTop,
                        dragOffsetX: dragOffsetX,

                        isVideo: isVideo(file),

                        onTap: () => openPreview(file),

                        onRemove: () => removeMedia(index),

                        onPanUpdate: (details) {
                          setState(() {
                            dragOffsetX += details.delta.dx;
                          });
                        },

                        onPanEnd: (details) {
                          if (dragOffsetX > 100 || dragOffsetX < -100) {
                            removeMedia(index);
                          }

                          setState(() {
                            dragOffsetX = 0;
                          });
                        },
                      ),
                    );
                  }),
                ),
              )
            : const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.upload, size: 28),
                    SizedBox(height: 8),
                    Text("Upload Media"),
                  ],
                ),
              ),
      ),
    );
  }

  void openPreview(File file) {
    if (isVideo(file)) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => VideoPreviewScreen(file: file)),
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => Scaffold(
            backgroundColor: Colors.black,
            appBar: AppBar(backgroundColor: Colors.transparent),
            body: Center(child: Image.file(file)),
          ),
        ),
      );
    }
  }
}
