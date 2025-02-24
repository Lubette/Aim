import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:lubette_todo_flutter/controls/main_control.dart';
import 'package:lubette_todo_flutter/pages/main_page.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:window_manager/window_manager.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    await windowManager.ensureInitialized();
    WindowOptions windowOptions = WindowOptions(
      // size: Size(800, 600),
      minimumSize: Size(300, 300),
      center: true,
      backgroundColor: Colors.transparent,
      skipTaskbar: false,
      titleBarStyle: TitleBarStyle.hidden,
    );
    windowManager.waitUntilReadyToShow(windowOptions, () async {
      await windowManager.show();
      await windowManager.focus();
    });
  }
  runApp(
    App(),
  );
}

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class App extends StatelessWidget {
  App({super.key}) {
    _mainControl.load();
  }
  final _mainControl = Get.put(MainControl());

  @override
  Widget build(BuildContext context) {
    return ShadApp.custom(
      themeMode: ThemeMode.light,
      theme: ShadThemeData(
        brightness: Brightness.light,
        colorScheme: ShadColorScheme.fromName(
          'zinc',
          brightness: Brightness.light,
        ),
        textTheme: ShadTextTheme(
          family: 'JBMN',
        ),
      ),
      darkTheme: ShadThemeData(
        brightness: Brightness.dark,
        colorScheme: ShadColorScheme.fromName(
          'zinc',
          brightness: Brightness.dark,
        ),
        textTheme: ShadTextTheme(
          family: 'JBMN',
        ),
      ),
      appBuilder: (context, theme) => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        builder: EasyLoading.init(),
        theme: theme,
        home: MainPage(),
        defaultTransition: Transition.native,
      ),
    );
  }
}
