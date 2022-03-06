import 'package:flutter/material.dart';

class UiHelper {
  const UiHelper._();

  static SizedBox verticalSpace(double size) => SizedBox(height: size);
  static SizedBox horizontalSpace(double size) => SizedBox(width: size);
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
