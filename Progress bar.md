~~~
class ProgressBar extends StatelessWidget {
  final double progress; // Progress value between 0.0 and 1.0

  ProgressBar({required this.progress});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 20,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(10),
      ),
      child: FractionallySizedBox(
        widthFactor: progress, // Width based on progress
        alignment: Alignment.centerLeft,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
~~~
