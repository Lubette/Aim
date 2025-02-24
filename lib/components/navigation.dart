import 'package:flutter/material.dart';
import 'package:lubette_todo_flutter/components/navigation_item.dart';
import 'package:lubette_todo_flutter/controls/use_hooks.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class Navigation extends StatelessWidget {
  const Navigation({
    super.key,
    required this.items,
    required this.onItemTap,
    required this.selected,
  });
  final List<NavigationItem> items;
  final void Function(int) onItemTap;
  final int selected;

  @override
  Widget build(BuildContext context) {
    var count = 0;
    final media = useMediaQuery(context);
    return Scaffold(
      appBar: AppBar(
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            ...items.map(
              (element) {
                final value = count++;
                return InkWell(
                  onTap: () => onItemTap(value),
                  child: element,
                );
              },
            ),
          ],
        ),
      ),
      body: items[selected].content,
    );
    // return Padding(
    //   padding: EdgeInsets.only(
    //     left: media.size.width * 0.01,
    //     right: media.size.width * 0.01,
    //     top: media.size.height * 0.015,
    //   ),
    //   child: Column(
    //     crossAxisAlignment: CrossAxisAlignment.start,
    //     mainAxisAlignment: MainAxisAlignment.start,
    //     children: [
    //       Row(
    //         crossAxisAlignment: CrossAxisAlignment.start,
    //         mainAxisAlignment: MainAxisAlignment.start,
    //         mainAxisSize: MainAxisSize.min,
    //         children: [
    //           ...items.map(
    //             (element) {
    //               final value = count++;
    //               return InkWell(
    //                 onTap: () => onItemTap(value),
    //                 hoverColor: Theme.of(context).primaryColor,
    //                 child: element,
    //               );
    //             },
    //           ),
    //         ],
    //       ),
    //       Expanded(
    //         child: items[selected].content,
    //       )
    //     ],
    //   ),
    // );
  }
}
