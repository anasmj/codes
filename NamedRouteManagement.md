Assign names to all your routes 
```
const String onbordingScreenRoute = "onbording";
const String notificationPermissionScreenRoute = "notification_permission";
const String preferredLanuageScreenRoute = "preferred_language";
...
...
```
Write a function that returns Route depending on route names 
```
Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case onbordingScreenRoute:
      return MaterialPageRoute(
        builder: (context) => const OnBordingScreen(),
      );
    case logInScreenRoute:
      return MaterialPageRoute(
        builder: (context) => const LoginScreen(),
      );
    case signUpScreenRoute:
      return MaterialPageRoute(
        builder: (context) => const SignUpScreen(),
      );
}
```
Use the function in MaterialApp() 
```
MaterialApp(
  initialRoute: onbordingScreenRoute,
  onGenerateRoute: router.generateRoute,
);
```
In UI 
```
Navigator.pushNamed(
  context,
  passwordRecoveryScreenRoute
);
```
