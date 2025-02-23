import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lubette_todo_flutter/controls/use_hooks.dart';
import 'package:lubette_todo_flutter/components/text_button.dart' as lubette;

class TodoDialog extends StatelessWidget {
  const TodoDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final media = useMediaQuery(context);
    final theme = useTheme(context);
    return Dialog(
      backgroundColor: Colors.transparent,
      shadowColor: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          color: theme.colorScheme.secondary,
          border: Border.all(
            color: theme.colorScheme.onSecondary,
            width: 2,
          ),
        ),
        child: Padding(
          padding: useEdgeNoOnly(
            width: 15,
            height: 15,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '你正在删除该Todo',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: useEdgeNoOnly(
                      width: media.size.width * 0.01,
                      height: media.size.height * 0.01,
                    ),
                    child: lubette.TextButton(
                      onPress: () {
                        Get.back();
                      },
                      text: Padding(
                        padding: useEdgeNoOnly(
                          width: media.size.width * 0.017,
                          height: media.size.height * 0.01,
                        ),
                        child: Text(
                          '确定',
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: useEdgeNoOnly(
                      width: media.size.width * 0.01,
                      height: media.size.height * 0.01,
                    ),
                    child: lubette.TextButton(
                      onPress: () {
                        Get.back();
                      },
                      text: Padding(
                        padding: useEdgeNoOnly(
                          width: media.size.width * 0.017,
                          height: media.size.height * 0.01,
                        ),
                        child: Text(
                          '取消',
                        ),
                      ),
                    ),
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
