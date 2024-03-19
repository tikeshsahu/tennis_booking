import 'package:flutter/material.dart';
import 'package:m3m_tennis_booking/common/services/storage_service.dart';
import 'package:m3m_tennis_booking/routes/app_routes.dart';
import 'package:m3m_tennis_booking/utils/app_constants.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class AppUtils {

  static String checkUser() {
    //  return AppRoutes.invitationsRoute;
    if (StorageService.instance.fetch(AppConstants.userId) != null) {
      return AppRoutes.bookingRoute;
    } else {
      return AppRoutes.initialRoute;
    }
  }

  static getDayOfWeek(DateTime date) {
    List<String> daysOfWeek = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
    return daysOfWeek[date.weekday - 1];
  }

  static String getFormattedDate(DateTime date) {
    DateTime today = DateTime.now();
    DateTime tomorrow = today.add(const Duration(days: 1));
    if (date.day == today.day && date.month == today.month && date.year == today.year) {
      return "Today";
    } else if (date.day == tomorrow.day && date.month == tomorrow.month && date.year == tomorrow.year) {
      return "Tomorrow";
    } else {
      return date.day.toString();
    }
  }
}