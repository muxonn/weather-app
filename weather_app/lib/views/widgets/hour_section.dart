import 'package:flutter/material.dart';

class HourSection extends StatelessWidget {
  const HourSection({
    required this.time,
    required this.date,
    required this.temperatureCelcius,
    required this.conditionText,
    required this.conditionIcon,
  });

  final String time;
  final String date;
  final String temperatureCelcius;
  final String conditionText;
  final String conditionIcon;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (time == "12am")
          Row(
            children: [
              const Expanded(child: Divider(height: 5)),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Text(date.split(' ')[0]),
              ),
              const Expanded(child: Divider(height: 5)),
            ],
          ),
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
      ],
    );
  }

  Widget headline(String text, bool isTime) {
    FontWeight weight = FontWeight.bold;
    isTime ? weight = FontWeight.normal : FontWeight.bold;
    return Text(
      text,
      style:
          //Prevent render overflow
          TextStyle(fontSize: text.length < 15 ? 18 : 14, fontWeight: weight),
    );
  }
}
