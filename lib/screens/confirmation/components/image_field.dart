import 'dart:io';
import 'package:digister/utils/global.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class ImageField extends StatelessWidget {
  const ImageField({
    super.key,
    this.onTap,
    this.image,
    this.onViewImage,
    this.onCancelImage,
  });

  final void Function()? onTap;
  final void Function()? onViewImage;
  final void Function()? onCancelImage;
  final XFile? image;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 200,
      child: DottedBorder(
        borderType: BorderType.RRect,
        radius: const Radius.circular(16),
        color: isDarkMode ? theme.colorScheme.onPrimary : Colors.black45,
        child: Center(
          child: image == null
              ? GestureDetector(
                  onTap: onTap,
                  child: const ImageEmpty(),
                )
              : ImageExist(
                  image: image,
                  onViewImage: onViewImage,
                  onCancelImage: onCancelImage,
                ),
        ),
      ),
    );
  }
}

class ImageExist extends StatelessWidget {
  const ImageExist({
    super.key,
    required this.image,
    this.onViewImage,
    this.onCancelImage,
  });

  final XFile? image;
  final void Function()? onViewImage;
  final void Function()? onCancelImage;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Image.file(
            File(image!.path),
            width: 1000.0,
            fit: BoxFit.contain,
          ),
          TextButton(
            onPressed: onViewImage,
            child: const Text(
              "View Image",
              style: TextStyle(color: Colors.blue),
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: IconButton(
              onPressed: onCancelImage,
              icon: const Icon(
                Icons.cancel,
                color: Colors.red,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ImageEmpty extends StatelessWidget {
  const ImageEmpty({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.image_rounded,
          color: isDarkMode ? theme.colorScheme.onPrimary : Colors.black26,
          size: 70,
        ),
        Text(
          "Tekan untuk mengambil gambar",
          style: theme.textTheme.titleMedium,
        ),
      ],
    );
  }
}

class ImageModalContent extends StatelessWidget {
  const ImageModalContent({
    super.key,
    required this.context,
    this.file,
    this.bytes,
  });

  final BuildContext context;
  final XFile? file;
  final Uint8List? bytes;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 400,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          if (file != null)
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.file(
                File(file!.path),
                width: 1000.0,
                fit: BoxFit.fitHeight,
              ),
            ),
          if (bytes != null)
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.memory(
                bytes!,
                width: 1000.0,
                fit: BoxFit.fitHeight,
              ),
            ),
          Positioned(
            top: 0,
            right: 0,
            child: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(
                Icons.cancel_outlined,
                color: Colors.red,
                size: 30,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
