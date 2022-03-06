import 'package:flutter/material.dart';
import 'package:music_explorer/src/presentation/utils/ui_helper.dart';

part 'widgets/search_field.dart';
part 'widgets/music_list.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        titleSpacing: 0,
        title: const _SearchField(),
      ),
      body: const _MusicList(),
    );
  }
}
