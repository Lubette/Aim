import 'package:flutter/material.dart';
import 'package:lubette_todo_flutter/controls/use_hooks.dart';

class ClockWidget extends StatelessWidget {
  const ClockWidget({
    required this.time,
    super.key,
  });
  final DateTime time;
  @override
  Widget build(BuildContext context) {
    final media = useMediaQuery(context);
    final theme = useTheme(context);
    return Container(
      width: media.size.width * media.size.height * 0.0004,
      height: media.size.width * media.size.height * 0.0004,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: theme.colorScheme.secondary,
        border: Border.all(
          color: theme.colorScheme.onSecondary,
          width: 3,
        ),
      ),
      child: Text(
        formatTime(),
        style: TextStyle(
          color: theme.colorScheme.onSecondary,
          fontSize: media.size.width * media.size.height * 0.00006,
        ),
      ),
    );
  }

  String formatTime() {
    format(int a) {
      if (a >= 10) {
        return '$a';
      } else {
        return '0$a';
      }
    }

    return '${format(time.hour)}:${format(time.minute)}:${format(time.second)}';
  }
}
