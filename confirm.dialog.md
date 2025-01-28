A dialog for confirmation from user. 
```
import 'package:flutter/material.dart';

Future<bool?> confirmDialog(
  BuildContext context, {
  String? title,
  bool? isDismissable,
  String? cancelButtonText,
  String? confirmButtonText,
  String? secondaryTitle,
  Color? cancelButtonColor,
  Color? confirmButtonColor,
}) {
  bool? res;
  return showDialog(
    barrierDismissible: isDismissable ?? true,
    context: context,
    builder: (BuildContext context) => ConfirmationDialog(
      cancelText: cancelButtonText,
      confirmText: confirmButtonText,
      title: title,
      secondaryTitle: secondaryTitle,
      confirmColor: confirmButtonColor,
      cancelColor: cancelButtonColor,
      // onCancel: (v) => Navigator.pop(context,false),
      onCancel: (v) {
        res = v;
        Navigator.pop(context);
      },
      onConfirm: (v) {
        res = v;
        Navigator.pop(context);
      },
    ),
  ).then((value) {
    return res;
  });
}

class ConfirmationDialog extends StatelessWidget {
  const ConfirmationDialog({
    super.key,
    required this.onConfirm,
    required this.onCancel,
    this.title,
    this.cancelText = 'Cancel',
    this.cancelColor,
    this.confirmText = 'Confirm',
    this.secondaryTitle,
    this.confirmColor = Colors.green,
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

    return Dialog(
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(6)),
      ),
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
                            title ?? defaultMsg,
                            style: textTheme.titleLarge,
                          ),
                        ),
                        IconButton(
                          onPressed: () => onCancel(false),
                          icon: Icon(Icons.close),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          if (secondaryTitle != null)
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
              child: Text(secondaryTitle ?? '', style: textTheme.titleSmall),
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
                  child: Text(cancelText ?? 'Cancel'),
                  onPressed: () => onCancel(false),
                ),
                SizedBox(width: 5),
                ElevatedButton(
                  style: buttonStyle.copyWith(
                    backgroundColor: WidgetStatePropertyAll(Colors.red),
                    foregroundColor: WidgetStatePropertyAll(Colors.white),
                  ),
                  onPressed: () => onConfirm(true),
                  child: Text(confirmText ?? 'Confirm'),
                ),
              ],
            ),
          ),
        ],
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
