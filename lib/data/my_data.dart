import 'package:flutter/material.dart';

class MyText extends StatelessWidget {
  final String text;
  final FontWeight fontWeight;
  final double size;

  const MyText(
      {super.key,
      required this.text,
      required this.size,
      required this.fontWeight});

  @override
  Widget build(BuildContext context) {
    return Text(text,
        style: Theme.of(context).textTheme.titleMedium!.copyWith(
            fontWeight: fontWeight, color: Colors.white, fontSize: size));
  }
}
