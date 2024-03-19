import 'package:get/get.dart';
import 'package:m3m_tennis_booking/modules/auth/auth_controller.dart';


class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AuthController(), fenix: true);
  }
}