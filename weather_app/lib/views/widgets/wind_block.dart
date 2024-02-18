import 'dart:math';

import 'package:flutter/material.dart';

class WindBlock extends StatelessWidget {
  const WindBlock({required this.windDirection, required this.windSpeed});

  final String windDirection;
  final double windSpeed;

  @override
  Widget build(BuildContext context) {
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
                  child: Icon(
                    Icons.arrow_downward_rounded,
                    size: 40,
                  ),
                ),
                Stack(
                  children: List.generate(
                    16,
                    (index) {
                      final double angle = (index * (360 / 16)) * (pi / 180);
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
                            color: Colors.black,
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
