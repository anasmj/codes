Dialog that returns true / false on accept or deny 
```
import 'package:flutter/material.dart';

Future<bool?> confirmDialog(
  BuildContext context, {
  String? title,
  bool? isDismissable,
  String? cancelButtonText = 'Cancel',
  String? confirmButtonText = 'Ok',
  String? secondaryTitle,
  Color? cancelButtonColor,
  Color? confirmButtonColor,
}) {
  bool? res;
  return showDialog(
    barrierDismissible: isDismissable ?? true,
    context: context,
    builder: (BuildContext context) => DeleteDialogBody(
      cancelText: cancelButtonText,
      confirmText: confirmButtonText,
      title: title,
      secondaryTitle: secondaryTitle,
      confirmColor: confirmButtonColor,
      cancelColor: cancelButtonColor,
      onCancel: (v) {
        res = v;
        Navigator.pop(context);
      },
      onConfirm: (v) {
        res = v;
      },
    ),
  ).then((value) {
    return res;
  });
}

class DeleteDialogBody extends StatelessWidget {
  const DeleteDialogBody({
    super.key,
    required this.onConfirm,
    required this.onCancel,
    this.title,
    this.cancelText,
    this.cancelColor,
    this.confirmText,
    this.secondaryTitle,
    this.confirmColor,
  });
  final String? title, cancelText, confirmText;
  final String defaultMsg = 'Are you sure?';
  final ValueSetter<bool> onConfirm, onCancel;
  final Color? confirmColor;
  final Color? cancelColor;
  final String? secondaryTitle;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return AlertDialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.zero,
      ),
      title: Text(
        title ?? defaultMsg,
        style: textTheme.titleLarge,
      ),
      content: secondaryTitle != null
          ? Text(
              secondaryTitle ?? '',
              style: textTheme.titleSmall,
            )
          : null,
      actions: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: cancelColor),
          onPressed: () => onCancel(false),
          child: Text(cancelText!, style: textTheme.bodyMedium),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: confirmColor),
          onPressed: () => onCancel(true),
          child: Text(confirmText!, style: textTheme.bodyMedium),
        ),
      ],
    );
  }
}
```
