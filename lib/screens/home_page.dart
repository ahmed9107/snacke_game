import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import '../widgets/bg_pixel.dart';
import '../widgets/food_pixel.dart';
import '../widgets/snacke_pixel.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int numberOfPixels = 800;
  int areaSize = 20;

  List<int> snackePosition = [1, 2, 3];
  int food = 77;
  int score = 0;
  var currentDirection = snackeDirection.RIGHT;

  void start() {
    Timer.periodic(const Duration(milliseconds: 300), (timer){
      setState((){
        moveSnacke();
        if(gameOver()){
          timer.cancel();
          showDialog(
            context: context,
            builder: (context){
              return AlertDialog(
                title: const Text('Game Over!'),
                content: Text('Score: ' + score.toString()),
              );
            }
          );
        }
      });
    });
  }

  void moveSnacke() {
    switch(currentDirection){
      case snackeDirection.RIGHT:
        {
          if(snackePosition.last % areaSize == 19){
            snackePosition.add(snackePosition.last + 1 - areaSize);
          } else {
            snackePosition.add(snackePosition.last + 1);
          }
        }
        break;
      case snackeDirection.LEFT:
        {
          if(snackePosition.last % areaSize == 0){
            snackePosition.add(snackePosition.last - 1 + areaSize);
          } else {
            snackePosition.add(snackePosition.last - 1);
          }
        }
        break;
      case snackeDirection.UP:
        {
          if(snackePosition.last < areaSize){
            snackePosition.add(snackePosition.last - areaSize + numberOfPixels);
          } else {
            snackePosition.add(snackePosition.last - areaSize);
          }
        }
        break;
      case snackeDirection.DOWN:
        {
          if(snackePosition.last + areaSize > numberOfPixels){
            snackePosition.add(snackePosition.last + areaSize - numberOfPixels);
          } else {
            snackePosition.add(snackePosition.last + areaSize);
          }
        }
        break;
    }
    if(snackePosition.last == food) {
      eatFood();
    } else {
      snackePosition.removeAt(0);
    }
  }

  void eatFood(){
    score + 10;
    while(snackePosition.contains(food)){
      food = Random().nextInt(numberOfPixels);
    }
  }

  bool gameOver(){
    List<int> snackeBody = snackePosition.sublist(0, snackePosition.length - 1);
    if(snackeBody.contains(snackePosition.last)){
      return true;
    }
    return false;
  }

  @override
  initState() {
    super.initState();
    start();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.black,
      body: SizedBox(
        width: width > 428 ? 428 : width,
        child: Column(
          children: [
            Expanded(
              child: Container(
                alignment: Alignment.center,
                child: Text('Score: $score', style: const TextStyle(color : Colors.red)),
              ),
            ),
            Expanded(
              flex: 3,
              child: GestureDetector(
                onVerticalDragUpdate: (details) {
                  if(details.delta.dy > 0 && currentDirection == snackeDirection.UP) {
                    currentDirection = snackeDirection.DOWN;
                  } else if(details.delta.dy < 0  && currentDirection == snackeDirection.DOWN) {
                    currentDirection = snackeDirection.UP;
                  }
                },
                onHorizontalDragUpdate: (details) {
                  if(details.delta.dx > 0 && currentDirection == snackeDirection.LEFT) {
                    currentDirection = snackeDirection.RIGHT;
                  } else if(details.delta.dx < 0 && currentDirection == snackeDirection.RIGHT) {
                    currentDirection = snackeDirection.LEFT;
                  }
                },
                child: Container(
                  color: Colors.grey[900],
                  child: GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: areaSize,
                    ),
                    itemCount: numberOfPixels,
                    itemBuilder: (BuildContext context, int index) {
                      if(snackePosition.contains(index)) {
                        return const SnackePixel();
                      } else if(food == index) {
                        return const FoodPixel();
                      } else {
                        return const BackgroundPixel();
                      }
                    },
                  ),
                )
              ),
            ),
            Expanded(
              child: Container(),
            ),
          ]
        )
      )
    );
  }
}

enum snackeDirection {UP, DOWN, LEFT, RIGHT}
