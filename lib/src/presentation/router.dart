import 'package:flutter/material.dart';
import 'package:music_explorer/src/presentation/pages/index.dart';

class AppRouter {
  const AppRouter._();
  static const String initialRoute = '/';
  static Map<String, WidgetBuilder> routes = {
    '/': (_) => const HomePage(),
  };
}
