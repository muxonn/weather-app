import 'package:flutter/material.dart';
import 'package:gradient_icon/gradient_icon.dart';

class HumidityBlock extends StatelessWidget {
  const HumidityBlock({required this.humidity});

  final int humidity;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      color: Colors.white,
      child: Column(
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
                  colors: const [
                    Colors.black,
                    Colors.black,
                    Colors.white,
                    Colors.white,
                  ],
                  // Change bad fill scale by multiplying the valaue
                  stops: [0, humidity / 100 * .7, humidity / 100 * .7, 1],
                ),
                size: 60,
              ),
              const Positioned.fill(
                top: 8.3,
                right: 10,
                child: Icon(
                  Icons.water_drop_outlined,
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
