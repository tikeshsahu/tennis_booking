import 'package:get/get.dart';
import 'package:m3m_tennis_booking/modules/profile/profile_controller.dart';


class ProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ProfileController(), fenix: true);
  }
}