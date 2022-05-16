import 'package:flutter/material.dart';

class Bird extends StatefulWidget {
  double? width;
  double? height;

  Bird({Key? key, this.width, this.height}) : super(key: key);

  @override
  State<Bird> createState() => _BirdState();
}

class _BirdState extends State<Bird> {
  @override
  Widget build(BuildContext context) {
    return 
        Container(
          //color: Colors.red,
          width: widget.width,
          height: widget.height,
          //padding: EdgeInsets.all(120),
        child: Image.asset("lib/img/bird.png"),
      
    );
  }
}
