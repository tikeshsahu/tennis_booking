import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m3m_tennis_booking/modules/user_bookings.dart/user_bookings_controller.dart';
import 'package:m3m_tennis_booking/modules/user_bookings.dart/widgets/user_bookings_tile.dart';
import 'package:m3m_tennis_booking/themes/app_theme.dart';
import 'package:m3m_tennis_booking/utils/app_dimensions.dart';

class UserBookingsScreen extends StatelessWidget {
  const UserBookingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final TextTheme textTheme = Theme.of(context).textTheme;
    final UserBookingsController userBookingsController = Get.put(UserBookingsController());

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
            size: AppDimension.normalIconSize,
          ),
        ),
        title: Text(
          "My Bookings",
          style: textTheme.titleLarge,
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: SafeArea(
          // top: true,
          // bottom: true,
          child: SingleChildScrollView(
        padding: const EdgeInsets.all(AppDimension.normalPadding),
        child: Obx(
          () => Column(
            children: [
              const SizedBox(height: AppDimension.normalPadding / 2),

              // ToggleButton
              // Obx(
              //   () =>
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      decoration: BoxDecoration(
                        color: AppTheme.myColorScheme.secondary,
                        borderRadius: BorderRadius.circular(AppDimension.normalPadding / 1.2),
                      ),
                      height: size.height * 0.058,
                      width: size.width / 1.3,
                      child: Row(
                        children: [
                          Expanded(
                              flex: 1,
                              child: GestureDetector(
                                onTap: () {
                                  userBookingsController.updateisUpcomingBookingType(true);
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: userBookingsController.isUpcomingBookingType ? AppTheme.myColorScheme.primary : Colors.transparent,
                                    borderRadius: BorderRadius.circular(AppDimension.normalPadding / 1.2),
                                  ),
                                  child: Center(
                                    child: Text(
                                      "Upcoming",
                                      style: textTheme.labelSmall!.copyWith(color: userBookingsController.isUpcomingBookingType ? Colors.black : Colors.grey),
                                    ),
                                  ),
                                ),
                              )),
                          Expanded(
                              flex: 1,
                              child: GestureDetector(
                                onTap: () {
                                  userBookingsController.updateisUpcomingBookingType(false);
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: !userBookingsController.isUpcomingBookingType ? AppTheme.myColorScheme.primary : Colors.transparent,
                                    borderRadius: BorderRadius.circular(AppDimension.normalPadding / 1.2),
                                  ),
                                  child: Center(
                                    child: Text(
                                      "Completed",
                                      style: textTheme.labelSmall!.copyWith(color: !userBookingsController.isUpcomingBookingType ? Colors.black : Colors.grey),
                                    ),
                                  ),
                                ),
                              )),
                        ],
                      )),
                ],
              ),
              // )

              const SizedBox(height: AppDimension.largePadding),

              ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: userBookingsController.isUpcomingBookingType ? userBookingsController.upcomingBookings.length : userBookingsController.completedBookings.length,
                itemBuilder: (context, index) {
                  if (userBookingsController.isUpcomingBookingType) {
                    if (userBookingsController.upcomingBookings.isEmpty) {
                      return const Center(child: Text("No Upcoming Bookings", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)));
                    } else {
                      return UserBookingsTile(
                        index: index,
                      );
                    }
                  } else {
                    if (userBookingsController.completedBookings.isEmpty) {
                      return const Center(child: Text("No Completed Bookings"));
                    } else {
                      return UserBookingsTile(
                        index: index,
                      );
                    }
                  }
                },
                separatorBuilder: (context, index) => const SizedBox(height: AppDimension.normalPadding),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
