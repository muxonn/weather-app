import 'package:flutter/material.dart';
import 'package:gradient_icon/gradient_icon.dart';

class CloudBlock extends StatelessWidget {
  const CloudBlock({required this.cloudiness});

  final int cloudiness;

  @override
  Widget build(BuildContext context) {
    print(cloudiness);
    return Container(
      width: 160,
      height: 150,
      color: Colors.white,
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
                  colors: const [
                    Colors.black,
                    Colors.black,
                    Colors.white,
                    Colors.white,
                  ],
                  stops: [0, cloudiness / 100, cloudiness / 100, 1],
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
