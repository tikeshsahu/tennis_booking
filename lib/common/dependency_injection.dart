import 'package:get/get.dart';
import 'package:m3m_tennis_booking/common/services/network_service_controller.dart';


class DependencyInjection {
  static void init() {
    Get.put<NetworkController>(NetworkController(), permanent: true);
  }
}