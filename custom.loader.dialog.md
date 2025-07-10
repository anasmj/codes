### Call like this : 
```
final awaitedValue =  await runWithLoader<String>(context, () async {
      return  await myAsyncTaskThatMightReturnAString();
    });
```
### The function: 
```
Future<T> runWithLoader<T>(
  BuildContext context,
  Future<T> Function() task,
) async {
  _showLoaderDialog(context);

  try {
    return await task();
  } catch (e, st) {
    debugPrint('Task error: $e\n$st');
    rethrow;
  } finally {
    if (context.mounted) Navigator.of(context, rootNavigator: true).pop();
  }
}
```
### Dialog (Customize as you want)
```
Future _showLoaderDialog(BuildContext context) async {
  await showDialog(
    barrierDismissible: false,
    context: context,
    useRootNavigator: true,
    builder: (context) => Dialog(
        child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
      child: CircularProgressIndicator(),
    )),
  );
}
```
