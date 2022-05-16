import 'package:flutter/material.dart';

class Pipe extends StatelessWidget {
  double? height = 0;
  Pipe({Key? key, this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.green,
      ),
    );
  }
}
