import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';
import 'package:m3m_tennis_booking/common/services/storage_service.dart';
import 'package:m3m_tennis_booking/routes/app_routes.dart';
import 'package:m3m_tennis_booking/utils/app_constants.dart';
import 'package:permission_handler/permission_handler.dart';

class BookingController extends GetxController {
  final RxString _userId = RxString(StorageService.instance.fetch(AppConstants.userId));
  final RxString _userName = RxString(StorageService.instance.fetch(AppConstants.userName));
  final RxString _userMobile = RxString(StorageService.instance.fetch(AppConstants.userMobile));
  final RxList _upcomingBookings = RxList([]);
  final RxList _completedBookings = RxList([]);
  final RxString _courtSide = RxString("east");
  final RxBool _isBooking = RxBool(false);
  final RxString _selectedDate = RxString(DateFormat('yy-MM-dd').format(DateTime.now()));
  final RxString _selectedTime = RxString("9:00 PM");
  final RxList _membersList = RxList([]);
  final RxMap _memberMap = RxMap({
    "name": "",
    "mobile": "",
  });
  Map get memberMap => _memberMap;
  List get membersList => _membersList;
  String get selectedDate => _selectedDate.value;
  String get selectedTime => _selectedTime.value;
  bool get isBooking => _isBooking.value;
  String get courtSide => _courtSide.value;
  List get completedBookings => _completedBookings;
  List get upcomingBookings => _upcomingBookings;
  String get userMobile => _userMobile.value;
  String get userName => _userName.value;
  String get userId => _userId.value;

  @override
  void onInit() {
    super.onInit();
    //fetchUserBookings();
    // addUserBooking();
    //addMembersIntoBooking(bookingID: "east_24-01-26_ZvOPPeyNBNW3mZQw6u53V8YtP9H3",memberName: "newMem", memberPhoneNumber:"9857422222");
    //removeMemberFromBooking(bookingID: "east_24-01-26_ZvOPPeyNBNW3mZQw6u53V8YtP9H3", memberPhoneNumber:"9857422222");
  }

  updateSelectedDate(DateTime value) {
    _selectedDate.value = DateFormat('yy-MM-dd').format(value);
    _selectedTime.value = DateFormat('h:mm a').format(value);
    update();
  }

  updateIsBooking(bool value) {
    _isBooking.value = value;
    update();
  }

  formatDate(String date) {
    var data = DateFormat('yy-MM-dd').parse(date);
    return DateFormat('dd MMM yyyy').format(data);
  }

  addOneHour(String date) {
    DateTime parsedTime = DateFormat('h:mm a').parse(date);
    DateTime newTime = parsedTime.add(const Duration(minutes: 60));
    return DateFormat('h:mm a').format(newTime);
  }

