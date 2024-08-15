import 'package:digister/utils/image_constants.dart';
import 'package:digister/utils/size_util.dart';
import 'package:flutter/material.dart';

class ImagePickerBottomSheet extends StatelessWidget {
  const ImagePickerBottomSheet({
    super.key,
    this.onCameraTap,
    this.onGalleryTap,
  });

  final void Function()? onCameraTap;
  final void Function()? onGalleryTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 160.v,
      padding: EdgeInsets.all(16.h),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            'Ambil dari',
            style: TextStyle(
              fontSize: 18.fSize,
            ),
          ),
          SizedBox(height: 15.v),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ImagePickerChoice(
                onTap: onCameraTap,
                imageAsset: ImageAssets.cameraImage,
                text: "Camera",
              ),
              ImagePickerChoice(
                onTap: onGalleryTap,
                imageAsset: ImageAssets.galleryImage,
                text: "Gallery",
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ImagePickerChoice extends StatelessWidget {
  const ImagePickerChoice({
    super.key,
    this.onTap,
    required this.imageAsset,
    required this.text,
  });

  final void Function()? onTap;
  final String imageAsset;
  final String text;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 80,
        height: 80,
        child: Column(
          children: [
            Image.asset(
              imageAsset,
              height: 50,
            ),
            Text(text),
          ],
        ),
      ),
    );
  }
}
