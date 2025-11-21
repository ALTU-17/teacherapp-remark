import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:crop_your_image/crop_your_image.dart';

class CropScreen extends StatefulWidget {
  final Uint8List imageData;
  final double? aspectRatio;

  const CropScreen({Key? key, required this.imageData, this.aspectRatio}) : super(key: key);

  @override
  State<CropScreen> createState() => _CropScreenState();
}

class _CropScreenState extends State<CropScreen> {
  final _controller = CropController();
  bool _isCropping = false;

  // DO NOT call _controller.dispose() here if CropController doesn't have dispose()

  void _onCrop() {
    setState(() => _isCropping = true);
    // Trigger cropping; result will be delivered via the onCropped callback below.
    _controller.crop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Crop Image'),
        actions: [
          TextButton(
            onPressed: _isCropping ? null : _onCrop,
            child: _isCropping
                ? const SizedBox(width: 18, height: 18, child: CircularProgressIndicator(strokeWidth: 2))
                : const Text('Done', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Crop(
                controller: _controller,
                image: widget.imageData,
                aspectRatio: widget.aspectRatio,
                // Receive cropped result here
                onCropped: (Uint8List croppedData) {
                  if (!mounted) return;
                  Navigator.of(context).pop(croppedData);
                },
                // optional visual settings
                withCircleUi: false,
                baseColor: Colors.black,
                maskColor: Colors.black.withOpacity(0.5),
                cornerDotBuilder: (size, edge) => const _DotControl(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16),
              child: Row(
                children: [
                  ElevatedButton.icon(
                    onPressed: _isCropping ? null : () => Navigator.of(context).pop(null),
                    icon: const Icon(Icons.close),
                    label: const Text('Cancel'),
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.grey),
                  ),
                  const Spacer(),
                  ElevatedButton.icon(
                    onPressed: _isCropping ? null : _onCrop,
                    icon: const Icon(Icons.check),
                    label: const Text('Crop'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DotControl extends StatelessWidget {
  const _DotControl({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 12,
      height: 12,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        border: Border.all(color: Colors.black26),
      ),
    );
  }
}