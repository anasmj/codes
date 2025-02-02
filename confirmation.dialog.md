A dialog for confirmation from user. 
```
import 'package:flutter/material.dart';
import 'package:test_app/dialog/confirmation.dialog.dart';

Future<bool?> confirmDialog(
  BuildContext context, {
  String? title,
  String? subTitle,
  bool? isDismissable,
}) {
  bool? res;
  return showDialog(
    barrierDismissible: isDismissable ?? true,
    context: context,
    builder: (BuildContext context) => ConfirmationDialog(
      title: title,
      subTitle: subTitle,
      // onCancel: (v) {
      //   res = v;
      //   Navigator.pop(context);
      // },
      onConfirm: (v) {
        res = v;
        Navigator.pop(context);
      },
    ),
  ).then((value) => res);
}

```

<!--![7eb41136-fe00-42b9-ac58-2b67c19617f3](https://github.com/user-attachments/assets/8e8d717d-01d8-4036-9a85-cc6321658ec9)-->
<img src="https://github.com/user-attachments/assets/8e8d717d-01d8-4036-9a85-cc6321658ec9" height="100" width ="220">

Animated Confiramtion dialog
```
class ConfirmationDialog extends StatefulWidget {
  const ConfirmationDialog({
    super.key,
    this.onConfirm,
    this.onCancel,
    this.title,
    this.subTitle,
  });
  final String? title, subTitle;
  final ValueSetter<bool>? onConfirm, onCancel;

  @override
  State<ConfirmationDialog> createState() => _ConfirmationDialogState();
}

class _ConfirmationDialogState extends State<ConfirmationDialog>
    with SingleTickerProviderStateMixin {
  final String defaultMsg = 'Are you sure?';
  late final AnimationController _controller;
  late final Animation<Offset> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );

    _animation = Tween<Offset>(
      begin: const Offset(1, 1),
      end: const Offset(0, 0),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.fastOutSlowIn,
    ));
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return SlideTransition(
      position: _animation,
      // scale: _animation,
      child: Dialog(
        backgroundColor: Colors.white,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(6)),
        ),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 400),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: Colors.grey.shade100,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                widget.title ?? defaultMsg,
                                style: textTheme.titleLarge,
                              ),
                            ),
                            IconButton(
                              onPressed: () => Navigator.pop(context),
                              icon: Icon(Icons.close),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              if (widget.subTitle != null)
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
                  child:
                      Text(widget.subTitle ?? '', style: textTheme.titleSmall),
                ),
              Divider(),
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 4, 8, 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    OutlinedButton(
                      style: buttonStyle.copyWith(
                        side: WidgetStatePropertyAll(
                          BorderSide(color: Colors.grey.shade400),
                        ),
                        foregroundColor: WidgetStatePropertyAll(Colors.black87),
                      ),
                      child: Text('Cancel'),
                      onPressed: () => widget.onCancel?.call(false),
                    ),
                    SizedBox(width: 5),
                    ElevatedButton(
                      style: buttonStyle.copyWith(
                        backgroundColor: WidgetStatePropertyAll(Colors.red),
                        foregroundColor: WidgetStatePropertyAll(Colors.white),
                      ),
                      onPressed: () => widget.onConfirm?.call(true),
                      child: Text('Confirm'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  ButtonStyle get buttonStyle => ButtonStyle(
        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.0)),
        ),
      );
}

```
<img src="https://github.com/user-attachments/assets/317f2f0c-b786-4340-bda4-be50d15336d5" height="150" width ="220">

 
<!--![608ebf56-7a43-4824-b32a-8275a9afe8e1](https://github.com/user-attachments/assets/317f2f0c-b786-4340-bda4-be50d15336d5)-->


Confirmation Dialog with red warning 
```
class ConfirmDialogWithRedWarning extends StatelessWidget {
  const ConfirmDialogWithRedWarning({
    super.key,
    this.title,
    this.subTitle,
    this.warningText,
    this.onConfirm,
    this.onCancel,
  });
  final String? title, subTitle, warningText;
  final ValueSetter<bool>? onConfirm, onCancel;
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title ?? '',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close),
                )
              ],
            ),
            Text(
              subTitle ?? '',
              style: Theme.of(context).textTheme.titleSmall,
            ),
            SizedBox(height: 10),
            Container(
              color: Colors.red.shade100,
              child: IntrinsicHeight(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(color: Colors.red, width: 5),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child:
                          Icon(Icons.warning_amber_rounded, color: Colors.red),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Warning',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context).colorScheme.error,
                                  ),
                            ),
                            Text(
                              warningText ?? '',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                    color: Theme.of(context).colorScheme.error,
                                  ),
                            ),
                            SizedBox(height: 10),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Spacer(),
                OutlinedButton(
                  style: buttonStyle.copyWith(
                    side: WidgetStatePropertyAll(
                      BorderSide(color: Colors.grey.shade400),
                    ),
                    foregroundColor: WidgetStatePropertyAll(Colors.black87),
                  ),
                  onPressed: () => Navigator.pop(context, false),
                  child: Text('Decline'),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  style: buttonStyle.copyWith(
                    backgroundColor: WidgetStatePropertyAll(Colors.red),
                    foregroundColor: WidgetStatePropertyAll(Colors.white),
                  ),
                  onPressed: () => Navigator.pop(context, true),
                  child: Text('Proceed'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  ButtonStyle get buttonStyle => ButtonStyle(
        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.0)),
        ),
      );
}
```