  addMemberToMemberList(
    Map memberMap,
  ) {
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

  addUserBooking() async {
    updateIsBooking(true);
    try {
      DocumentReference bookingDocRef = FirebaseFirestore.instance.collection('bookings').doc("_bookings");

      DocumentSnapshot bookingsDoc = await bookingDocRef.get();
      List<dynamic>? allBookings = bookingsDoc["allBookings"];

      // Check if the user is currently playing
      bool isPlayingNow = allBookings?.any((booking) {
            String existingUserId = booking["userId"];
            String existingStartTime = booking["startTime"];
            DateTime startTime = DateFormat("hh:mm a").parse(existingStartTime);
            DateTime endTime = startTime.add(const Duration(hours: 1));
            DateTime currentTime = DateTime.now();
            return existingUserId == userId && currentTime.isAfter(startTime) && currentTime.isBefore(endTime);
          }) ??
          false;

      // Check if the user has already booked for the date
      bool hasBookingForDate = allBookings?.any((booking) {
            String existingDate = booking["date"];
            String existingUserId = booking["userId"];
            return existingDate == selectedDate && existingUserId == userId;
          }) ??
          false;

      // Check if booking already exists for date and time
      bool isBookingExists = allBookings?.any((booking) {
            String existingDate = booking["date"];
            String existingStartTime = booking["startTime"];
            return existingDate == selectedDate && existingStartTime == selectedTime;
          }) ??
          false;

      // if (isPlayingNow) {
      //   Get.snackbar("Warning", "You cannot book while you are currently playing");
      // }
      // else if (hasBookingForDate) {
      //   Get.snackbar("Warning", "You can have only one booking per day");
      // }
      // else if (isBookingExists) {
      //  Get.snackbar("Warning", "Booking already done for this date and time");
      //}
      //else {
      // Add the new booking to the "allBookings" list
      await bookingDocRef.update({
        "allBookings": FieldValue.arrayUnion([
          {
            "userId": userId,
            "bookingId": "${courtSide}_${selectedDate}_$userId",
            "court": courtSide,
            "date": selectedDate,
            "startTime": selectedTime,
            "members": [
              {"userName": userName, "userMobile": userMobile}
            ],
            "bookedOn": DateTime.now().toString(),
          }
        ]),
      });

      // Saving in User Bookings array
      DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('users').doc(userId).get();
      List<dynamic>? currentBookings = userDoc["bookings"];

      Map<String, dynamic> newBooking = {
        "userId": userId,
        "bookingId": "${courtSide}_${selectedDate}_$userId",
        "court": courtSide,
        "date": selectedDate,
        "startTime": selectedTime,
        "members": [
          {"userName": userName, "userMobile": userMobile},
        ],
        "bookedOn": DateTime.now().toString(),
      };

      if (currentBookings == null) {
        currentBookings = [newBooking];
      } else {
        currentBookings.add(newBooking);
      }

      // Update the user's bookings
      await FirebaseFirestore.instance.collection('users').doc(userId).update({
        "bookings": currentBookings,
      });

      updateIsBooking(false);
      Get.snackbar("Success", "Booking added successfully");
      Navigator.pop(Get.context!);
      Get.toNamed(AppRoutes.bookingSuccessRoute);
      //}
    } catch (e) {
      Get.snackbar("Error", "Error adding Booking");
      updateIsBooking(false);
    }
  }

  Future addMembersIntoBooking({required String bookingID, required String memberName, required String memberPhoneNumber}) async {
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

  Future removeMemberFromBooking({required String bookingID, required String memberPhoneNumber}) async {
    try {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('users').doc(userId).get();
      List<dynamic>? currentUserBookings = userDoc["bookings"];

      DocumentSnapshot bookingDoc = await FirebaseFirestore.instance.collection('bookings').doc("_bookings").get();
      List<dynamic>? currentAllBookings = bookingDoc["allBookings"];

      if (currentUserBookings != null && currentAllBookings != null) {
        int userIndex = currentUserBookings.indexWhere((booking) => booking["bookingId"] == bookingID);

        int allBookingsIndex = currentAllBookings.indexWhere((booking) => booking["bookingId"] == bookingID);

        if (userIndex != -1 && allBookingsIndex != -1) {
          List<dynamic> existingMembers = List.from(currentUserBookings[userIndex]["members"]);
          List<dynamic> existingAllBookingsMembers = List.from(currentAllBookings[allBookingsIndex]["members"]);

          existingMembers.removeWhere((member) => member["userMobile"] == memberPhoneNumber);
          existingAllBookingsMembers.removeWhere((member) => member["userMobile"] == memberPhoneNumber);

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

          print("Member removed from booking successfully!");
        } else {
          print("Booking not found with the provided bookingID.");
        }
      } else {
        print("No bookings found for the user or in allBookings list.");
      }
    } catch (e) {
      print("Error removing member: $e");
    }
  }

  Future deleteBooking(String bookingID) async {
    try {
      DocumentReference bookingDocRef = FirebaseFirestore.instance.collection('bookings').doc("_bookings");

      DocumentSnapshot bookingsDoc = await bookingDocRef.get();
      List<dynamic>? allBookings = bookingsDoc["allBookings"];

      DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('users').doc(userId).get();
      List<dynamic>? currentUserBookings = userDoc["bookings"];

      if (allBookings != null && currentUserBookings != null) {
        int allBookingsIndex = allBookings.indexWhere((booking) => booking["bookingId"] == bookingID);

        if (allBookingsIndex != -1) {
          allBookings.removeAt(allBookingsIndex);

          await bookingDocRef.update({
            "allBookings": allBookings,
          });

          int userIndex = currentUserBookings.indexWhere((booking) => booking["bookingId"] == bookingID);

          if (userIndex != -1) {
            currentUserBookings.removeAt(userIndex);

            await FirebaseFirestore.instance.collection('users').doc(userId).update({
              "bookings": currentUserBookings,
            });

            Get.snackbar("Success", "Booking deleted successfully");
          } else {
            print("Booking not found in the user's list.");
          }
        } else {
          print("Booking not found in the allBookings list.");
        }
      } else {
        print("No bookings found for the user or in allBookings list.");
      }
    } catch (e) {
      print("Error deleting booking: $e");
    }
  }

  Future<void> _askPermissions() async {
    PermissionStatus permissionStatus = await _getContactPermission();
    if (permissionStatus != PermissionStatus.granted) {
      _handleInvalidPermissions(permissionStatus);
    }
  }

  Future<PermissionStatus> _getContactPermission() async {
    PermissionStatus permission = await Permission.contacts.status;
    if (permission != PermissionStatus.granted && permission != PermissionStatus.permanentlyDenied) {
      PermissionStatus permissionStatus = await Permission.contacts.request();
      return permissionStatus;
    } else {
      return permission;
    }
  }

  void _handleInvalidPermissions(PermissionStatus permissionStatus) {
    if (permissionStatus == PermissionStatus.denied) {
      Get.snackbar("Permisssion", "Access to contact data denied");
    } else if (permissionStatus == PermissionStatus.permanentlyDenied) {
      Get.snackbar("Permisssion", "Contact data not available on device");
    }
  }
}
