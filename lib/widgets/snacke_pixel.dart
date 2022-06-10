import 'package:flutter/material.dart';

class SnackePixel extends StatelessWidget {

  const SnackePixel({Key? key}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xff141e61),
          borderRadius: BorderRadius.circular(3)
        )
      ),
    );
  }
}