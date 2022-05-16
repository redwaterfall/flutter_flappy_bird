import 'dart:async';
import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter_flappy_bird/gamePage/Bird.dart';
import 'package:flutter_flappy_bird/gamePage/Pipe.dart';

class GamePage extends StatefulWidget {
  double fly = -0.2;
  List<double> pipXpos = [1.6410484082740595e-15, -2.5];

  GamePage({Key? key, fly, pipXpos}) : super(key: key);

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  double _gravity = 0.01;
  double birdXpos = 0.2;
  //double pipXpos = -1;
  bool _gameOver = false;
  bool _startGame = false;

  flyUp() {
    setState(() {
      if (widget.fly > -0.9) widget.fly = widget.fly - 0.39;

      //print("Fly");
    });
  }

  void gameOver() {
    if (widget.fly == 1.0) {
      print("HiTT Ground!!!!!!!!!");
    }
    for (int i = 0; i < widget.pipXpos.length; i++) {
      /*if (widget.pipXpos[i].round() == birdXpos && (widget.fly < -0.15) ||
          (widget.pipXpos[i].round() == birdXpos) && (widget.fly > 0.4)) {
        print("Hitt pipe!!!!!!");
        print("widget.fly: ${widget.fly}");
      }*/
      //if (widget.pipXpos[i] == birdXpos && (widget.fly < -0.15)) {
      print("widget.pipXpos[i]: ${widget.pipXpos[i]}");
      if ((widget.pipXpos[i] > 0.0 && widget.pipXpos[i] < 0.1) &&
          (widget.fly.round() < -0.15)) {
        print("Hitt pipe top ${widget.fly}!!!!!!");
        print("widget.pipXpos[i]: ${widget.pipXpos[i]}");
        _gameOver = true;
        _startGame = false;
      }
      if ((widget.pipXpos[i] == birdXpos) && (widget.fly > 0.45)) {
        print("Hitt pipe bottom ${widget.fly}!!!!!!");
        print("widget.fly: ${widget.fly}");
      }
    }
    //print("widget.fly: ${widget.fly}");
    //print(
    // "birdXpos: ${birdXpos}  widget.pipXpos[0]: ${widget.pipXpos[0].round()} widget.pipXpos[1]: ${widget.pipXpos[1]} ");
  }

  void birdFale(timer) {
    if (_startGame) {
      timer.isActive;
      widget.fly += _gravity;
      if (widget.fly > 1.0) {
        timer.cancel();
        _gameOver = true;
      }
    }
  }

  List<AnimatedContainer> creatPipes() {
    List<AnimatedContainer> pipes = [
      //top
      AnimatedContainer(
        duration: const Duration(microseconds: 10),
        alignment: Alignment(-widget.pipXpos[0], 1),
        child: Pipe(
          height: 200,
        ),
      ),
      //bottom
      AnimatedContainer(
        duration: const Duration(microseconds: 10),
        alignment: Alignment(-widget.pipXpos[0], -1),
        child: Pipe(
          height: 300,
        ),
      ),

      /*AnimatedContainer(
        duration: const Duration(microseconds: 10),
        alignment: Alignment(-widget.pipXpos[1], 1),
        child: Pipe(
          height: 300,
        ),
      ),
      //bottom
      AnimatedContainer(
        duration: const Duration(microseconds: 10),
        alignment: Alignment(-widget.pipXpos[1], -1),
        child: Pipe(
          height: 200,
        ),
      ),*/
    ];

    return pipes;
  }

  @override
  void initState() {
    // TODO: implement initState
    void pipeMove(timer) {
      if (_startGame) {
        for (int i = 0; i < widget.pipXpos.length; i++) {
          widget.pipXpos[i] += _gravity;
          if (widget.pipXpos[i] > 1.0) {
            widget.pipXpos[i] = -2.0;
          }
        }
      }
    }

    if (!_startGame) {
      Timer.periodic(Duration(milliseconds: 10), (timer) {
        setState(() {
          //faling
          birdFale(timer);
          pipeMove(timer);
          gameOver();
          if (_gameOver) {
            timer.cancel();
          }
        });
      });
    }
    /*Timer.periodic(Duration(milliseconds: 10), (timer) {
      setState(() {
        //faling
        //birdFale(timer);
        pipeMove(timer);
        if (gameOver) {
          timer.cancel();
        }
      });
    });*/
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          flyUp();
        },
        child: Column(
          children: [
            Expanded(
              flex: 9,
              child: Stack(
                children: [
                  AnimatedContainer(
                    color: Colors.blue,
                    duration: Duration(microseconds: 5),
                    alignment: Alignment(birdXpos, widget.fly),
                    child: Bird(
                      width: 50,
                      height: 50,
                    ),
                  ),
                  Stack(
                    children: [
                      Container(
                        alignment: Alignment(0.0, 0.0),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              _startGame = true;
                            });
                          },
                          child: !_startGame
                              ? const Text(
                                  "Tap to start",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 40,
                                  ),
                                )
                              : Text(""),
                        ),
                      ),
                      Container(
                        child: _gameOver
                            ? Center(
                                child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _gameOver = false;
                                    _startGame = true;
                                  });
                                },
                                child: Text(
                                  "G A M E  O V E R",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 40),
                                ),
                              ))
                            : Text(""),
                      )
                    ],
                  ),
                  for (var p in creatPipes())
                    Column(
                      children: [
                        Expanded(
                          child: p,
                        )
                      ],
                    ),

                  /**
                     //topPipe
                  AnimatedContainer(
                    duration: const Duration(microseconds: 100),
                    alignment: Alignment(-widget.pipXpos[0], -1),
                    child: Pipe(
                      height: 300,
                    ),
                  ),
                  //bottomPipe
                  AnimatedContainer(
                    duration: const Duration(microseconds: 100),
                    alignment: Alignment(-widget.pipXpos[0], 1),
                    child: Pipe(
                      height: 300,
                    ),
                  ),
                  AnimatedContainer(
                    duration: const Duration(microseconds: 100),
                    alignment: Alignment(-widget.pipXpos[0] + 2, 1),
                    child: Pipe(
                      height: 100,
                    ),
                  ),
                
                     */
                ],
              ),
            ),
            Expanded(
              child: Container(
                color: Colors.brown,
              ),
            ),
            Text("data")
          ],
        ),
      ),
    );
  }
}
