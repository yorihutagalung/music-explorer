import 'package:flutter/material.dart';
import 'package:music_explorer/src/presentation/pages/index.dart';

class MusicExplorerApp extends StatelessWidget {
  const MusicExplorerApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: MaterialApp(
        title: 'Music Explorer',
        theme: ThemeData(primarySwatch: Colors.brown),
        home: const HomePage(),
      ),
    );
  }
}
