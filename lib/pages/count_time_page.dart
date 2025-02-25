import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lubette_todo_flutter/controls/main_control.dart';
import 'package:lubette_todo_flutter/controls/use_hooks.dart';
import 'package:lubette_todo_flutter/data/todo_task.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class CountTimePage extends StatefulWidget {
  const CountTimePage(this.task, {super.key});
  final TodoTask task;

  @override
  State<CountTimePage> createState() => _CountTimePageState();
}

class _CountTimePageState extends State<CountTimePage> {
  DateTime time = DateTime(0, 0, 0, 0, 0, 0);
  bool enable = false;
  Timer? timer;

  void press() {
    if (enable) {
      setState(() => enable = false);
      timer?.cancel();
      Get.find<MainControl>().completedTodo(widget.task.id);
      Get.back();
    } else {
      setState(() => enable = true);
      timer = Timer.periodic(Duration(seconds: 1), (t) {
        if (mounted && enable) {
          setState(() => time = time.add(Duration(seconds: 1)));
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);
    final media = useMediaQuery(context);
    final colors = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text('任务计时', style: theme.textTheme.h4),
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: colors.foreground),
          onPressed: Get.back,
        ),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                widget.task.title,
                style: theme.textTheme.h3.copyWith(
                  color: colors.foreground,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 24),
              ClockWidget(time: time),
              SizedBox(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ShadButton(
                    size: ShadButtonSize.lg,
                    onPressed: press,
                    child: Text(
                      enable ? '停止' : '开始',
                      style: TextStyle(
                        color: colors.primaryForeground,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  SizedBox(width: 16),
                  ShadButton.outline(
                    size: ShadButtonSize.lg,
                    onPressed: Get.back,
                    child: Text('取消', style: TextStyle(fontSize: 16)),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ClockWidget extends StatelessWidget {
  final DateTime time;
  const ClockWidget({required this.time, super.key});

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);
    final media = useMediaQuery(context);
    final colors = theme.colorScheme;
    final size = media.size.shortestSide * 0.5;

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: colors.background,
        shape: BoxShape.circle,
        border: Border.all(
          color: colors.primary,
          width: 4,
        ),
        boxShadow: [
          BoxShadow(
            color: colors.mutedForeground.withOpacity(0.1),
            blurRadius: 16,
            spreadRadius: 2,
          )
        ],
      ),
      child: Center(
        child: Text(
          formatTime(),
          style: TextStyle(
            fontSize: 32,
            color: colors.primary,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  String formatTime() {
    String format(int n) => n.toString().padLeft(2, '0');
    return '${format(time.hour)}:${format(time.minute)}:${format(time.second)}';
  }
}
