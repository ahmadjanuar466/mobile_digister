import 'package:digister/models/weather_model.dart';
import 'package:digister/utils/global.dart';
import 'package:digister/utils/image_constants.dart';
import 'package:digister/utils/lottie_asset.dart';
import 'package:digister/utils/size_util.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class CardHeader extends StatelessWidget {
  const CardHeader({
    super.key,
    required this.weather,
  });

  final Weather? weather;

  String _getWeatherAnimation() {
    if (weather == null) return LottieAssets.sunny;

    switch (weather!.condition) {
      case 'Partly cloudy':
      case 'Cloudy':
      case 'Overcast':
      case 'Mist':
        return LottieAssets.cloud;
      case 'Patchy rain possible':
      case 'Patchy rain nearby':
      case 'Patchy light rain':
      case 'Light rain':
      case 'Moderate rain at times':
      case 'Moderate rain':
      case 'Heavy rain at times':
      case 'Heavy rain':
      case 'Light freezing rain':
      case 'Moderate or heavy freezing rain':
      case 'Light rain shower':
      case 'Moderate or heavy rain shower':
      case 'Torrential rain shower':
        return LottieAssets.rain;
      case 'Thundery outbreaks possible':
      case 'Patchy light rain with thunder':
      case 'Moderate or heavy rain with thunder':
        return LottieAssets.thunder;
      default:
        return LottieAssets.sunny;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      height: 180.v,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.h),
        image: const DecorationImage(
          image: ExactAssetImage(ImageAssets.smartHomeImage),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        padding: EdgeInsets.all(10.h),
        decoration: BoxDecoration(
          color: Colors.black54,
          borderRadius: BorderRadius.circular(20.h),
        ),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${user.housingName} Blok ${user.block}, No. ${user.houseNum}",
                    style: theme.textTheme.bodyLarge!.copyWith(
                      color: theme.colorScheme.primary,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  // Text(
                  //   'Elektronik yang menyala',
                  //   style: theme.textTheme.bodyMedium!.copyWith(
                  //     color: theme.colorScheme.onPrimary,
                  //   ),
                  // ),
                  // const ConnectedDevices()
                ],
              ),
            ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    weather != null ? weather!.cityName! : 'Bandung',
                    style: theme.textTheme.bodyLarge!.copyWith(
                      color: theme.colorScheme.onPrimary,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Stack(
                    children: [
                      Text(
                        weather != null ? '${weather!.temperature}°C' : '21°C',
                        style: theme.textTheme.titleLarge!.copyWith(
                          fontSize: 35.fSize,
                          color: theme.colorScheme.onPrimary,
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 10.h,
                        child: Lottie.asset(
                          _getWeatherAnimation(),
                          width: 35.adaptSize,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    weather != null ? weather!.condition : 'Berawan',
                    style: TextStyle(
                      color: theme.colorScheme.onPrimary,
                    ),
                    overflow: TextOverflow.clip,
                    textAlign: TextAlign.center,
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

class ConnectedDevices extends StatelessWidget {
  const ConnectedDevices({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: 30.h,
          height: 30.v,
          child: IconButton(
            onPressed: () {},
            padding: EdgeInsets.zero,
            icon: Icon(
              Icons.light_rounded,
              color: theme.colorScheme.onPrimary,
            ),
          ),
        ),
        SizedBox(
          width: 30.h,
          height: 30.v,
          child: IconButton(
            onPressed: () {},
            padding: EdgeInsets.zero,
            icon: Icon(
              Icons.ac_unit_rounded,
              color: theme.colorScheme.onPrimary,
            ),
          ),
        ),
        SizedBox(
          width: 30.h,
          height: 30.v,
          child: IconButton(
            onPressed: () {},
            padding: EdgeInsets.zero,
            icon: Icon(
              Icons.tv,
              color: theme.colorScheme.onPrimary,
            ),
          ),
        ),
      ],
    );
  }
}
