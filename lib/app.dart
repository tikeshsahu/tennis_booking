import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m3m_tennis_booking/routes/app_pages.dart';
import 'package:m3m_tennis_booking/themes/app_theme.dart';
import 'package:m3m_tennis_booking/utils/app_utils.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      navigatorKey: Get.key,
      debugShowCheckedModeBanner: false,
      title: 'M3M Tennis Booking',
      theme: AppTheme.darkTheme,
      initialRoute: AppUtils.checkUser(),
      getPages: AppPages.pages,
    );
  }
}
