import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lubette_todo_flutter/components/clock_widget.dart';
import 'package:lubette_todo_flutter/controls/main_control.dart';
import 'package:lubette_todo_flutter/controls/use_hooks.dart';
import 'package:lubette_todo_flutter/data/todo_task.dart';
import 'package:lubette_todo_flutter/components/text_button.dart' as lubette;
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
      setState(() {
        enable = false;
      });
      timer?.cancel();
      final control = Get.find<MainControl>();
      control.completed(widget.task.id);
      Get.back();
    } else {
      setState(() {
        enable = true;
      });
      timer = Timer.periodic(
        Duration(seconds: 1),
        (t) {
          if (enable) {
            setState(
              () {
                time = time.add(
                  Duration(
                    seconds: 1,
                  ),
                );
              },
            );
          }
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final media = useMediaQuery(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '任务计时',
          style: ShadTheme.of(
            context,
          ).textTheme.h4,
        ),
        leading: IconButton(
          onPressed: () {
            // showDialog(context: context, builder: (context) => TodoDialog()
            //     // AlertDialog(
            //     //   title: Text('退出'),
            //     //   content: Text('退出你的计时就会归0了'),
            //     //   actions: [],
            //     // ),
            //     );
            Get.back();
          },
          icon: Icon(
            Icons.arrow_back,
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(
                bottom: 10,
              ),
              child: Text(
                widget.task.title,
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                bottom: media.size.height * 0.04,
              ),
              child: ClockWidget(
                time: time,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: media.size.width * 0.25,
                      right: media.size.width * 0.02,
                    ),
                    child: lubette.TextButton(
                      onPress: press,
                      text: Padding(
                        padding: useEdgeNoOnly(
                          width: media.size.width * 0.0006,
                          height: media.size.height * 0.01,
                        ),
                        child: Text(
                          enable ? '停止' : '开始',
                          style: TextStyle(
                            fontSize: 17,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(
                      right: media.size.width * 0.25,
                      left: media.size.width * 0.02,
                    ),
                    child: lubette.TextButton(
                      onPress: () {
                        setState(() {
                          enable = false;
                        });
                        Get.back();
                      },
                      text: Padding(
                        padding: useEdgeNoOnly(
                          height: media.size.height * 0.01,
                        ),
                        child: Text(
                          '取消',
                          style: TextStyle(
                            fontSize: 17,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
