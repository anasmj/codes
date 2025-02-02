update element in list 
```
state = AsyncData([...?state.value]
          ..removeWhere((c) => c.id == userÏ?.id)
          ..add(user));
```
Add item in async provider 
```
state = AsyncData(state.value..add(item));
```
