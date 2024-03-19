import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m3m_tennis_booking/modules/booking/booking_controller.dart';
import 'package:m3m_tennis_booking/routes/app_routes.dart';
import 'package:m3m_tennis_booking/themes/app_theme.dart';
import 'package:m3m_tennis_booking/utils/app_dimensions.dart';

class BookingSuccessScreen extends StatelessWidget {
  const BookingSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;
    final BookingController bookingController = Get.find();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
        elevation: 0,
      ),
      body: SizedBox(
        width: size.width,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppDimension.normalPadding),
          child: Obx(
            () => Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: AppDimension.normalPadding),
                Icon(
                  Icons.done_outline_rounded,
                  size: 50,
                  color: AppTheme.myColorScheme.primary,
                ),
                const SizedBox(
                  height: AppDimension.largePadding,
                ),
                Text(
                  "Booking Confirmed",
                  style: textTheme.headlineSmall,
                ),
                const SizedBox(
                  height: AppDimension.largePadding,
                ),
                Container(
                  padding: const EdgeInsets.all(AppDimension.normalPadding + 5),
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: AppTheme.myColorScheme.secondary,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(4)),
                  width: size.width / 1.1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(bookingController.courtSide),
                      Column(
                        children: [
                          Text(bookingController.formatDate(bookingController.selectedDate)),
                          const SizedBox(height: AppDimension.normalPadding / 4),
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: AppTheme.myColorScheme.primary,
                              ),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: AppDimension.normalPadding, vertical: 4),
                              child: Text(
                                "${bookingController.selectedTime} - ${bookingController.addOneHour(bookingController.selectedTime)}",
                                style: textTheme.labelSmall!.copyWith(color: AppTheme.myColorScheme.primary),
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: AppDimension.largePadding,
                ),
                Row(
                  children: const [
                    Icon(
                      Icons.add_circle,
                      color: Colors.green,
                      size: 26,
                    ),
                    SizedBox(width: AppDimension.normalPadding),
                    Text("You can invite up to 3 members")
                  ],
                ),
                const SizedBox(
                  height: AppDimension.largePadding,
                ),
                Container(
                  padding: const EdgeInsets.all(AppDimension.normalPadding),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: AppTheme.myColorScheme.secondary,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  height: 60,
                  width: size.width / 1.1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 3,
                        child: Row(
                          children: [
                            ConstrainedBox(constraints: BoxConstraints(maxWidth: size.width * 0.48), child: const Text("User")),
                            const SizedBox(width: AppDimension.normalPadding / 2),
                            const Text("(Host)"),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: AppDimension.normalPadding,
                ),
                ListView.separated(
                  shrinkWrap: true,
                  itemCount: 1,
                  itemBuilder: (context, index) {
                    return Container(
                      padding: const EdgeInsets.all(AppDimension.normalPadding),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: AppTheme.myColorScheme.secondary,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      height: 60,
                      width: size.width / 1.1,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                              flex: 3,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: const [
                                  //Text(bookingController.membersList[index]["name"]),
                                  Text("Member"),
                                  // TextButton(
                                  //   child: const Text("Remove"),
                                  //   onPressed: () => bookingController.removeMemberFromMemberList(index),
                                  // )
                                ],
                              )
                              // Row(
                              //   children: [
                              //     ConstrainedBox(constraints: BoxConstraints(maxWidth: size.width * 0.48), child: const Text("Baba Ramdev")),
                              //     const SizedBox(width: AppDimension.normalPadding / 2),
                              //     const Text("(Host)"),
                              //   ],
                              // ),
                              ),
                          Expanded(flex: 1, child: TextButton(onPressed: () {}, child: const Text("Remove")))
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => const SizedBox(height: AppDimension.normalPadding),
                ),
                if (bookingController.membersList.length < 3)
                  TextButton(
                      onPressed: () {
                        // bookingController.addMemberToMemberList(
                        //   {"name": "Baba Ramdev", "mobile": "123"},
                        // );
                      },
                      child: const Text("Add Member")),
                const SizedBox(
                  height: AppDimension.normalPadding * 2,
                ),
                TextButton(
                    onPressed: () {
                      Get.offNamed(AppRoutes.userBookingsRoute);
                    },
                    child: const Text("See all Bookings")),
                TextButton(onPressed: () {}, child: const Text("Invite Later"))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
