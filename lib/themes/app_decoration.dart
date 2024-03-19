import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';

class AppDecorations {
  static final defaultPinTheme = PinTheme(
    width: 55,
    height: 56,
    textStyle: Theme.of(Get.key.currentContext!).textTheme.bodyLarge!.copyWith(
          color: const Color(0xFFFAF8F2),
        ),
    decoration: const BoxDecoration(
      color: Colors.grey,
      //border: Border.all(color: AppColors.borderColor),
      //borderRadius: BorderRadius.circular(AppConstants.kRadius),
    ),
  );

  static final cursor = Column(
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      Container(
        width: 56,
        height: 3,
        decoration: BoxDecoration(
          color: Colors.pink,
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    ],
  );

  static final preFilledWidget = Column(
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      Container(
        width: 56,
        height: 3,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    ],
  );

  static final focusedPinTheme = PinTheme(
    width: 55,
    height: 56,
    textStyle: Theme.of(Get.key.currentContext!).textTheme.bodyLarge!.copyWith(
          color: const Color(0xFFFAF8F2),
        ),
    decoration: BoxDecoration(
      color: Colors.grey,
      border: Border.all(color: const Color.fromRGBO(114, 178, 238, 1)),
      borderRadius: BorderRadius.circular(8),
    ),
  );

  static final submittedPinTheme = 
  PinTheme(
    width: 55,
    height: 50,
    textStyle: Theme.of(Get.key.currentContext!).textTheme.bodyLarge!.copyWith(
          color: const Color(0xFFFAF8F2),
        ),
    decoration: BoxDecoration(
      color: Colors.grey,
      border: Border.all(color: const Color.fromRGBO(234, 239, 243, 1)),
      borderRadius: BorderRadius.circular(8),
    ),
  );
}
