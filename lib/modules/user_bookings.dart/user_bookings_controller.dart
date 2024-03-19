import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:m3m_tennis_booking/common/services/storage_service.dart';
import 'package:m3m_tennis_booking/utils/app_constants.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';

class UserBookingsController extends GetxController {
  final RxBool _isUpcomingBookingType = RxBool(true);

  final RxString _userId = RxString(StorageService.instance.fetch(AppConstants.userId));

  final RxList _upcomingBookings = RxList([]);
  final RxList _completedBookings = RxList([]);

  final RxBool _isFetchingBookings = RxBool(false);

  final RxList _membersList = RxList([]);

  final RxMap _memberMap = RxMap({
    "name": "",
    "mobile": "",
  }); 

  Map get memberMap => _memberMap;

  List get membersList => _membersList;

  bool get isFetchingBookings => _isFetchingBookings.value;

  List get completedBookings => _completedBookings;
  List get upcomingBookings => _upcomingBookings;

  String get userId => _userId.value;

  bool get isUpcomingBookingType => _isUpcomingBookingType.value;


  @override
  void onInit() {
    super.onInit();
    fetchUserBookings();
  }

  updateisUpcomingBookingType(bool value) {
    _isUpcomingBookingType.value = value;
    update();
  }

  updateIsFetchingBookings(bool value) {
    _isFetchingBookings.value = value;
    update();
  }

  convertDate(String date) {
    var data = DateFormat('yy-MM-dd').parse(date);
    return DateFormat('dd MMM yyyy').format(data);
  }

  addOneHour(String date) {
    DateTime parsedTime = DateFormat('h:mm a').parse(date);
    DateTime newTime = parsedTime.add(const Duration(minutes: 60));
    return DateFormat('h:mm a').format(newTime);
  }

  addMemberToMemberList(Map memberMap, String bookingId) {
    if (membersList.length < 3) {
      _membersList.add(memberMap);
      // will need bookingId also
      update();
    } else {
      Get.snackbar("Members", "You can add only 3 members");
    }
  }

  removeMemberFromMemberList(int index) {
    _membersList.removeAt(index);
    update();
  }

  fetchUserBookings() async {
    updateIsFetchingBookings(true);
    try {
      DocumentSnapshot snapshot = await FirebaseFirestore.instance.collection("users").doc(userId).get();

      List<Map<String, dynamic>> bookings = List<Map<String, dynamic>>.from(snapshot["bookings"] ?? []);

      for (int i = 0; i < bookings.length; i++) {
        String bookingDateTime = "${bookings[i]["date"]}_${bookings[i]["startTime"]}";
        DateTime bookingDateTimeObj = DateFormat('yy-MM-dd_h:mm a').parse(bookingDateTime);

        if (bookingDateTimeObj.isBefore(DateTime.now())) {
          _completedBookings.add(bookings[i]);
        } else {
          _upcomingBookings.add(bookings[i]);
        }
      }

      print("completed bookings - ${completedBookings.length}");
      print("upcoming bookings - ${upcomingBookings.length}");
      print(completedBookings);
      print(upcomingBookings);
      updateIsFetchingBookings(false);
    } catch (e) {
      Get.snackbar("Error", e.toString());
      print(e.toString());
      updateIsFetchingBookings(false);
    }
  }

  Future addMembersIntoBooking({ required String bookingID, required String memberName, required String memberPhoneNumber}) async {
  try {
    DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('users').doc(userId).get();
    List<dynamic>? currentUserBookings = userDoc["bookings"];

    DocumentSnapshot bookingDoc = await FirebaseFirestore.instance.collection('bookings').doc("_bookings").get();
    List<dynamic>? currentAllBookings = bookingDoc["allBookings"];

    if (currentUserBookings != null && currentAllBookings != null) {
      int userIndex = currentUserBookings.indexWhere((booking) => booking["bookingId"] == bookingID);

      int allBookingsIndex = currentAllBookings.indexWhere((booking) => booking["bookingId"] == bookingID);

      if (userIndex != -1 && allBookingsIndex != -1) {
        List existingMembers = List.from(currentUserBookings[userIndex]["members"]);
        List existingAllBookingsMembers = List.from(currentAllBookings[allBookingsIndex]["members"]);

        existingMembers.add({"userName": memberName, "userMobile": memberPhoneNumber});
        existingAllBookingsMembers.add({"userName": memberName, "userMobile": memberPhoneNumber});

        Map<String, dynamic> updatedUserBooking = {
          ...currentUserBookings[userIndex],
          "members": existingMembers,
        };

        currentUserBookings[userIndex] = updatedUserBooking;

        Map<String, dynamic> updatedAllBookingsBooking = {
          ...currentAllBookings[allBookingsIndex],
          "members": existingAllBookingsMembers,
        };

        currentAllBookings[allBookingsIndex] = updatedAllBookingsBooking;

        // Update the user's bookings
        await FirebaseFirestore.instance.collection('users').doc(userId).update({
          "bookings": currentUserBookings,
        });

        // Update the allBookings list
        await FirebaseFirestore.instance.collection('bookings').doc("_bookings").update({
          "allBookings": currentAllBookings,
        });

        Get.snackbar("Booking", "Member added to booking successfully!");
      } else {
        Get.snackbar("Booking", "Booking not found with the provided bookingID.");
      }
    } else {
      Get.snackbar("Booking", "No bookings found for the user or in allBookings list.");
    }
  } catch (e) {
    print("Error adding member: $e");
    Get.snackbar("Error", "$e");
  }
}
}
