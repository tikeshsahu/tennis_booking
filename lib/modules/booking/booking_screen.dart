import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m3m_tennis_booking/modules/booking/booking_controller.dart';
import 'package:m3m_tennis_booking/routes/app_routes.dart';
import 'package:m3m_tennis_booking/themes/app_theme.dart';
import 'package:m3m_tennis_booking/utils/app_dimensions.dart';
import 'package:m3m_tennis_booking/utils/app_utils.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:intl/intl.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({super.key});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 7, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final TextTheme textTheme = Theme.of(context).textTheme;
    final BookingController bookingController = Get.put(BookingController());

    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () => Get.toNamed(AppRoutes.userBookingsRoute),
            icon: const Icon(
              Icons.play_circle_filled_sharp,
              color: Colors.grey,
              size: AppDimension.normalIconSize * 1.5,
            ),
          ),
          title: Text(
            "Book your next play",
            style: textTheme.titleLarge,
          ),
          centerTitle: true,
          elevation: 0,
          actions: [
            IconButton(
              onPressed: () => Get.toNamed(AppRoutes.profileRoute),
              icon: const Icon(
                Icons.person,
                color: Colors.grey,
                size: AppDimension.normalIconSize * 1.5,
              ),
            ),
          ],
        ),
        body: TabBarView(
          controller: _tabController,
          children: _buildTabViews(_tabController, bookingController),
        ),
        bottomNavigationBar: TabBar(
          controller: _tabController,
          isScrollable: true,
          tabs: _buildTabs(),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton(
          onPressed: () => showModalBottomSheet(
            context: context,
            builder: (context) => Obx(
              () => bookingController.isBooking
                  ? const Center(child: CircularProgressIndicator())
                  : Container(
                      height: size.height / 2.7,
                      color: AppTheme.myColorScheme.secondary,
                      child: Padding(
                        padding: const EdgeInsets.all(AppDimension.normalPadding),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    IconButton(
                                      onPressed: () => Navigator.of(context).pop(),
                                      icon: const Icon(
                                        Icons.close,
                                        color: Colors.grey,
                                        size: AppDimension.normalIconSize,
                                      ),
                                    ),
                                    const SizedBox(width: AppDimension.normalPadding),
                                    Text(
                                      "Booking Confirmation",
                                      style: textTheme.headlineSmall,
                                    ),
                                  ],
                                ),
                                const SizedBox(height: AppDimension.normalPadding),
                                Container(
                                  padding: const EdgeInsets.all(AppDimension.normalPadding),
                                  decoration: BoxDecoration(border: Border.all(color: Colors.grey, width: 1), borderRadius: BorderRadius.circular(4)),
                                  width: size.width / 1.2,
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
                                const SizedBox(height: AppDimension.normalPadding),
                                Text(
                                  "Please confirm your tennis court\nbooking for an one hour slot.",
                                  style: textTheme.labelMedium,
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                OutlinedButton(
                                  onPressed: () => Navigator.of(context).pop(),
                                  child: Text(
                                    "Cancel",
                                    style: textTheme.labelSmall,
                                  ),
                                ),
                                const SizedBox(width: AppDimension.normalPadding),
                                ElevatedButton(
                                  onPressed: () => bookingController.addUserBooking(),
                                  child: const Text("Confirm", style: TextStyle(color: Colors.black)),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
            ),
          ),
          shape: const CircleBorder(),
          child: Text("Book", style: textTheme.labelSmall!.copyWith(color: Colors.black)),
        ));
  }
}

List<Meeting> _getDataSource() {
  final List<Meeting> meetings = <Meeting>[];
  final DateTime today = DateTime.now();
  final DateTime startTime = DateTime(today.year, today.month, today.day, 1);
  final DateTime endTime = startTime.add(const Duration(hours: 1));
  meetings.add(Meeting('Conference', startTime, endTime, const Color(0xFF0F8644), false));
  return meetings;
}

class MeetingDataSource extends CalendarDataSource {
  /// Creates a meeting data source, which used to set the appointment
  /// collection to the calendar
  MeetingDataSource(List<Meeting> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return _getMeetingData(index).from;
  }

  @override
  DateTime getEndTime(int index) {
    return _getMeetingData(index).to;
  }

  @override
  String getSubject(int index) {
    return _getMeetingData(index).eventName;
  }

  @override
  Color getColor(int index) {
    return _getMeetingData(index).background;
  }

  @override
  bool isAllDay(int index) {
    return _getMeetingData(index).isAllDay;
  }

  Meeting _getMeetingData(int index) {
    final dynamic meeting = appointments![index];
    late final Meeting meetingData;
    if (meeting is Meeting) {
      meetingData = meeting;
    }

    return meetingData;
  }
}

/// Custom business object class which contains properties to hold the detailed
/// information about the event data which will be rendered in calendar.
class Meeting {
  /// Creates a meeting class with required details.
  Meeting(this.eventName, this.from, this.to, this.background, this.isAllDay);

  /// Event name which is equivalent to subject property of [Appointment].
  String eventName;

  /// From which is equivalent to start time property of [Appointment].
  DateTime from;

  /// To which is equivalent to end time property of [Appointment].
  DateTime to;

  /// Background which is equivalent to color property of [Appointment].
  Color background;

  /// IsAllDay which is equivalent to isAllDay property of [Appointment].
  bool isAllDay;
}

List<Widget> _buildTabs() {
  DateTime today = DateTime.now();
  List<Widget> tabs = [];

  for (int i = 0; i < 7; i++) {
    DateTime day = today.add(Duration(days: i));
    tabs.add(
      Tab(
          height: 70,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  // get date(number) and if it is today, then show today& tomorrow show tomorrow
                  AppUtils.getFormattedDate(day),
                  style: const TextStyle(fontSize: 12),
                ),
                Text(
                  AppUtils.getDayOfWeek(day),
                  style: const TextStyle(fontSize: 10, color: Colors.grey),
                ),
                const SizedBox(height: 4),
                const Text(
                  "10 Slots",
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
                ),
              ],
            ),
          )),
    );
  }
  return tabs;
}

