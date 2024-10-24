User 'ColorScheem.fromseet() method to build a new ColorScheme
```
ColorScheme.fromSeed(seedColor: Colors.brown);
```
Get relevent color from an image 
```
  ColorScheme.fromImageProvider(
      provider: (e.image!.contains('http')
          ? NetworkImage(e.image!)
          : AssetImage(e.image!)) as ImageProvider,
    );
```
Practical code: 
```
 Future<List<ColorScheme>> getColorSchemes() async {
    final onboardings = ref.read(onboardingProvider);
    return Future.wait(onboardings
        .map((e) => ColorScheme.fromImageProvider(
              provider: (e.image!.contains('http')
                  ? NetworkImage(e.image!)
                  : AssetImage(e.image!)) as ImageProvider,
            ))
        .toList());
  }
```
