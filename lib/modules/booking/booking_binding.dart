import 'package:get/get.dart';
import 'package:m3m_tennis_booking/modules/booking/booking_controller.dart';


class BookingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => BookingController(), fenix: true);
  }
}