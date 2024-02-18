import 'dart:math';

import 'package:flutter/material.dart';

class WindBlock extends StatelessWidget {
  WindBlock({required this.windDirection, required this.windSpeed});

  final String windDirection;
  final double windSpeed;

  // TODO: Simplify that, maybe add an enum or something

  final Map<String, int> directionIndex = {
    'N': 0,
    'NNE': 1,
    'NE': 2,
    'ENE': 3,
    'E': 4,
    'ESE': 5,
    'SE': 6,
    'SSE': 7,
    'S': 8,
    'SSW': 9,
    'SW': 10,
    'WSW': 11,
    'W': 12,
    'WNW': 13,
    'NW': 14,
    'NNW': 15,
  };

  @override
  Widget build(BuildContext context) {
    Map<String, double> directionRadians = {};

    directionIndex.forEach((dir, index) {
      double angle = index * (360 / 16);
      directionRadians[dir] = angle / 180 * pi;
    });
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
          SizedBox(height: 5),
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
                    ),
                  ),
                ),
                Stack(
                  children: List.generate(
                    16,
                    (index) {
                      final double angle =
                          ((index - 4) * (360 / 16)) * (pi / 180);
                      print(angle);
                      final double radius = 25;

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
                                ? Colors.red
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
          Text('${windSpeed.toString()}kph - ${windDirection}',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              )),
        ],
      ),
    );
  }
}
