Import image object from dart ui library 
```
import 'dart:ui' as ui;
```

Declare a value notifier in the widget 
```
 final ValueNotifier<ui.Image?> imageNotifier = ValueNotifier<ui.Image?>(null);
```
Call this method from initState(); 
```
Future getImage() async {
    if (widget.stockBgPath == null) return;

    try {
      // Check if the path is an asset or file system path
      bool isAssetImage = widget.stockBgPath!.contains('assets');

      if (isAssetImage) {
        // Load Asset Image
        AssetImage assetImage = AssetImage('path/of/your/image.jpg');
        final imageStream = assetImage.resolve(ImageConfiguration.empty);
        final imageStreamListener =
            ImageStreamListener((imageInfo, synchronusCall) {
          imageNotifier.value = imageInfo.image;
        });

        imageStream.addListener(imageStreamListener);
      } else {
        // Load File Image from Gallery or file system
        File file = File('path/of/your/image.jpg');
        if (!file.existsSync()) return;

        FileImage fileImage = FileImage(file);
        final imageStream = fileImage.resolve(ImageConfiguration.empty);
        final imageStreamListener =
            ImageStreamListener((imageInfo, synchronusCall) {
          imageNotifier.value = imageInfo.image;
        });

        imageStream.addListener(imageStreamListener);
      }
    } catch (e) {
      // Handle errors (like file not found or invalid asset paths)
      log('Error loading image: $e');
    }
  }
```
Pass value of the notifier to CustomPainter object 
```
CustomPaint(
  painter: MyPainterÏ(
  image: imageNotifier.value,
);Ï
```
