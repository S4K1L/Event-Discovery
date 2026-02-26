import 'dart:io';
import 'package:flutter/material.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class SwipeableMediaCard extends StatefulWidget {
  final File file;
  final bool isTop;
  final double dragOffsetX;
  final Function(DragUpdateDetails)? onPanUpdate;
  final Function(DragEndDetails)? onPanEnd;
  final VoidCallback onRemove;
  final VoidCallback onTap;
  final bool isVideo;

  const SwipeableMediaCard({
    super.key,
    required this.file,
    required this.isTop,
    required this.dragOffsetX,
    required this.onPanUpdate,
    required this.onPanEnd,
    required this.onRemove,
    required this.onTap,
    required this.isVideo,
  });

  @override
  State<SwipeableMediaCard> createState() => _SwipeableMediaCardState();
}

class _SwipeableMediaCardState extends State<SwipeableMediaCard> {
  String? thumbnailPath;

  @override
  void initState() {
    super.initState();
    if (widget.isVideo) {
      generateThumbnail();
    }
  }

  Future<void> generateThumbnail() async {
    final thumb = await VideoThumbnail.thumbnailFile(
      video: widget.file.path,
      imageFormat: ImageFormat.JPEG,
      quality: 100,
    );

    if (mounted) {
      setState(() {
        thumbnailPath = thumb;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: widget.isTop ? widget.onPanUpdate : null,
      onPanEnd: widget.isTop ? widget.onPanEnd : null,
      onTap: widget.onTap,
      child: Transform.translate(
        offset: widget.isTop ? Offset(widget.dragOffsetX, 0) : Offset.zero,
        child: Transform.rotate(
          angle: widget.isTop ? widget.dragOffsetX * 0.001 : 0,
          child: Stack(
            children: [
              Container(
                width: 300,
                height: 400,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 6,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: widget.isVideo
                      ? Stack(
                          children: [
                            // Thumbnail
                            if (thumbnailPath != null)
                              Image.file(
                                File(thumbnailPath!),
                                fit: BoxFit.cover,
                                width: double.infinity,
                                height: double.infinity,
                              )
                            else
                              const Center(child: CircularProgressIndicator()),

                            // Play icon overlay
                            const Center(
                              child: Icon(
                                Icons.play_circle_fill,
                                color: Colors.white,
                                size: 50,
                              ),
                            ),
                          ],
                        )
                      : Image.file(widget.file, fit: BoxFit.cover),
                ),
              ),

              Positioned(
                top: 6,
                right: 6,
                child: GestureDetector(
                  onTap: widget.onRemove,
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    decoration: const BoxDecoration(
                      color: Colors.black54,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.close,
                      size: 14,
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
