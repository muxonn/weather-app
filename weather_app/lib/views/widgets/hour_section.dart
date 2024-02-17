import 'package:flutter/material.dart';

class HourSection extends StatelessWidget {
  const HourSection({
    required this.time,
    required this.temperatureCelcius,
    required this.conditionText,
    required this.conditionIcon,
  });

  final String time;
  final String temperatureCelcius;
  final String conditionText;
  final String conditionIcon;

  @override
  Widget build(BuildContext context) {
    print(conditionText);
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(top: 8, bottom: 8),
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
              Container(
                width: 160,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.network(
                      "https:$conditionIcon",
                      width: 20,
                    ),
                    headline(conditionText, false),
                  ],
                ),
              ),
            ],
          ),
        ),
        if (time == "11pm") Divider(height: 5),
      ],
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
