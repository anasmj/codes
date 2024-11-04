Scrolling text with fade animation.
Used Marquee package with fade effect to start and end of the text  
```Ï
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
