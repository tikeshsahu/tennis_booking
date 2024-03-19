import 'package:get/get.dart';
import 'package:m3m_tennis_booking/modules/invitation/invitation_controller.dart';


class InvitationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => InvitationController(), fenix: true);
  }
}