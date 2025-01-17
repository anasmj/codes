Copy the code into a dart class and use right away. 
speed is how fast the text will scroll. 
```
import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';

///Scrolling text with fade animation
class ScrollingText extends StatelessWidget {
  final String text;
  final double height;
  final TextStyle? textStyle;
  final double? speed;
  const ScrollingText({
    super.key,
    required this.height,
    this.textStyle,
    this.speed = 100,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: ShaderMask(
        shaderCallback: (Rect bounds) {
          return const LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: <Color>[
              Colors.transparent,
              Colors.black,
              Colors.black,
              Colors.transparent
            ],
            stops: [0.0, 0.1, 0.9, 1.0],
          ).createShader(bounds);
        },
        blendMode: BlendMode.dstIn,
        child: Marquee(
          text: text,
          style:
              textStyle, // const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          scrollAxis: Axis.horizontal,
          blankSpace: 50.0,
          velocity: speed!,
          pauseAfterRound: const Duration(seconds: 1),
        ),
      ),
    );
  }
}
```
