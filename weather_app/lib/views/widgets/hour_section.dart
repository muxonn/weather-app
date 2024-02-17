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
    return Container(
      child: Row(
        //crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 140,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                headline(time, true),
                SizedBox(width: 30),
                headline('$temperatureCelcius℃', false),
              ],
            ),
          ),
          headline(conditionText, false),
        ],
      ),
    );
  }

  Widget headline(String text, bool isTime) {
    FontWeight weight = FontWeight.bold;
    isTime ? weight = FontWeight.normal : FontWeight.bold;
    return Text(
      text,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(fontSize: 18, fontWeight: weight),
    );
  }
}
