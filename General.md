# General 
Remove null fields fields fromJson file 
```
  Map<String, dynamic> toJson() => {
        'name': 'Jhon Doe',
        'age': 12,
        'genter': null,
}..removeWhere((key, value) => value == null || value == '' || value == []);
```
