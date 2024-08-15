import 'package:digister/utils/image_constants.dart';
import 'package:digister/utils/size_util.dart';
import 'package:flutter/material.dart';

class AvailableService extends StatelessWidget {
  const AvailableService({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      height: 130.v,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          Container(
            width: 130.h,
            height: 130.v,
            margin: EdgeInsets.symmetric(horizontal: 5.h),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.h),
              image: const DecorationImage(
                image: ExactAssetImage(ImageAssets.gallonImage),
                fit: BoxFit.cover,
              ),
            ),
            alignment: Alignment.bottomCenter,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black45,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20.h),
                  bottomRight: Radius.circular(20.h),
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
            width: 130.h,
            height: 130.v,
            margin: EdgeInsets.symmetric(horizontal: 5.h),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.h),
              image: const DecorationImage(
                image: ExactAssetImage(ImageAssets.laundryImage),
                fit: BoxFit.cover,
              ),
            ),
            alignment: Alignment.bottomCenter,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black45,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20.h),
                  bottomRight: Radius.circular(20.h),
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
            width: 130.h,
            height: 130.v,
            margin: EdgeInsets.symmetric(horizontal: 5.h),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.h),
              image: const DecorationImage(
                image: ExactAssetImage(ImageAssets.workshopImage),
                fit: BoxFit.cover,
              ),
            ),
            alignment: Alignment.bottomCenter,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black45,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20.h),
                  bottomRight: Radius.circular(20.h),
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
