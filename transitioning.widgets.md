```
import 'package:flutter/material.dart';

const defaultDuration = Duration(milliseconds: 1500);
```
### **Scale Transition**
```
class ScaleTransitionWidget extends StatefulWidget {
  const ScaleTransitionWidget({
    super.key,
    required this.child,
    this.duration = defaultDuration,
  });
  final Widget child;
  final Duration? duration;
  @override
  State<ScaleTransitionWidget> createState() => _ScaleTransitionWidgetState();
}

class _ScaleTransitionWidgetState extends State<ScaleTransitionWidget>
    with TickerProviderStateMixin {
  AnimationController? _controller;
  Animation<double>? _animation;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration!,
    );
    _animation = CurvedAnimation(parent: _controller!, curve: Curves.easeOut);
    _controller!.forward();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _animation!,
      alignment: Alignment.center,
      child: widget.child,
    );
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }
}
```
### **Fade Transition**
```

class FadeTransitionWidget extends StatefulWidget {
  const FadeTransitionWidget({
    super.key,
    required this.child,
    this.duration = defaultDuration,
  });
  final Widget child;
  final Duration duration;

  @override
  State<FadeTransitionWidget> createState() => _FadeTransitionWidgetState();
}

class _FadeTransitionWidgetState extends State<FadeTransitionWidget>
    with SingleTickerProviderStateMixin {
  AnimationController? _controller;
  Animation<double>? _animation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );
    _animation = CurvedAnimation(parent: _controller!, curve: Curves.easeInOut);
    _controller!.forward();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animation!,
      child: widget.child,
    );
  }
}
```
