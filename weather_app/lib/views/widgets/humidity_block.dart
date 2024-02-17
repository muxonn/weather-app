import 'package:flutter/material.dart';
import 'package:gradient_icon/gradient_icon.dart';

class HumidityBlock extends StatelessWidget {
  const HumidityBlock({required this.humidity});

  final int humidity;

  @override
  Widget build(BuildContext context) {
    double humidityValue = humidity / 100;

    print(humidity);
    return Container(
      width: 160,
      height: 160,
      color: Colors.white,
      child: Column(
        children: [
          const Text(
            'Cloudiness',
            style: TextStyle(fontSize: 26),
          ),
          Stack(
            children: [
              GradientIcon(
                icon: Icons.cloud,
                gradient: LinearGradient(
                  colors: const [
                    Colors.black,
                    Colors.black,
                    Colors.white,
                    Colors.white,
                  ],
                  stops: [0, humidityValue, humidityValue, 1],
                ),
                size: 60,
              ),
              const Positioned.fill(
                top: 8,
                right: 10,
                child: Icon(
                  Icons.cloud_outlined,
                  color: Colors.black,
                  size: 60,
                ),
              ),
            ],
          ),
          Text('${humidity.toString()}%',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              )),
        ],
      ),
    );
  }
}
