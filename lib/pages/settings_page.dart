import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:lubette_todo_flutter/controls/main_control.dart';
import 'package:lubette_todo_flutter/controls/use_hooks.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});
  static const themes = [
    'blue',
    'gray',
    'green',
    'neutral',
    'orange',
    'red',
    'rose',
    'slate',
    'stone',
    'violet',
    'yellow',
    'zinc',
  ];
  static const themeModes = ['dark', 'light', 'system'];
  @override
  Widget build(BuildContext context) {
    final media = useMediaQuery(context);
    return Scaffold(
      body: Padding(
        padding: useEdgeNoOnly(
          width: media.size.width * 0.04,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 4.0,
          children: [
            ShadInputFormField(
              trailing: ShadButton(
                onPressed: () {
                  // TODO: Implement file picker functionality
                },
                width: 24,
                height: 24,
                padding: EdgeInsets.zero,
                decoration: const ShadDecoration(
                  secondaryBorder: ShadBorder.none,
                  secondaryFocusedBorder: ShadBorder.none,
                ),
                child: Icon(Icons.wheelchair_pickup),
              ),
              maxLines: null,
              minLines: 1,
              label: Text(
                'Todo文件保存路径',
                style: ShadTheme.of(context).textTheme.h4.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              placeholder: Text(
                '输入路径',
                style: ShadTheme.of(context).textTheme.p,
              ),
              style: ShadTheme.of(context).textTheme.p,
            ),
            ShadSelectFormField<String>(
              minWidth: 250,
              label: Text(
                '主题颜色',
                style: ShadTheme.of(context).textTheme.h4.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              initialValue: Get.find<MainControl>().theme,
              options: themes
                  .map(
                    (theme) => ShadOption(
                      value: theme,
                      child: Text(
                        theme,
                      ),
                    ),
                  )
                  .toList(),
              selectedOptionBuilder: (context, value) => value == 'none'
                  ? Text(
                      '选择你喜欢的主题',
                      style: ShadTheme.of(context).textTheme.p,
                    )
                  : Text(value),
              placeholder: Text(
                '选择你喜欢的主题',
                style: ShadTheme.of(context).textTheme.p,
              ),
              onChanged: (value) {
                Get.find<MainControl>().changeTheme(value!);
              },
            ),
            ShadSelectFormField<String>(
              minWidth: 250,
              label: Text(
                '主题模式',
                style: ShadTheme.of(context).textTheme.h4.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              initialValue: Get.find<MainControl>().themeMode.name,
              options: themeModes
                  .map(
                    (theme) => ShadOption(
                      value: theme,
                      child: Text(
                        theme,
                      ),
                    ),
                  )
                  .toList(),
              selectedOptionBuilder: (context, value) => value == 'none'
                  ? Text(
                      '选择你喜欢的主题',
                      style: ShadTheme.of(context).textTheme.p,
                    )
                  : Text(value),
              placeholder: Text(
                '选择你喜欢的主题',
                style: ShadTheme.of(context).textTheme.p,
              ),
              onChanged: (value) {
                Get.find<MainControl>().changeThemeMode(value!);
              },
            ),
          ],
        ),
      ),
    );
  }
}
