import 'package:flutter/material.dart';
import 'package:lubette_todo_flutter/controls/use_hooks.dart';

class NavigationItem extends StatelessWidget {
  const NavigationItem({
    super.key,
    required this.title,
    required this.isSelected,
    required this.content,
  });
  final String title;
  final bool isSelected;
  final Widget content;
  @override
  Widget build(BuildContext context) {
    final theme = useTheme(context);
    final (decoration, fontWidget) = !isSelected
        ? (
            BoxDecoration(
              color: theme.colorScheme.primary,
            ),
            null
          )
        : (
            BoxDecoration(
              color: theme.colorScheme.primary,
              border: Border(
                bottom: BorderSide(
                  color: Theme.of(context).colorScheme.onPrimary,
                  width: 3.5,
                ),
              ),
            ),
            FontWeight.bold,
          );
    final media = useMediaQuery(context);
    return Container(
      decoration: decoration,
      child: Padding(
        padding: EdgeInsets.only(
          top: media.size.height * 0.015,
          bottom: media.size.height * 0.015,
          left: media.size.width * 0.035,
          right: media.size.width * 0.035,
        ),
        child: Text(
          title,
          style: TextStyle(
            fontSize: 20,
            fontWeight: fontWidget,
          ),
        ),
      ),
    );
  }
}
