import 'package:flutter/material.dart';
import 'package:music_explorer/config/injection.dart';
import 'package:music_explorer/src/presentation/music_explorer_app.dart';

void main() {
  configureInjection();
  runApp(const MusicExplorerApp());
}
