// import 'package:flutter/material.dart';

// class BookingCalendarScreen extends StatefulWidget {
//   @override
//   _BookingCalendarScreenState createState() => _BookingCalendarScreenState();
// }

// class _BookingCalendarScreenState extends State<BookingCalendarScreen> {
//   DateTime selectedDate = DateTime.now();
//   String selectedTimeSlot = ''; // New variable to keep track of the selected time slot for the entire day

//   // Placeholder availability data for both courts
//   Map<String, List<String>> notAvailableTimings = {
//     'East Court': ['11:00 AM', '1:00 PM', '3:00 PM', '5:00 PM', '7:00 PM', '9:00 PM'],
//     'West Court': ['8:00 AM', '10:00 AM', '12:00 PM', '2:00 PM', '6:00 PM', '8:00 PM', '10:00 PM'],
//   };

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         top: true,
//         bottom: true,
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               _buildDatePicker(),
//               _showCourtNames(),
//               _buildTimeSlots(),
//             ],
//           ),
//         ),
//       ),
//       bottomNavigationBar: _buildDateTabs(),
//     );
//   }

//   Widget _showCourtNames() {
//     return Row(
//       children: [
//         const SizedBox(width: 80),
//         Row(
//           children: const [
//             Text(
//               'East Court',
//               style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.amber),
//             ),
//             Text(
//               'West Court',
//               style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.amber),
//             ),
//           ],
//         ),
//       ],
//     );
//   }

//   Widget _buildDatePicker() {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceAround,
//       children: [
//         Text(
//           '${selectedDate.toLocal()}'.split(' ')[0],
//           style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.amber),
//         ),
//       ],
//     );
//   }

//   Widget _buildTimeSlots() {
//     List<String> timeSlots = [
//       '8:00 AM',
//       '9:00 AM',
//       '10:00 AM',
//       '11:00 AM',
//       '12:00 PM',
//       '1:00 PM',
//       '2:00 PM',
//       '3:00 PM',
//       '4:00 PM',
//       '5:00 PM',
//       '6:00 PM',
//       '7:00 PM',
//       '8:00 PM',
//       '9:00 PM',
//       '10:00 PM',
//     ];

//     return Container(
//       height: 150 * timeSlots.length.toDouble(),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // Timings on the left side for both courts
//           _buildTimeColumn(timeSlots),
//           // Vertical Divider
//           const VerticalDivider(width: 1, color: Colors.black),
//           // Available time slots for both courts
//           _buildCourtAvailability(timeSlots),
//         ],
//       ),
//     );
//   }

//   Widget _buildTimeColumn(List<String> timeSlots) {
//     return Container(
//       width: 80,
//       child: Column(
//         children: timeSlots.map((time) {
//           return Container(
//             height: 120,
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.start,
//               children: [
//                 Text(time),
//               ],
//             ),
//           );
//         }).toList(),
//       ),
//     );
//   }

//   Widget _buildCourtAvailability(List<String> timeSlots) {
//     return Expanded(
//       child: Column(
//         children: [
//           Expanded(
//             child: ListView.builder(
//               shrinkWrap: true,
//               physics: const NeverScrollableScrollPhysics(),
//               itemCount: timeSlots.length,
//               itemBuilder: (context, index) {
//                 String timeSlot = timeSlots[index];

//                 return Row(
//                   children: [
//                     _buildAvailabilityBox('East Court', timeSlot),
//                     const VerticalDivider(width: 1, color: Colors.black),
//                     _buildAvailabilityBox('West Court', timeSlot),
//                   ],
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildAvailabilityBox(String courtName, String timeSlot) {
//     bool isAvailable = !(notAvailableTimings[courtName]?.contains(timeSlot) ?? true);
//     bool isSelected = selectedTimeSlot == timeSlot;

//     return Expanded(
//       child: GestureDetector(
//         onTap: () {
//           if (isAvailable) {
//             setState(() {
//               // Toggle selectedTimeSlot for the entire day
//               selectedTimeSlot = (isSelected ? '' : timeSlot);
//             });
//           }
//         },
//         child: Column(
//           children: [
//             Container(
//               color: isAvailable ? (isSelected ? Colors.blue : Colors.black) : Colors.red,
//               height: 120,
//               child: Center(
//                 child: Text(
//                   timeSlot,
//                   style: TextStyle(color: Colors.white),
//                 ),
//               ),
//             ),
//             const Divider(height: 1, color: Colors.black),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildDateTabs() {
//     // Generate date tabs based on the selected date
//     List<Widget> tabs = [];
//     for (int i = 0; i < 7; i++) {
//       DateTime tabDate = selectedDate.add(Duration(days: i));
//       bool isSelected = i == 0; // Highlight the first tab as selected

//       tabs.add(
//         Expanded(
//           child: GestureDetector(
//             onTap: () {
//               setState(() {
//                 selectedDate = tabDate;
//                 selectedTimeSlot = ''; // Reset selected time slot when changing the date
//               });
//             },
//             child: Container(
//               color: isSelected ? Colors.blue : Colors.grey,
//               child: Center(
//                 child: Text(
//                   '${tabDate.toLocal()}'.split(' ')[0],
//                   style: TextStyle(
//                     color: isSelected ? Colors.white : Colors.black,
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ),
//       );
//     }

//     return Container(
//       height: 60,
//       child: Row(children: tabs),
//     );
//   }
// }