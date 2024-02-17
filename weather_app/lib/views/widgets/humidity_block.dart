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
      color: Colors.grey,
      child: Center(
        child: GradientIcon(
          icon: Icons.cloud,
          gradient: LinearGradient(
            colors: const [
              Colors.black,
              Colors.grey,
              Colors.white,
              Colors.white,
            ],
            stops: [0, humidityValue, humidityValue, 1],
          ),
          size: 60,
        ),
      ),
    );
  }
}
