import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m3m_tennis_booking/common/services/storage_service.dart';
import 'package:m3m_tennis_booking/routes/app_routes.dart';
import 'package:m3m_tennis_booking/utils/app_constants.dart';

class AuthController extends GetxController {
  PhoneAuthCredential? confirmationResult;
  FirebaseAuth auth = FirebaseAuth.instance;

  final Rx<TextEditingController> _otpController = Rx(TextEditingController(text: ""));

  final Rx<TextEditingController> _mobileNumberController = Rx(TextEditingController());

  final RxBool _isOtpSent = RxBool(false);

  // final FocusNode focusNode = FocusNode();

  final RxBool _isLoading = RxBool(false);

  final RxString _verificationIdd = RxString("");

  final RxString _userPhoneNumber = RxString("");

  String get userPhoneNumber => _userPhoneNumber.value;

  String get verificationIdd => _verificationIdd.value;

  bool get isLoading => _isLoading.value;

  // FocusNode get otpFocusNode => focusNode;

  bool get isOtpSent => _isOtpSent.value;

  TextEditingController get mobileNumberController => _mobileNumberController.value;

  TextEditingController get otpController => _otpController.value;

  @override
  void onInit() {
    super.onInit();
    // focusNode.addListener(() {
    //   if (focusNode.hasFocus) {
    //     _otpController.value.clear();
    //   }
    // });
  }

  @override
  void dispose() {
    otpController.dispose();
    mobileNumberController.dispose();
    // focusNode.dispose();
    super.dispose();
  }

  updateIsOtpSent(bool value) {
    _isOtpSent.value = value;
    update();
  }

  updateIsLoading(bool value) {
    _isLoading.value = value;
    update();
  }

  Future<void> verifyPhoneNumber(String phoneNumber) async {
    updateIsLoading(true);
    try {
      _userPhoneNumber.value = phoneNumber;
      await auth.verifyPhoneNumber(
        phoneNumber: "+91$phoneNumber",
        timeout: const Duration(seconds: 60),
        verificationCompleted: (PhoneAuthCredential credential) async {
          await auth.signInWithCredential(credential);
          updateIsOtpSent(true);
        },
        verificationFailed: (FirebaseAuthException e) {
        },
        codeSent: (String verificationId, int? resendToken) async {
          _verificationIdd.value = verificationId;
          updateIsLoading(false);
          updateIsOtpSent(true);
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          _verificationIdd.value = verificationId;
          // Auto retrieval of the code has timed out.
          // You can handle it accordingly.
          // print('Auto retrieval timeout');
        },
      );
    } catch (e) {
      print(e);
    }
  }

  Future<void> signInWithPhoneNumber(String smsCode) async {
    updateIsLoading(true);
    try {
      final AuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationIdd,
        smsCode: smsCode,
      );

      UserCredential userCredential = await auth.signInWithCredential(credential);
      String userId = userCredential.user!.uid;
      await FirebaseFirestore.instance.collection('users').doc(userId).set({"name": "user", "userId": userId, "phoneNumber": userPhoneNumber, 'bookings': []});

      if (userCredential.user != null) {
        StorageService.instance.save(AppConstants.userId, userId);
        StorageService.instance.save(AppConstants.userMobile, userPhoneNumber);
        StorageService.instance.save(AppConstants.userName, "user");
        updateIsLoading(false);
        Get.snackbar("Success", "Successfully authenticated");
        Get.offAllNamed(AppRoutes.authSuccessRoute);
      }
    } catch (e) {
      // print('Failed to sign in with phone number: $e');
      // snackbar
      Get.snackbar("Error", "Failed to sign in with phone number: $e");
    }
  }
}
