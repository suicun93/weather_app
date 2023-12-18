import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../generated/locales.g.dart';
import '../../common/const.dart';
import '../../common/mini_function.dart';
import '../../common/theme/theme.dart';
import 'forecast.response.dart';
import 'weather_detail.controller.dart';

class WeatherDetailView extends GetView<WeatherDetailController> {
  const WeatherDetailView({Key? key}) : super(key: key);

  Widget get errorWidget => Column(
        children: [
          const SizedBox(height: 100),
          const Icon(Icons.wifi_tethering_error, color: red400, size: 100),
          const SizedBox(height: 20),
          Text(
            LocaleKeys.fetchWeatherFailed.tr,
            style: body14.copyWith(color: red500, fontWeight: FontWeight.w500),
          ),
        ],
      );

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return Scaffold(
          appBar: AppBar(
            title: Text(LocaleKeys.forecastDetail.tr),
            centerTitle: true,
          ),
          body: Stack(
            children: [
              RefreshIndicator(
                onRefresh: () async {
                  controller.getForecast();
                },
                child: ListView.builder(
                  padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                  itemBuilder: (BuildContext context, int index) {
                    if (controller.forecasts.isEmpty) {
                      return errorWidget;
                    } else {
                      return weatherItem(controller.forecasts[index]);
                    }
                  },
                  itemCount: controller.forecasts.isEmpty
                      ? 1
                      : controller.forecasts.length,
                ),
              ),
              controller.ready.value ? Container() : loadingWidget(opacity: 1),
            ],
          ),
        );
      },
    );
  }

  Widget weatherItem(Forecast forecast) {
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
          Text(
            forecast.dtTxt?.toStrTimeToShow ?? '',
            style: h4.copyWith(fontSize: 16),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
          const SizedBox(height: 6),
          Text(
            '${LocaleKeys.weather.tr}: ${forecast.weather?[0].description ?? ''}',
            style: body14.copyWith(color: black),
          ),
          const SizedBox(height: 4),
          dividerThin,
          const SizedBox(height: 4),
          Text(
            '${LocaleKeys.temperature.tr}: ${forecast.main?.temp ?? '0'}',
            style: body14.copyWith(color: black),
          ),
          const SizedBox(height: 4),
          Text(
            '${LocaleKeys.temperatureMax.tr}: ${forecast.main?.tempMax ?? '0'}',
            style: body14.copyWith(color: black),
          ),
          const SizedBox(height: 4),
          Text(
            '${LocaleKeys.temperatureMin.tr}: ${forecast.main?.tempMin ?? '0'}',
            style: body14.copyWith(color: black),
          ),
          const SizedBox(height: 4),
          Text(
            '${LocaleKeys.feelsLike.tr}: ${forecast.main?.feelsLike ?? '0'}',
            style: body14.copyWith(color: black),
          ),
          const SizedBox(height: 4),
          dividerThin,
          const SizedBox(height: 4),
          Text(
            '${LocaleKeys.humidity.tr}: ${forecast.main?.humidity ?? '0'}',
            style: body14.copyWith(color: black),
          ),
          const SizedBox(height: 4),
          dividerThin,
          const SizedBox(height: 4),
          Text(
            '${LocaleKeys.pressure.tr}: ${forecast.main?.pressure ?? '0'}',
            style: body14.copyWith(color: black),
          ),
          const SizedBox(height: 4),
          dividerThin,
          const SizedBox(height: 4),
          Text(
            '${LocaleKeys.visibility.tr}: ${(forecast.visibility ?? 0)}',
            style: body14.copyWith(color: black),
          ),
          const SizedBox(height: 4),
          dividerThin,
          const SizedBox(height: 4),
          Text(
            '${LocaleKeys.windSpd.tr}: ${(forecast.wind?.speed ?? 0)}',
            style: body14.copyWith(color: black),
          ),
          const SizedBox(height: 4),
          Text(
            '${LocaleKeys.windDeg.tr}: ${(forecast.wind?.deg ?? 0)}',
            style: body14.copyWith(color: black),
          ),
          const SizedBox(height: 4),
          dividerThin,
          const SizedBox(height: 4),
          Text(
            '${LocaleKeys.cloud.tr}: ${(forecast.clouds?.all ?? 0)}',
            style: body14.copyWith(color: black),
          ),
          const SizedBox(height: 4),
          dividerThin,
        ],
      ),
    );
  }
}
