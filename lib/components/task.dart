import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

void showAddTodoGroupNameSheet({
  required BuildContext context,
  required void Function(String) onGroupNameSubmitted,
}) {
  final controller = TextEditingController();

  showShadSheet(
    context: context,
    side: ShadSheetSide.right,
    builder: (context) => ShadSheet(
      constraints: BoxConstraints(maxWidth: 512),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ShadInputFormField(
              controller: controller,
              placeholder: Text(
                '输入待办事项组名',
                style: ShadTheme.of(context).textTheme.p,
              ),
              label: Text(
                '待办事项组名',
                style: ShadTheme.of(context).textTheme.h4,
              ),
              style: ShadTheme.of(context).textTheme.p,
            ),
            const SizedBox(height: 24),
            ShadButton(
              child: const Text('确定'),
              onPressed: () {
                final String groupName = controller.text.trim();
                if (groupName.isNotEmpty) {
                  onGroupNameSubmitted(groupName);
                  Get.back();
                }
              },
            ),
          ],
        ),
      ),
    ),
  );
}
