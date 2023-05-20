import 'package:flutter/material.dart';

import '/theme/app_colors.dart';

abstract class AppButtonStyle {
  static final ButtonStyle blueStyleButton = ButtonStyle(
    backgroundColor: const MaterialStatePropertyAll(
      AppColors.buttonBlue,
    ),
    foregroundColor: const MaterialStatePropertyAll(
      Colors.white,
    ),
    overlayColor: const MaterialStatePropertyAll(
      AppColors.buttonPressed,
    ),
    splashFactory: NoSplash.splashFactory,
    minimumSize: const MaterialStatePropertyAll(
      Size.fromHeight(44),
    ),
    shape: MaterialStatePropertyAll(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
    ),
    side: const MaterialStatePropertyAll(BorderSide.none),
  );

  static final ButtonStyle greenStyleButton = ButtonStyle(
    backgroundColor: const MaterialStatePropertyAll(
      AppColors.buttonGreen,
    ),
    foregroundColor: const MaterialStatePropertyAll(
      Colors.white,
    ),
    overlayColor: const MaterialStatePropertyAll(
      AppColors.buttonPressed,
    ),
    splashFactory: NoSplash.splashFactory,
    minimumSize: const MaterialStatePropertyAll(
      Size.fromHeight(44),
    ),
    shape: MaterialStatePropertyAll(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
    ),
    side: const MaterialStatePropertyAll(BorderSide.none),
  );

  static const ButtonStyle linkStyleButton = ButtonStyle(
    backgroundColor: MaterialStatePropertyAll(
      AppColors.appBackgroundColor,
    ),
    foregroundColor: MaterialStatePropertyAll(
      AppColors.linkBlue,
    ),
    overlayColor: MaterialStatePropertyAll(
      AppColors.appBackgroundColor,
    ),
    splashFactory: NoSplash.splashFactory,
    visualDensity: VisualDensity.compact,
    padding: MaterialStatePropertyAll(
      EdgeInsets.zero,
    ),
  );

  static ButtonStyle blueStyleDeactivableButton({bool isActive = true}) {
    return ButtonStyle(
      backgroundColor: MaterialStatePropertyAll(
        isActive ? AppColors.buttonBlue : AppColors.buttonBlueInactive,
      ),
      foregroundColor: const MaterialStatePropertyAll(
        AppColors.appBackgroundColor,
      ),
      overlayColor: const MaterialStatePropertyAll(
        AppColors.buttonPressed,
      ),
      splashFactory: NoSplash.splashFactory,
      minimumSize: const MaterialStatePropertyAll(
        Size.fromHeight(44),
      ),
      shape: MaterialStatePropertyAll(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
      side: const MaterialStatePropertyAll(BorderSide.none),
    );
  }

  static final ButtonStyle whiteStyleButton = ButtonStyle(
    backgroundColor: const MaterialStatePropertyAll(
      AppColors.appBackgroundColor,
    ),
    foregroundColor: const MaterialStatePropertyAll(
      Colors.black,
    ),
    overlayColor: const MaterialStatePropertyAll(
      Color.fromRGBO(38, 136, 235, 0.1),
    ),
    splashFactory: NoSplash.splashFactory,
    minimumSize: const MaterialStatePropertyAll(
      Size.fromHeight(44),
    ),
    shape: MaterialStatePropertyAll(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
    ),
  );
}
