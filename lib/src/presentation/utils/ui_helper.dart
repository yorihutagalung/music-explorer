import 'package:flutter/material.dart';
import 'package:music_explorer/src/domain/app_failure.dart';
import 'package:music_explorer/src/presentation/router.dart';

class UiHelper {
  const UiHelper._();

  static SizedBox verticalSpace(double size) => SizedBox(height: size);
  static SizedBox horizontalSpace(double size) => SizedBox(width: size);

  static void handleFailure(AppFailure failure) {
    final context = AppRouter.navigatorKey.currentContext;
    if (context != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text(failure.error),
          behavior: SnackBarBehavior.floating,
          action: SnackBarAction(
            label: 'Close',
            textColor: Colors.white,
            onPressed: () {
              ScaffoldMessenger.of(context).clearSnackBars();
            },
          ),
        ),
      );
    }
  }
}

enum UiGap {
  small,
  medium,
  normal,
  big,
}

extension Size on UiGap {
  double get size {
    switch (this) {
      case UiGap.small:
        return 5;
      case UiGap.medium:
        return 10;
      case UiGap.normal:
        return 15;
      case UiGap.big:
        return 20;
    }
  }

  SizedBox get verticalSpace => UiHelper.verticalSpace(size);
  SizedBox get horizontalSpace => UiHelper.horizontalSpace(size);
}
