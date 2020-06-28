import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class NeumorphicCardBackground extends StatelessWidget {
  const NeumorphicCardBackground({
    Key key,
    @required AnimationController animationController,
    @required this.heightAnimation,
  })  : _animationController = animationController,
        super(key: key);

  final AnimationController _animationController;
  final Animation heightAnimation;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _animationController,
        builder: (context, snapshot) {
          return Neumorphic(
            style: NeumorphicStyle(
                boxShape: NeumorphicBoxShape.roundRect(BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30))),
                depth: -30,
                intensity: 1.0),
            child: Container(
              width: double.infinity,
              height: heightAnimation.value,
            ),
          );
        });
  }
}