List<Widget> _buildTabViews(TabController tabController, BookingController bookingController) {
  DateTime today = DateTime.now();
  List<Widget> tabViews = [];

  for (int i = 0; i < 7; i++) {
    DateTime day = today.add(Duration(days: i));
    tabViews.add(
      SfCalendar(
          view: CalendarView.week,
          dataSource: MeetingDataSource(_getDataSource()),
          firstDayOfWeek: DateTime.now().weekday,
          showCurrentTimeIndicator: true,
          backgroundColor: Colors.black,
          onSelectionChanged: (calendarSelectionDetails) {},
          selectionDecoration: const BoxDecoration(
            color: Color.fromARGB(255, 110, 184, 112),
            shape: BoxShape.rectangle,
          ),
          onTap: (calendarTapDetails) {
            bookingController.updateSelectedDate(calendarTapDetails.date!);
          },
          headerHeight: 60,
          viewHeaderHeight: 0,
          headerDateFormat: "dd MMM yyyy, EEEE",
          headerStyle: const CalendarHeaderStyle(
            textAlign: TextAlign.center,
            textStyle: TextStyle(
              fontSize: 16,
              color: Colors.white,
            ),
          ),
          timeSlotViewSettings: const TimeSlotViewSettings(
              numberOfDaysInView: 1,
              startHour: 8,
              endHour: 22,
              timeInterval: Duration(minutes: 60),
              timeIntervalHeight: 100,
              timeFormat: 'h a',
              timeRulerSize: -1,
              timeTextStyle: TextStyle(
                fontSize: 12,
                color: Colors.white,
              ))),
    );
  }

  return tabViews;
}

Future _invitationBottomSheet({required BuildContext context, required Size size, required TextTheme textTheme, required BookingController controller}) {
  return showModalBottomSheet(
    context: context,
    builder: (context) {
      return Container(
        height: size.height / 2.7,
        color: AppTheme.myColorScheme.secondary,
        child: Padding(
          padding: const EdgeInsets.all(AppDimension.normalPadding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      IconButton(
                        onPressed: () => Navigator.of(context).pop(),
                        icon: const Icon(
                          Icons.close,
                          color: Colors.grey,
                          size: AppDimension.normalIconSize,
                        ),
                      ),
                      const SizedBox(width: AppDimension.normalPadding),
                      Text(
                        "Invite Members",
                        style: textTheme.headlineSmall,
                      ),
                    ],
                  ),
                  const SizedBox(height: AppDimension.largePadding),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: const [
                      SizedBox(
                        width: AppDimension.largePadding,
                      ),
                      CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.grey,
                      ),
                      SizedBox(width: AppDimension.largePadding),
                      CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.grey,
                      ),
                    ],
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  OutlinedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text(
                      "Cancel",
                      style: textTheme.labelSmall,
                    ),
                  ),
                  const SizedBox(width: AppDimension.normalPadding),
                  ElevatedButton(
                    onPressed: () {},
                    child: const Text("Send Invite", style: TextStyle(color: Colors.black)),
                  ),
                ],
              )
            ],
          ),
        ),
      );
    },
  );
}
