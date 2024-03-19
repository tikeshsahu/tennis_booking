import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:m3m_tennis_booking/common/widgets/no_internet_dialog.dart';

class NetworkController extends GetxController {
  final Connectivity _connectivity = Connectivity();

  @override
  void onInit() {
    super.onInit();
    _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  void _updateConnectionStatus(ConnectivityResult connectivityResult) {
    if (connectivityResult == ConnectivityResult.none) {
      Get.dialog(const NoInternetDialog(), barrierDismissible: false);
    } else {
      if (Get.isDialogOpen!) {
        Navigator.of(Get.context!).pop();
      }
    }
  }
}