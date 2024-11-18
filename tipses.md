You can use 
```
ClampingScrollPhysics
```

Make custom chip 

class CustomChip extends Chip { 
  final BuildContext context;
  CustomChip({super.key, 
    required this.context,
    required String label,
    required Color backgroundColor,
    ...otherParams,
    }): super(
           label: Text(label),
           backgroundColor: backgroundColor,
           ...otherParams,
      );

  RenderBox get renderBox => context.findRenderObject() as RenderBox;
 
  Size get size => renderBox.size;
}
```
Use DefaultTextStyle in your widget tree
```
Contaienr(
  child: DefaultTextStyle(
    child : YourWidget()
  ),
 )
```
Use Boxshape.circle() to make a shape circular 
```
decoration: BoxDecoration(
  shape: BoxShape.circle(); 
)
```
