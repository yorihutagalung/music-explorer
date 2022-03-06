import 'package:flutter/material.dart';
import 'package:music_explorer/src/presentation/router.dart';

class MusicExplorerApp extends StatelessWidget {
  const MusicExplorerApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: MaterialApp(
        navigatorKey: AppRouter.navigatorKey,
        title: 'Music Explorer',
        theme: ThemeData(primarySwatch: Colors.brown),
        routes: AppRouter.routes,
        initialRoute: AppRouter.initialRoute,
      ),
    );
  }
}
