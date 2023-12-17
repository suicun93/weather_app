import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'weather_detail.controller.dart';

class WeatherDetailView extends GetView<WeatherDetailController> {
  const WeatherDetailView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('WeatherDetailView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'WeatherDetailView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
