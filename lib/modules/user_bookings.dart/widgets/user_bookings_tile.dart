import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m3m_tennis_booking/modules/user_bookings.dart/user_bookings_controller.dart';
import 'package:m3m_tennis_booking/themes/app_theme.dart';
import 'package:m3m_tennis_booking/utils/app_dimensions.dart';

class UserBookingsTile extends StatelessWidget {
  final int index;
  const UserBookingsTile({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final TextTheme textTheme = Theme.of(context).textTheme;
    final UserBookingsController controller = Get.find<UserBookingsController>();

    return ExpansionTile(
      title: Text(
        controller.isUpcomingBookingType ? "${controller.upcomingBookings[index]["court"]} court" : "${controller.completedBookings[index]["court"]} court",
        style: const TextStyle(color: Colors.white),
      ),
      backgroundColor: AppTheme.myColorScheme.secondary,
      collapsedBackgroundColor: AppTheme.myColorScheme.secondary,
      collapsedShape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      tilePadding: const EdgeInsets.all(18),
      trailing: SizedBox(
        width: size.width / 1.8,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Column(
              children: [
                Text(controller.convertDate(controller.isUpcomingBookingType ? controller.upcomingBookings[index]["date"] : controller.completedBookings[index]["date"])),
                const SizedBox(height: AppDimension.normalPadding / 4),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: controller.isUpcomingBookingType ? AppTheme.myColorScheme.primary : Colors.grey,
                    ),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: AppDimension.normalPadding / 2, vertical: 4),
                    child: Text(
                      controller.isUpcomingBookingType ? "${controller.upcomingBookings[index]["startTime"]} - ${controller.addOneHour(controller.upcomingBookings[index]["startTime"])}" : "${controller.completedBookings[index]["startTime"]} - ${controller.addOneHour(controller.completedBookings[index]["startTime"])}",
                      style: textTheme.labelSmall!.copyWith(color: controller.isUpcomingBookingType ? AppTheme.myColorScheme.primary : Colors.grey),
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(width: AppDimension.normalPadding),
            const Icon(
              Icons.keyboard_arrow_down,
            )
          ],
        ),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      childrenPadding: const EdgeInsets.all(AppDimension.normalPadding),
      children: [
        Column(
          children: [
            const Divider(
              color: Colors.grey,
            ),
            const SizedBox(
              height: AppDimension.normalPadding,
            ),
            controller.isUpcomingBookingType
                ? Row(
                    children: const [
                      Icon(
                        Icons.add_circle,
                        color: Colors.green,
                        size: 26,
                      ),
                      SizedBox(width: AppDimension.normalPadding),
                      Text("You can invite up to 3 members")
                    ],
                  )
                : Row(
                    children: const [
                      Text("Invited Members"),
                    ],
                  ),
            const SizedBox(
              height: AppDimension.normalPadding,
            ),
            Obx(
              () => ListView.separated(
                shrinkWrap: true,
                itemCount: controller.membersList.length,
                itemBuilder: (context, index) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(controller.membersList[index]["name"]),
                      controller.isUpcomingBookingType
                          ? TextButton(
                              child: const Text("Remove"),
                              onPressed: () => controller.removeMemberFromMemberList(index),
                            )
                          : const SizedBox()
                    ],
                  );
                },
                separatorBuilder: (context, index) => const SizedBox(height: AppDimension.normalPadding),
              ),
            ),
            if (controller.membersList.length < 3 && controller.isUpcomingBookingType)
              TextButton(
                  onPressed: () {
                    controller.addMemberToMemberList({"name": "Added user", "mobile": "12345"}, controller.isUpcomingBookingType ? controller.upcomingBookings[index]["bookingId"] : controller.completedBookings[index]["bookingId"]);
                  },
                  child: const Text("Add Member")),
            const SizedBox(
              height: AppDimension.normalPadding,
            ),
            const Divider(
              color: Colors.grey,
            ),
            const SizedBox(
              height: AppDimension.normalPadding,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Booking ID"),
                      // Container(
                      //   color: Colors.amber,
                      //   child: ConstrainedBox(constraints: BoxConstraints(maxWidth: size.width * 0.52), child:
                      Text(
                        controller.isUpcomingBookingType ? controller.upcomingBookings[index]["bookingId"] : controller.completedBookings[index]["bookingId"],
                        maxLines: 2,
                      )
                      // ),
                      // )
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: const [Text("Booked on"), Text("10 Jan 2021")],
                  ),
                )
              ],
            ),
            const SizedBox(
              height: AppDimension.normalPadding,
            ),
          ],
        )
      ],
    );
  }
}
