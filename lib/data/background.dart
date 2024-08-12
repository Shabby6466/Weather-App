import 'dart:ui';
import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  const Background({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [

        Align(
            alignment: const Alignment(0, -1.2),
            child: Container(
              height: 300,
              width: 600,
              color: const Color(0xFFFFAB40),
            )),
        Align(
            alignment: const Alignment(3, -0.1),
            child: Container(
              height: 900,
              width: 300,
              decoration: const BoxDecoration(
                color: Color(0xFF673AB7),
                shape: BoxShape.circle,
              ),
            )),
        Align(
            alignment: const Alignment(-3, -0.1),
            child: Container(
              height: 900,
              width: 300,
              decoration: const BoxDecoration(
                color: Color(0xFF673AB7),
                shape: BoxShape.circle,
              ),
            )),
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 100.0, sigmaY: 100.0),
          child: Container(
            decoration: const BoxDecoration(color: Colors.transparent),
          ),
        ),
      ],
    );
  }
}
