import 'package:get/get.dart';
import 'package:m3m_tennis_booking/common/widgets/landing_screen.dart';
import 'package:m3m_tennis_booking/modules/auth/auth_binding.dart';
import 'package:m3m_tennis_booking/modules/auth/auth_screen.dart';
import 'package:m3m_tennis_booking/modules/auth/widgets/auth_success_screen.dart';
import 'package:m3m_tennis_booking/modules/booking/booking_binding.dart';
import 'package:m3m_tennis_booking/modules/booking/booking_screen.dart';
import 'package:m3m_tennis_booking/modules/booking/widgets/booking_success_screen.dart';
import 'package:m3m_tennis_booking/modules/invitation/invitation_binding.dart';
import 'package:m3m_tennis_booking/modules/invitation/invitation_screen.dart';
import 'package:m3m_tennis_booking/modules/profile/profile_binding.dart';
import 'package:m3m_tennis_booking/modules/profile/profile_screen.dart';
import 'package:m3m_tennis_booking/modules/user_bookings.dart/user_bookings_binding.dart';
import 'package:m3m_tennis_booking/modules/user_bookings.dart/user_bookings_screen.dart';
import 'package:m3m_tennis_booking/routes/app_routes.dart';

class AppPages {
  static final List<GetPage> pages = [
    GetPage(name: AppRoutes.initialRoute, page: () => const LandingScreen(), ),
    GetPage(name: AppRoutes.authRoute, page: () => const AuthScreen(), binding:AuthBinding()),
    GetPage(name: AppRoutes.authSuccessRoute, page: () => const AuthSuccessScreen()),
    GetPage(name: AppRoutes.profileRoute, page: () => const ProfileScreen(), binding: ProfileBinding()),
    GetPage(name: AppRoutes.bookingRoute, page: () => const BookingScreen(), binding: BookingBinding()),
    GetPage(name: AppRoutes.bookingSuccessRoute, page: () => const BookingSuccessScreen()),
    GetPage(name: AppRoutes.userBookingsRoute, page: () => const UserBookingsScreen(), binding: UserBookingsBinding()),
    GetPage(name: AppRoutes.invitationsRoute, page: () => InvitationScreen(), binding: InvitationBinding()),
  ];
}