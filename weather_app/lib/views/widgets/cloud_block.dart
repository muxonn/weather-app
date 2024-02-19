import 'package:flutter/material.dart';
import 'package:gradient_icon/gradient_icon.dart';

class CloudBlock extends StatelessWidget {
  const CloudBlock({required this.cloudiness, required this.isDark});

  final int cloudiness;
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
            'Cloudiness',
            style: TextStyle(fontSize: 26),
          ),
          Stack(
            children: [
              GradientIcon(
                icon: Icons.cloud,
                gradient: LinearGradient(
                  colors: [
                    primaryColor,
                    primaryColor,
                    Colors.transparent,
                    Colors.transparent,
                  ],
                  stops: [0, cloudiness / 100, cloudiness / 100, 1],
                ),
                size: 60,
              ),
              const Positioned.fill(
                top: 8.5,
                right: 10,
                child: Icon(
                  Icons.cloud_outlined,
                  size: 60,
                ),
              ),
            ],
          ),
          Text('${cloudiness.toString()}%',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              )),
        ],
      ),
    );
  }
}
