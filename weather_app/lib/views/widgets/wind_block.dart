import 'dart:math';

import 'package:flutter/material.dart';
import 'package:weather_app/data/forecast/wind_dir.dart';

class WindBlock extends StatelessWidget {
  const WindBlock({required this.windDirection, required this.windSpeed});

  final String windDirection;
  final double windSpeed;

  Map<String, int> getDirectionIndex() {
    Map<String, int> directionIndex = {};
    int number = 0;
    for (var i in WindDir.values) {
      directionIndex[i.dir] = number;
      number++;
    }
    return directionIndex;
  }

  Map<String, double> getDirectionRadians() {
    Map<String, double> directionRadians = {};
    int number = 0;
    for (var i in WindDir.values) {
      double angle = number * (360 / 16);
      directionRadians[i.dir] = angle / 180 * pi;
      number++;
    }
    return directionRadians;
  }

  @override
  Widget build(BuildContext context) {
    Map<String, int> directionIndex = getDirectionIndex();
    Map<String, double> directionRadians = getDirectionRadians();

    return Container(
      width: 160,
      height: 150,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Wind',
            style: TextStyle(fontSize: 26),
          ),
          const SizedBox(height: 5),
          Container(
            width: 56,
            height: 56,
            alignment: Alignment.bottomRight,
            child: Stack(
              children: [
                Positioned(
                  top: 8,
                  left: 8,
                  child: Transform.rotate(
                    angle: directionRadians[windDirection]!,
                    child: const Icon(
                      Icons.arrow_upward_rounded,
                      size: 40,
                      color: Colors.black,
                    ),
                  ),
                ),
                Stack(
                  children: List.generate(
                    16,
                    (index) {
                      final double angle =
                          ((index - 4) * (360 / 16)) * (pi / 180);
                      const double radius = 25;

                      final double dotX = radius + radius * cos(angle);
                      final double dotY = radius + radius * sin(angle);

                      return Positioned(
                        left: dotX,
                        top: dotY,
                        child: Container(
                          width: 6,
                          height: 6,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: directionIndex[windDirection] == index
                                ? Colors.blue
                                : Colors.black,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          Text('${windSpeed.toString()}kph / $windDirection',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              )),
        ],
      ),
    );
  }
}
