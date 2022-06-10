import 'package:flutter/material.dart';

class BackgroundPixel extends StatelessWidget {

  const BackgroundPixel({Key? key}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[900],
        //borderRadius: BorderRadius.circular(3)
      )
    );
  }
}