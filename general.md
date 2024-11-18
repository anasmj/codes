## Set value to loading before executing new async tasks
```
 Future<bool?> getData() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async => await callAPI());
    return null;
  }

```
