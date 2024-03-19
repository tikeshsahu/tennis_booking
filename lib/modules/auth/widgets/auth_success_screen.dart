import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m3m_tennis_booking/routes/app_routes.dart';
import 'package:m3m_tennis_booking/themes/app_theme.dart';
import 'package:m3m_tennis_booking/utils/app_dimensions.dart';

class AuthSuccessScreen extends StatefulWidget {
  const AuthSuccessScreen({super.key});

  @override
  State<AuthSuccessScreen> createState() => _AuthSuccessScreenState();
}

class _AuthSuccessScreenState extends State<AuthSuccessScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 2)).then((value) => Get.offNamed(AppRoutes.bookingRoute));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: SafeArea(
          top: true,
          bottom: true,
          child: SizedBox(
            height: size.height,
            width: size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    const SizedBox(height: AppDimension.largePadding * 4),
                    Icon(
                      Icons.done_outline_rounded,
                      size: 50,
                      color: AppTheme.myColorScheme.primary,
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      "Success!!",
                      style: textTheme.titleMedium,
                    ),
                    const SizedBox(height: AppDimension.normalPadding),
                    Text(
                      "Congrats! You have been\nsuccessfully authenticated.",
                      style: textTheme.labelSmall,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: AppDimension.largePadding),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      "Redirecting to your booking screen\nin 3 sec",
                      style: textTheme.labelSmall,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: AppDimension.largePadding * 2),
                  ],
                ),
              ],
            ),
          )),
    );
  }
}
