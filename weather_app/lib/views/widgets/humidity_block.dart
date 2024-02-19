import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gradient_icon/gradient_icon.dart';

class HumidityBlock extends HookWidget {
  const HumidityBlock({required this.humidity, required this.isDark});

  final int humidity;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    Color primaryColor = isDark ? Colors.white : Colors.black;

    return Container(
      width: 160,
      height: 150,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Humidity',
            style: TextStyle(fontSize: 26),
          ),
          Stack(
            children: [
              GradientIcon(
                icon: Icons.water_drop,
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    primaryColor,
                    primaryColor,
                    Colors.transparent,
                    Colors.transparent,
                  ],
                  // Change bad fill scale by multiplying the valaue
                  stops: [0, humidity / 100 * .7, humidity / 100 * .7, 1],
                ),
                size: 60,
              ),
              Positioned.fill(
                top: 8.1,
                right: 10,
                child: Icon(
                  Icons.water_drop_outlined,
                  size: 60,
                  color: primaryColor,
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
