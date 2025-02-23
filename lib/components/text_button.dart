import 'package:flutter/material.dart';
import 'package:lubette_todo_flutter/controls/use_hooks.dart';

class TextButton extends StatelessWidget {
  const TextButton({
    super.key,
    required this.onPress,
    required this.text,
  });
  final void Function() onPress;
  final Widget text;

  @override
  Widget build(BuildContext context) {
    final theme = useTheme(context);
    return InkWell(
      onTap: onPress,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: theme.colorScheme.onPrimary,
            width: 2,
          ),
        ),
        child: Center(child: text),
      ),
    );
  }
}
