import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../generated/locales.g.dart';
import '../../common/const.dart';
import '../../common/theme/theme.dart';
import '../../routes/app_pages.dart';
import '../../services/geo/geolocator.dart';
import '../../services/places/place.response.dart';
import '../../services/weather/weather.response.dart';
import 'home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          title: Text(LocaleKeys.weather.tr),
          centerTitle: true,
        ),
        body: Stack(
          children: [
            RefreshIndicator(
              onRefresh: () async {
                controller.fetchWeather();
              },
              child: ListView(
                padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                children: [
                  /// Search
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: 45,
                      child: TypeAheadField(
                        textFieldConfiguration: TextFieldConfiguration(
                          controller: controller.placeController,
                          decoration: InputDecoration(
                            hintText: LocaleKeys.search.tr,
                            suffix: InkWell(
                              overlayColor: MaterialStateColor.resolveWith(
                                (_) => transparent,
                              ),
                              child: const Icon(
                                Icons.close_rounded,
                                color: greyscale400,
                                size: 20,
                              ),
                              onTap: () {
                                controller.placeController.clear();
                                controller.place.value = null;
                              },
                            ),
                          ),
                        ),
                        onSuggestionsBoxToggle: (_) {
                          controller.autoCompleteIsOpening.value = _;
                          // Recover last choice
                          if (!_) {
                            controller.placeController.text =
                                controller.place.value?.fullName ?? '';
                          }
                        },
                        onSuggestionSelected: (_) {
                          controller.place.value = _;
                        },
                        suggestionsCallback: (_) async {
                          if (_.isEmpty) controller.place.value = null;
                          await controller.getPlaces(key: _);
                          return controller.places;
                        },
                        itemBuilder: (c, Place place) {
                          return Padding(
                            padding: const EdgeInsets.all(16),
                            child: Text(
                              place.fullName ?? '',
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          );
                        },
                        debounceDuration: 500.milliseconds,
                        noItemsFoundBuilder: (_) {
                          return Padding(
                            padding: const EdgeInsets.all(16),
                            child: Text(LocaleKeys.noPlacesFound.tr),
                          );
                        },
                      ),
                    ),
                  ),

                  /// Current location error
                  if (controller.locationError.value != null)
                    _locationPermissionDenied(
                      controller.locationError.value!,
                    ),

                  /// All location
                  ...controller.sortedPlaces.map(
                    (String place) => weatherItem(place),
                  ),
                ],
              ),
            ),
            controller.ready.value ? Container() : loadingWidget(),
          ],
        ),
      ),
    );
  }

  Widget weatherItem(String placeKey) {
    final weather = controller.mapWeather[placeKey];
    final place = controller.mapPlace[placeKey];
    final isCurrent = placeKey == controller.currentLocation;
    if (weather != null) {
      return InkWell(
        onTap: () {
          Get.toNamed(Routes.weatherDetail);
        },
        child: fetchWeatherSuccessInPlace(isCurrent, place, weather),
      );
    } else {
      return fetchWeatherFailedInPlace(isCurrent, place);
    }
  }

  Container fetchWeatherSuccessInPlace(
    bool isCurrent,
    Place? place,
    Weather weather,
  ) {
    return Container(
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: yellow100,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: yellow500,
          width: 2,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              if (isCurrent)
                const Icon(
                  Icons.my_location,
                  color: greyscale600,
                  size: 12,
                ),
              if (isCurrent) const SizedBox(width: 4),
              Expanded(
                child: Text(
                  (place?.fullName ?? '') +
                      (isCurrent ? LocaleKeys.currentLocation.tr : ''),
                  style: h4.copyWith(fontSize: 16),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
              if (!isCurrent)
                InkWell(
                  onTap: () {
                    controller.delete(place!);
                  },
                  child: const Icon(
                    Icons.delete,
                    color: red400,
                    size: 16,
                  ),
                ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            '${LocaleKeys.weather.tr}: ${weather.weather?[0].description ?? ''}',
            style: body14.copyWith(color: black),
          ),
          const SizedBox(height: 4),
          dividerThin,
          const SizedBox(height: 4),
          Text(
            '${LocaleKeys.temperature.tr}: ${weather.main?.temp ?? '0'}',
            style: body14.copyWith(color: black),
          ),
          const SizedBox(height: 4),
          Text(
            '${LocaleKeys.temperatureMax.tr}: ${weather.main?.tempMax ?? '0'}',
            style: body14.copyWith(color: black),
          ),
          const SizedBox(height: 4),
          Text(
            '${LocaleKeys.temperatureMin.tr}: ${weather.main?.tempMin ?? '0'}',
            style: body14.copyWith(color: black),
          ),
          const SizedBox(height: 4),
          Text(
            '${LocaleKeys.feelsLike.tr}: ${weather.main?.feelsLike ?? '0'}',
            style: body14.copyWith(color: black),
          ),
          const SizedBox(height: 4),
          dividerThin,
          const SizedBox(height: 4),
          Text(
            '${LocaleKeys.humidity.tr}: ${weather.main?.humidity ?? '0'}',
            style: body14.copyWith(color: black),
          ),
          const SizedBox(height: 4),
          dividerThin,
          const SizedBox(height: 4),
          Text(
            '${LocaleKeys.pressure.tr}: ${weather.main?.pressure ?? '0'}',
            style: body14.copyWith(color: black),
          ),
          const SizedBox(height: 4),
          dividerThin,
          const SizedBox(height: 4),
          Text(
            '${LocaleKeys.timezone.tr}: GMT ${(weather.timezone ?? 0) / 60 / 60}',
            style: body14.copyWith(color: black),
          ),
          const SizedBox(height: 4),
          dividerThin,
          const SizedBox(height: 4),
          Text(
            '${LocaleKeys.visibility.tr}: ${(weather.visibility ?? 0)}',
            style: body14.copyWith(color: black),
          ),
          const SizedBox(height: 4),
          dividerThin,
          const SizedBox(height: 4),
          Text(
            '${LocaleKeys.windSpd.tr}: ${(weather.wind?.speed ?? 0)}',
            style: body14.copyWith(color: black),
          ),
          const SizedBox(height: 4),
          Text(
            '${LocaleKeys.windDeg.tr}: ${(weather.wind?.deg ?? 0)}',
            style: body14.copyWith(color: black),
          ),
          const SizedBox(height: 4),
          dividerThin,
          const SizedBox(height: 4),
          Text(
            '${LocaleKeys.cloud.tr}: ${(weather.clouds?.all ?? 0)}',
            style: body14.copyWith(color: black),
          ),
          const SizedBox(height: 4),
          dividerThin,
        ],
      ),
    );
  }

  Container fetchWeatherFailedInPlace(bool isCurrent, Place? place) {
    return Container(
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: orange000,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: orange300,
          width: 2,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              if (isCurrent)
                const Icon(
                  Icons.my_location,
                  color: greyscale600,
                  size: 12,
                ),
              if (isCurrent) const SizedBox(width: 4),
              Expanded(
                child: Text(
                  (place?.fullName ?? '') +
                      (isCurrent ? LocaleKeys.currentLocation.tr : ''),
                  style: h4.copyWith(fontSize: 16),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
              if (!isCurrent)
                InkWell(
                  onTap: () {
                    controller.delete(place!);
                  },
                  child: const Icon(
                    Icons.delete,
                    color: red400,
                    size: 16,
                  ),
                ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            LocaleKeys.fetchWeatherFailed.tr,
            style: body14.copyWith(color: red500, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }

  Widget _locationPermissionDenied(LocationState error) {
    switch (error) {
      case LocationState.locationServicesAreDisabled:
      case LocationState.locationPermissionsArePermanentlyDenied:
        return openAppSetting;
      case LocationState.locationPermissionsAreDenied:
        return reRequestLocationPermission;
    }
  }

  Container get openAppSetting {
    return Container(
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: yellow200,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: red500,
          width: 2,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            controller.locationError.value ==
                    LocationState.locationServicesAreDisabled
                ? LocaleKeys.youNeedToOpenAppSettingToEnableLocationService.tr
                : LocaleKeys
                    .youNeedToOpenAppSettingToGrantTheLocationPermission.tr,
            style: body14.copyWith(color: red600, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 6),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () async {
                await openAppSettings();
                controller.fetchCurrentLocation();
              },
              child: Text(LocaleKeys.openAppSetting.tr),
            ),
          ),
        ],
      ),
    );
  }

  Container get reRequestLocationPermission {
    return Container(
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: yellow100,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: red500,
          width: 2,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            LocaleKeys
                .youNeedToGrantLocationPermissionToGetTheCurrentLocation.tr,
            style: body14.copyWith(color: red600, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 6),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () async {
                controller.fetchCurrentLocation();
              },
              child: Text(LocaleKeys.requestPermission.tr),
            ),
          ),
        ],
      ),
    );
  }
}
