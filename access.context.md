Accessing context from anywhere in the app
~~~
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
~~~
Assign key to material app
~~~
MaterialApp(
  title: appName,
  navigatorKey: navigatorKey,
)
~~~
Usage example 
~~~
navigatorKey.currentState!.pop()
~~~
