// import 'package:aim/components/add_todo_page.dart';
// import 'package:aim/components/show_add_todo_group_name_sheet.dart';
// import 'package:aim/controls/main_control.dart';
// import 'package:aim/data/group_entity.dart';
// import 'package:aim/data/todo_entity.dart';
// import 'package:aim/views/todo_view.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
// import 'package:get/get.dart';
//
// class HomePage extends StatelessWidget {
//   const HomePage({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final media = MediaQuery.sizeOf(context);
//     return Scaffold(
//       body: Padding(
//         padding: EdgeInsets.all(
//           media.height * 0.025,
//         ),
//         child: GetBuilder<MainControl>(
//           builder: (logic) {
//             return TodoView(
//               todos: logic.today().$1.groups,
//             );
//           },
//         ),
//       ),
//
//     );
//   }
// }
//
//
// /*
//
//  floatingActionButtonLocation: ExpandableFab.location,
//       floatingActionButton:
//
//
//  */