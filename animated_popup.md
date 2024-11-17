Declare variables
```
  AnimationController? _controller;
  Animation<double>? _animation;
```
Initialize in initState()
```
void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _animation = CurvedAnimation(parent: _controller!, curve: Curves.easeInOut);
  }
```
In build method 
```
 Widget build(BuildContext context) {
    _controller!.forward();

    return ScaleTransition(
      scale: _animation!,
      child: Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: SizedBox(
          height: _height,      
          width:  _width
          child: _buildMainContent(context)
        ),
      ),
    );
  }
```
