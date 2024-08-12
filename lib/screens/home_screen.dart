import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:weather_app_youtube/bloc/weather_bloc.dart';
import 'package:weather_app_youtube/data/background.dart';
import 'package:weather_app_youtube/data/image_const.dart';
import 'package:weather_app_youtube/data/my_data.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String formattedDate = '';

  Timer? timer;

  void updateTime() {
    DateTime now = DateTime.now();
    formattedDate = DateFormat('EEEE d - hh.mm.ssa').format(now);
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      updateTime();
      context.read<WeatherBloc>().add(UpdateTime(DateTime.now()));
      setState(() {});
    });
  }

  @override
  void initState() {
    super.initState();
    updateTime();
    startTimer();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  //method to get Weather Icon
  Widget getIcon(int code) {
    switch (code) {
      case > 200 && <= 300:
        return Image.asset(
          ImageConstants.thunder,
        );
        break;
      case > 300 && <= 400:
        return Image.asset(ImageConstants.lightRain);
        break;
      case > 500 && <= 600:
        return Image.asset(ImageConstants.heavyRain);
        break;
      case > 600 && <= 700:
        return Image.asset(ImageConstants.snow);
        break;
      case > 700 && <= 800:
        return Image.asset(ImageConstants.haze);
        break;
      case 800:
        return Image.asset(ImageConstants.sunny);
        break;
      case > 800 && <= 804:
        return Image.asset(ImageConstants.partialCloud);
        break;
      default:
        return Image.asset(ImageConstants.sunny2);
    }
  }

  Timer getTime() {
    return Timer.periodic(const Duration(seconds: 60), (timer) {
      context.read<WeatherBloc>().add(UpdateTime(DateTime.now()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarBrightness: Brightness.dark,
        ),
      ),
      body: Stack(
        children: [
          const Background(),
          BlocBuilder<WeatherBloc, WeatherState>(
            builder: (context, state) {
              if (state is WeatherSuccess) {
                return Padding(
                  padding: const EdgeInsets.fromLTRB(
                      40, 1.2 * kToolbarHeight, 40, 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MyText(
                          text:
                              "${state.weather.areaName} ${state.weather.country}",
                          size: 16,
                          fontWeight: FontWeight.w300),
                      const MyText(
                          text: "Good Morning",
                          size: 24,
                          fontWeight: FontWeight.bold),
                      getIcon(state.weather.weatherConditionCode!.toInt()),
                      Center(
                          child: MyText(
                              text:
                                  "${state.weather.temperature!.celsius!.round()}\u2103",
                              size: 60,
                              fontWeight: FontWeight.bold)),
                      Center(
                          child: MyText(
                              text: state.weather.weatherMain!
                                  .toUpperCase()
                                  .toString(),
                              size: 24,
                              fontWeight: FontWeight.w500)),
                      Center(
                        child: MyText(
                            text: formattedDate,
                            size: 15,
                            fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(height: 45),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Wrap(
                            children: [
                              Image.asset(
                                ImageConstants.sunny2,
                                height: 40,
                                width: 40,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const MyText(
                                      text: "Sunrise",
                                      size: 12,
                                      fontWeight: FontWeight.w100),
                                  MyText(
                                      text: DateFormat()
                                          .add_jm()
                                          .format(state.weather.sunrise!),
                                      size: 12,
                                      fontWeight: FontWeight.w400)
                                ],
                              )
                            ],
                          ),
                          Wrap(
                            children: [
                              Image.asset(
                                ImageConstants.moon,
                                height: 40,
                                width: 40,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const MyText(
                                      text: "Sunset",
                                      size: 12,
                                      fontWeight: FontWeight.w100),
                                  MyText(
                                      text: DateFormat()
                                          .add_jm()
                                          .format(state.weather.sunset!),
                                      size: 12,
                                      fontWeight: FontWeight.w400),
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                        child: Divider(
                          thickness: 0.1,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Wrap(
                            children: [
                              Image.asset(
                                ImageConstants.tempRed,
                                height: 40,
                                width: 40,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  MyText(
                                      text: state.weather.tempMax.toString(),
                                      size: 12,
                                      fontWeight: FontWeight.w400)
                                ],
                              )
                            ],
                          ),
                          Wrap(
                            children: [
                              Image.asset(
                                ImageConstants.tempBlue,
                                height: 40,
                                width: 40,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const MyText(
                                      text: "Temp Min",
                                      size: 12,
                                      fontWeight: FontWeight.w100),
                                  MyText(
                                      text: state.weather.tempMin.toString(),
                                      size: 12,
                                      fontWeight: FontWeight.w400)
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          )
        ],
      ),
    );
  }
}
