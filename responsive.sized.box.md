Add this extension on int 
Call like this : 
```
10.toHeight(context);
```
```
extension HourFormat on int {
  double getRisponsiveHeight(BuildContext context) =>
      (toDouble()) /
      100 *
      MediaQuery.of(context).size.height *
      MediaQuery.of(context).size.width;
  Widget toHeight(BuildContext context) =>
      SizedBox(height: getRisponsiveHeight(context));
  Widget toWidth(BuildContext context) =>
      SizedBox(width: getRisponsiveHeight(context));
}
```
