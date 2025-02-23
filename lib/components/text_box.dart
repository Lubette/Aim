import 'package:flutter/material.dart';
import 'package:lubette_todo_flutter/controls/use_hooks.dart';

class TextBox extends StatelessWidget {
  const TextBox(
    this.title, {
    super.key,
    this.onTap,
    this.readOnly = false,
    this.maxLines,
    this.minLines,
    this.maxLength,
    this.controller,
  });
  final String title;
  final void Function()? onTap;
  final bool readOnly;
  final int? maxLines;
  final int? minLines;
  final int? maxLength;
  final TextEditingController? controller;
  @override
  Widget build(BuildContext context) {
    final theme = useTheme(context);
    final media = useMediaQuery(context);
    final border = OutlineInputBorder(
      borderSide: BorderSide(
        color: theme.colorScheme.onPrimary,
        width: 2.0,
      ),
      borderRadius: BorderRadius.circular(0),
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        Container(
          constraints: BoxConstraints(
            maxHeight: media.size.height * 0.3,
          ),
          child: TextField(
            controller: controller,
            maxLines: maxLines,
            minLines: minLines,
            readOnly: readOnly,
            decoration: InputDecoration(
              border: border,
              focusedBorder: border,
              enabledBorder: border,
            ),
            keyboardType: TextInputType.multiline,
            cursorColor: theme.colorScheme.onSecondary,
            onTap: onTap,
          ),
        ),
      ],
    );
  }
}
