import 'package:digister/utils/image_constants.dart';
import 'package:flutter/material.dart';

class AvailableService extends StatelessWidget {
  const AvailableService({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      height: 130,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          Container(
            width: 130,
            height: 130,
            margin: const EdgeInsets.symmetric(horizontal: 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              image: const DecorationImage(
                image: ExactAssetImage(ImageAssets.gallonImage),
                fit: BoxFit.cover,
              ),
            ),
            alignment: Alignment.bottomCenter,
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.black45,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text('Galon', style: TextStyle(color: Colors.white)),
                  Icon(Icons.chevron_right_rounded, color: Colors.white),
                ],
              ),
            ),
          ),
          Container(
            width: 130,
            height: 130,
            margin: const EdgeInsets.symmetric(horizontal: 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              image: const DecorationImage(
                image: ExactAssetImage(ImageAssets.laundryImage),
                fit: BoxFit.cover,
              ),
            ),
            alignment: Alignment.bottomCenter,
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.black45,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text('Laundry', style: TextStyle(color: Colors.white)),
                  Icon(Icons.chevron_right_rounded, color: Colors.white),
                ],
              ),
            ),
          ),
          Container(
            width: 130,
            height: 130,
            margin: const EdgeInsets.symmetric(horizontal: 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              image: const DecorationImage(
                image: ExactAssetImage(ImageAssets.workshopImage),
                fit: BoxFit.cover,
              ),
            ),
            alignment: Alignment.bottomCenter,
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.black45,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text('Bengkel', style: TextStyle(color: Colors.white)),
                  Icon(Icons.chevron_right_rounded, color: Colors.white),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
