import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'services/weather_service.dart';
import 'widget/detail.dart';

class HomePage extends StatefulWidget {
  final weather;

  const HomePage({Key key, this.weather}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  dynamic weatherData;

  @override
  void initState() {
    weatherData = widget.weather;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    int temperature = weatherData['main']['temp'].toInt();

    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height,
                      decoration: BoxDecoration(
                          color: Colors.blueAccent,
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(WeatherService()
                                  .getWeatherBackground(weatherData['weather']
                                          [0]['main']
                                      .toString())))),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 140, left: 10, right: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(temperature.toString(),
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 100)),
                                  Text("°C",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 32)),
                                ],
                              ),
                            ],
                          ),
                          Text(weatherData['weather'][0]['main'].toString(),
                              style:
                                  TextStyle(color: Colors.white, fontSize: 28)),
                        ],
                      ),
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height,
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Detail(weatherData: weatherData),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 32, left: 20),
            child: Text(weatherData['name'],
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 26)),
          ),
        ],
      ),
    );
  }
}
