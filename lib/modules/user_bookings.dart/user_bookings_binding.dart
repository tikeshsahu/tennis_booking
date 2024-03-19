import 'package:get/get.dart';
import 'package:m3m_tennis_booking/modules/user_bookings.dart/user_bookings_controller.dart';


class UserBookingsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => UserBookingsController(), fenix: true);
  }
}