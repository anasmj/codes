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

class ConfirmationDialog extends StatefulWidget {
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
  final ValueSetter<bool> onConfirm, onCancel;
  final Color? confirmColor;
  final Color? cancelColor;
  final String? secondaryTitle;

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
                              onPressed: () => widget.onCancel(false),
                              icon: Icon(Icons.close),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              if (widget.secondaryTitle != null)
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
                  child: Text(widget.secondaryTitle ?? '',
                      style: textTheme.titleSmall),
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
                      child: Text(widget.cancelText ?? 'Cancel'),
                      onPressed: () => widget.onCancel(false),
                    ),
                    SizedBox(width: 5),
                    ElevatedButton(
                      style: buttonStyle.copyWith(
                        backgroundColor: WidgetStatePropertyAll(Colors.red),
                        foregroundColor: WidgetStatePropertyAll(Colors.white),
                      ),
                      onPressed: () => widget.onConfirm(true),
                      child: Text(widget.confirmText ?? 'Confirm'),
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
