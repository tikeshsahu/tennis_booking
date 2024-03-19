import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m3m_tennis_booking/routes/app_routes.dart';
import 'package:m3m_tennis_booking/utils/app_dimensions.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: SafeArea(
          top: true,
          bottom: true,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 100,
                width: size.width / 3,
                color: Colors.grey,
              ),
              const SizedBox(height: AppDimension.normalPadding),
              Text(
                "TENNIS COURT BOOKING",
                style: textTheme.labelMedium,
              ),
              const SizedBox(height: AppDimension.largePadding * 1.5),
              Container(
                height: 400,
                color: Colors.grey,
              ),
              const SizedBox(height: AppDimension.largePadding * 1.5),
              SizedBox(
                width: size.width / 1.5,
                child: OutlinedButton(
                    onPressed: () => Get.toNamed(AppRoutes.authRoute),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.phone_android_outlined,
                          color: Colors.grey,
                        ),
                        const SizedBox(width: AppDimension.normalPadding),
                        Text(
                          "Login with Mobile OTP",
                          style: textTheme.labelSmall,
                        ),
                      ],
                    )),
              ),
            ],
          )),
    );
  }
}
