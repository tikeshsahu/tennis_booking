import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m3m_tennis_booking/modules/auth/auth_controller.dart';
import 'package:m3m_tennis_booking/routes/app_routes.dart';
import 'package:m3m_tennis_booking/themes/app_decoration.dart';
import 'package:m3m_tennis_booking/themes/app_theme.dart';
import 'package:m3m_tennis_booking/utils/app_dimensions.dart';
import 'package:pinput/pinput.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final TextTheme textTheme = Theme.of(context).textTheme;
    final controller = Get.put(AuthController());

    return Scaffold(
      body: SafeArea(
          top: true,
          bottom: true,
          child: SingleChildScrollView(
            child: Obx(
              () => controller.isLoading
                  ? SizedBox(height: size.height, width: size.width, child: const Center(child: CircularProgressIndicator()))
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: AppDimension.largePadding * 3),
                        Container(
                          height: 100,
                          width: size.width / 3,
                          color: Colors.grey,
                        ),
                        const SizedBox(height: AppDimension.largePadding * 3),
                        Obx(
                          () => controller.isOtpSent
                              ? Text(
                                  "Enter the 6 digit number that\nwas sent to the below number",
                                  style: textTheme.labelMedium,
                                  textAlign: TextAlign.center,
                                )
                              : Text(
                                  "To continue enter your phone number",
                                  style: textTheme.labelMedium,
                                ),
                        ),

                        const SizedBox(height: AppDimension.largePadding * 3),
                        Obx(
                          () => Padding(
                            padding: const EdgeInsets.symmetric(horizontal: AppDimension.normalPadding * 2),
                            child: TextField(
                              controller: controller.mobileNumberController,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                enabled: controller.isOtpSent ? false : true,
                                hintText: "Mobile number",
                                prefixIcon: const Icon(Icons.phone_android_outlined),
                                prefixIconColor: Colors.grey,
                                contentPadding: const EdgeInsets.all(AppDimension.normalPadding),
                                enabledBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey),
                                ),
                                border: const UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey),
                                ),
                                suffixIcon: GestureDetector(onTap: () => Navigator.of(context).pop(), child: const Icon(Icons.edit_outlined)),
                                suffixIconColor: AppTheme.myColorScheme.primary,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: AppDimension.largePadding * 3),

                        // otp input
                        Visibility(
                          visible: controller.isOtpSent,
                          child: Container(
                            // color: Colors.amber,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: AppDimension.normalPadding * 3),
                              child: Center(
                                child: Pinput(
                                  autofocus: true,
                                  closeKeyboardWhenCompleted: true,
                                  enabled: true,

                                  controller: controller.otpController,
                                  length: 6,
                                  defaultPinTheme: AppDecorations.defaultPinTheme,
                                  focusedPinTheme: AppDecorations.focusedPinTheme,
                                  submittedPinTheme: AppDecorations.submittedPinTheme,
                                  //focusNode: controller.otpFocusNode,
                                  pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                                  showCursor: true,
                                  cursor: AppDecorations.cursor,
                                  preFilledWidget: AppDecorations.preFilledWidget,

                                  validator: (value) {
                                    if (value!.length != 6) {
                                      return "Please enter 6 digit OTP";
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: AppDimension.largePadding * 3),
                        SizedBox(
                            width: size.width / 1.5,
                            child: ElevatedButton(
                              //onPressed: () => Get.toNamed(AppRoutes.authSuccessRoute),
                              onPressed: () async {
                                if (controller.isOtpSent) {
                                  await controller.signInWithPhoneNumber(
                                    controller.otpController.text,
                                  );
                                } else {
                                  await controller.verifyPhoneNumber(controller.mobileNumberController.text);
                                }
                              },
                              child: Obx(
                                () => Text(
                                  controller.isOtpSent ? "Verify" : "Send OTP",
                                  style: const TextStyle(color: Colors.black),
                                ),
                              ),
                            )),
                      ],
                    ),
            ),
          )),
    );
  }
}
