import 'package:flutter/material.dart';

class HourSection extends StatelessWidget {
  const HourSection({
    required this.time,
    required this.temperatureCelcius,
    required this.conditionText,
  });

  final String time;
  final String temperatureCelcius;
  final String conditionText;

  @override
  Widget build(BuildContext context) {
    Text x = Text(time);

    return Container(
      width: 350,
      child: Row(
        //crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //mainAxisSize: MainAxisSize.min,
        children: [
          headline(time),
          headline(temperatureCelcius),
          headline(conditionText),
        ],
      ),
    );
  }

  Widget headline(String text) {
    return Text(
      text,
      overflow: TextOverflow.ellipsis,
    );
  }
}
